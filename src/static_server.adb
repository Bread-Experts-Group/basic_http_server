with Ada.Strings;
with Ada.Text_IO;
with Ada.IO_Exceptions;

with TLS;

with GNAT.Sockets;

with HTTP; use HTTP;

with Ada.Directories;       use Ada.Directories;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

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
               Request  : Client_Message := Client_Message'Input (my_Channel);
               Response : Server_Message;

               File_Stream  : Stream_Access;
               Dot_Index    : constant Natural := Index (Request.Path,
                                                         ".",
                                                         Ada.Strings.Backward);
               Extension    : constant String  := Tail (Request.Path,
                                                        Request.Path'Length -
                                                        Dot_Index,
                                                        ' ');
            begin
               Request.Data.Free;
               if Request.Method not in GET | HEAD then
                  Response.Status := 405;
                  goto Send;
               end if;

               declare
                  Not_File : exception;
               begin
                  if Kind (".." & Request.Path) /= Ordinary_File then
                     raise Not_File;
                  end if;
                  Open (File, In_File, ".." & Request.Path, "shared=no");
                  File_Stream := Stream (File);
               exception
                  when Not_File =>
                     Response.Status := 400;
                     goto Send;
                  when Ada.IO_Exceptions.Name_Error =>
                     Response.Status := 404;
                     goto Send;
                  when Ada.IO_Exceptions.Use_Error =>
                     Response.Status := 503;
                     goto Send;
               end;

               --  "; charset=utf-8"
               Response.Status := 200;
               Response.Headers.Include
                  ("Content-Type",
                   MIME_From_Extension (Extension, Dot_Index = 0));
               Response.Headers.Include
                  ("Accept-Ranges", "bytes");
               Response.Transmission_Type := CONTENT_LENGTH;

               declare
                  Count        : Integer;
                  Range_Result : constant Range_Parsing_Result :=
                     Read_Range_Header
                        ((if Request.Headers.Contains ("Range")
                          then Request.Headers.Element ("Range")
                          else " bytes=0-"),
                        Integer (File.Size));
               begin
                  case Range_Result.OK is
                     when True =>
                        if
                           Integer (Range_Result.Ranges.Length) > 1 or else
                           Range_Result.Ranges.First_Element.From /= 0 or else
                           Range_Result.Ranges.First_Element.To /=
                              Integer (File.Size)
                        then
                           Response.Status := 206;
                        end if;
                        for Local_Range of Range_Result.Ranges loop
                           Response.Headers.Include
                              ("Content-Range",
                              "bytes " &
                              Truncate (Integer'Image (Local_Range.From - 1)) &
                              '-' &
                              Truncate (Integer'Image (Local_Range.To - 1)) &
                              '/' &
                              Truncate (File.Size'Image));
                           goto Next_Range when Request.Method = HEAD;
                           File.Set_Index (Positive_Count (Local_Range.From));
                           Count := (Local_Range.To - Local_Range.From) + 1;
                           Chunk_Loop : loop
                              declare
                                 Chunk : String (1 ..
                                                 Integer'Min (2 ** 16, Count));
                              begin
                                 String'Read (File_Stream, Chunk);
                                 Response.Data.Append (Chunk);
                                 Count := @ - Chunk'Length;
                                 exit Chunk_Loop when Count = 0;
                              end;
                           end loop Chunk_Loop;
                           <<Next_Range>>
                        end loop;
                     when False =>
                        Response := Range_Result.Error;
                        goto Send;
                  end case;
               exception
                  when End_Error =>
                     Ada.Text_IO.Put_Line ("EE");
                     Response.Status := 416;
                     Response.Headers.Clear;
                     Response.Transmission_Type := NONE;
               end;

               <<Send>>
               if File.Is_Open then
                  Close (File);
               end if;
               Write_Server_Message_No_Data (my_Channel, Response);
               Write_Server_Message_Data (my_Channel, Response);
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