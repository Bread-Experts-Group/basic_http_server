pragma Extensions_Allowed (All);

with Ada.Strings;
with Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Containers.Vectors;

with HTTP;
with TLS;

with GNAT.Sockets;

with Ada.Directories;       use Ada.Directories;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Static_Server is
   Receiver   : GNAT.Sockets.Socket_Type;
   Connection : GNAT.Sockets.Socket_Type;
   Client     : GNAT.Sockets.Sock_Addr_Type;

   task type Socket_Task is
      entry Setup (Connection : GNAT.Sockets.Socket_Type);
      entry Start;
   end Socket_Task;

   task body Socket_Task is
      my_Connection : GNAT.Sockets.Socket_Type;
      my_Channel    : GNAT.Sockets.Stream_Access;

      File : File_Type;
   begin
      accept Setup (Connection : GNAT.Sockets.Socket_Type)
      do
         my_Connection := Connection;
      end Setup;
      my_Channel := GNAT.Sockets.Stream (my_Connection);
      accept Start;
      begin
         loop
            declare
               Client_Message : HTTP.Client_Message :=
                  HTTP.Client_Message'Input (my_Channel);
               Path           : String renames Client_Message.Path;

               Server_Message : HTTP.Server_Message;

               File_Stream  : Stream_Access;
               Dot_Index    : constant Natural := Index (Path,
                                                         ".",
                                                         Ada.Strings.Backward);
               Extension    : constant String  := Tail (Path,
                                                        Path'Length -
                                                        Dot_Index,
                                                        ' ');
               use type HTTP.HTTP_Method;
            begin
               Client_Message.Data.Free;
               if Client_Message.Method not in HTTP.GET | HTTP.HEAD then
                  Server_Message.Status := 405;
                  goto Send;
               end if;

               declare
                  Not_File : exception;
               begin
                  if Kind (".." & Path) /= Ordinary_File then
                     raise Not_File;
                  end if;
                  Open (File, In_File, ".." & Path, "shared=no");
                  File_Stream := Stream (File);
               exception
                  when Not_File =>
                     Server_Message.Status := 400;
                     goto Send;
                  when Ada.IO_Exceptions.Name_Error =>
                     Server_Message.Status := 404;
                     goto Send;
                  when Ada.IO_Exceptions.Use_Error =>
                     Server_Message.Status := 503;
                     goto Send;
               end;

               --  "; charset=utf-8"
               Server_Message.Status := 200;
               Server_Message.Headers.Include
                  ("Content-Type",
                   HTTP.MIME_From_Extension (Extension, Dot_Index = 0));
               Server_Message.Headers.Include
                  ("Accept-Ranges", "bytes");
               Server_Message.Transmission_Type := HTTP.CONTENT_LENGTH;

               declare
                  type Response_Range is record
                     From, To : Integer range -1 .. Integer'Last;
                  end record;

                  package Range_Vectors is new Ada.Containers.Vectors
                     (Positive, Response_Range);

                  Range_Data : constant String :=
                     (if Client_Message.Headers.Contains ("Range")
                      then Client_Message.Headers.Element ("Range")
                      else " ");
                  Ranges : Range_Vectors.Vector;

                  From, To : Unbounded_String;
                  Read_To  : Boolean := False;
                  Char     : Character;

                  Read_Size, Count : Integer;
               begin
                  if
                     Range_Data'Length > 6 and then
                     Range_Data (Range_Data'First ..
                                 Range_Data'First + 5) = "bytes=" and then
                     Range_Data /= "bytes=0-"
                  then
                     for Index in 8 .. Range_Data'Last loop
                        Char := Range_Data (Index);
                        case Char is
                           when '-' =>
                              if Read_To then
                                 Server_Message.Status := 400;
                                 Server_Message.Headers.Clear;
                                 Server_Message.Transmission_Type := HTTP.NONE;
                                 goto Send;
                              end if;
                              Read_To := True;
                           when ',' =>
                              --  TODO, multipart ranging
                              Server_Message.Status := 501;
                              Server_Message.Headers.Clear;
                              Server_Message.Transmission_Type := HTTP.NONE;
                              goto Send;
                           when others =>
                              if Read_To then
                                 To.Append (Char);
                              else
                                 From.Append (Char);
                              end if;
                        end case;
                        goto Add when Index = Range_Data'Last;
                        goto Next;
                        <<Add>>
                        Read_To := False;
                        declare
                           From_I : Integer := -1;
                           To_I   : Integer := -1;
                        begin
                           begin
                              From_I := Natural'Value (From.To_String) + 1;
                           exception
                              when Constraint_Error =>
                                 null;
                           end;

                           begin
                              To_I := Natural'Value (To.To_String) + 1;
                           exception
                              when Constraint_Error =>
                                 null;
                           end;

                           if From_I = -1 then
                              From_I := Integer (File.Size) - To_I;
                              To_I := Integer (File.Size);
                              raise Program_Error;
                           elsif To_I = -1 then
                              To_I := Integer (File.Size);
                           end if;

                           Read_Size := @ + (To_I - From_I) + 1;

                           Ranges.Append (Response_Range'(From_I, To_I));
                        end;
                        To.Delete (1, To.Length);
                        From.Delete (1, From.Length);
                        <<Next>>
                     end loop;
                     Server_Message.Status := 206;
                  else
                     Ranges.Append (Response_Range'(1, Integer (File.Size)));
                     Read_Size := Integer (File.Size);
                  end if;

                  declare
                     Img : constant String := Read_Size'Image;
                     Trc : constant String := Img (Img'First + 1 .. Img'Last);
                  begin
                     Server_Message.Headers.Include ("Content-Length", Trc);
                  end;

                  goto Send when Client_Message.Method = HTTP.HEAD;

                  for Local_Range of Ranges loop
                     Ada.Text_IO.Put_Line (Local_Range'Image);
                     File.Set_Index (Positive_Count (Local_Range.From));
                     Count := (Local_Range.To - Local_Range.From) + 1;
                     goto Bad_Range when Count < 1;
                     Chunk_Loop : loop
                        declare
                           Chunk : String (1 .. Integer'Min (2 ** 16, Count));
                        begin
                           String'Read (File_Stream, Chunk);
                           Server_Message.Data.Append (Chunk);
                           Count := @ - Chunk'Length;
                           exit Chunk_Loop when Count = 0;
                        end;
                     end loop Chunk_Loop;
                  end loop;
               exception
                  when End_Error =>
                     goto Bad_Range;
               end;
               goto Send;

               <<Bad_Range>>
               Server_Message.Status := 416;
               Server_Message.Headers.Clear;
               Server_Message.Transmission_Type := HTTP.NONE;
               <<Send>>
               HTTP.Write_Server_Message_No_Data (my_Channel, Server_Message);
               <<Send_Data>>
               if File.Is_Open then
                  Close (File);
               end if;
               HTTP.Write_Server_Message_Data (my_Channel, Server_Message);
            end;
         end loop;
      exception
         when GNAT.Sockets.Socket_Error    |
              End_Error                    |
              Ada.IO_Exceptions.Name_Error =>
            null;
         when E : Constraint_Error =>
            Ada.Text_IO.Put_Line ("Constraint error: " & E.Exception_Message);
         when E : others =>
            Ada.Text_IO.Put_Line (E.Exception_Information);
      end;
      GNAT.Sockets.Close_Socket (my_Connection);
      my_Channel.Free;
      if File.Is_Open then
         Close (File);
      end if;
   end Socket_Task;

   type Socket_Task_Access is access Socket_Task;
begin
   GNAT.Sockets.Create_Socket (Socket => Receiver);
   GNAT.Sockets.Set_Socket_Option
     (Socket => Receiver,
      Level  => GNAT.Sockets.Socket_Level,
      Option => (Name    => GNAT.Sockets.Reuse_Address,
                 Enabled => True));
   GNAT.Sockets.Bind_Socket
     (Socket  => Receiver,
      Address => (Family => GNAT.Sockets.Family_Inet,
                  Addr   => GNAT.Sockets.Inet_Addr ("0.0.0.0"),
                  Port   => 7777));
   GNAT.Sockets.Listen_Socket (Socket => Receiver);
   loop
      GNAT.Sockets.Accept_Socket
      (Server  => Receiver,
       Socket  => Connection,
       Address => Client);
      declare
         New_Task : constant Socket_Task_Access := new Socket_Task;
      begin
         New_Task.Setup (Connection);
         New_Task.Start;
      end;
   end loop;
end Static_Server;