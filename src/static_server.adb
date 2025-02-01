pragma Extensions_Allowed (On);

with Ada.Strings;
with Ada.Text_IO;
with Ada.IO_Exceptions;

with HTTP;

with GNAT.Sockets;

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
               Client_Message : HTTP.Client_Message := HTTP.Client_Message'Input
                                                       (my_Channel);
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
               if Client_Message.Method /= HTTP.GET then
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
               end;

               Server_Message.Status := 200;
               Server_Message.Headers.Include
                  ("Content-Type",
                   HTTP.MIME_From_Extension (Extension, Dot_Index = 0) &
                   "; charset=utf-8");
               Server_Message.Transmission_Type := HTTP.CHUNKED;

               Chunk_Loop : loop
                  declare
                     Chunk : String (1 .. Integer'Min (2 ** 16,
                                                      Integer (File.Size -
                                                      (File.Index - 1))));
                  begin
                     String'Read (File_Stream, Chunk);
                     Server_Message.Data.Append (Chunk);
                     exit Chunk_Loop when File.Index > File.Size;
                  end;
               end loop Chunk_Loop;

               <<Send>>
               if File.Is_Open then
                  Close (File);
               end if;
               HTTP.Server_Message'Write (my_Channel, Server_Message);
            end;
         end loop;
      exception
         when GNAT.Sockets.Socket_Error    |
              End_Error                    |
              Ada.IO_Exceptions.Name_Error =>
            null;
         when E : others =>
            Ada.Text_IO.Put_Line (E.Exception_Information);
      end;
      my_Channel.Free;
      GNAT.Sockets.Close_Socket (my_Connection);
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
      Option => (Name    => GNAT.Sockets.Reuse_Address, Enabled => True));
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