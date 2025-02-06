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

   procedure Handle_GET_HEAD
      (Request  :        Client_Message;
       Response :    out Server_Message;
       File     : in out File_Type)
   is separate;

   procedure Handle_PUT
      (Request  :        Client_Message;
       Response :    out Server_Message;
       File     : in out File_Type;
       Channel  :        GNAT.Sockets.Stream_Access)
   is separate;

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
               Request  : constant Client_Message := Client_Message'Input
                                                     (my_Channel);
               Response : Server_Message;
            begin
               case Request.Method is
                  when GET | HEAD =>
                     Handle_GET_HEAD (Request, Response, File);
                     Write_Server_Message_No_Data (my_Channel, Response);
                     Write_Server_Message_Data (my_Channel, Response);
                  when PUT =>
                     Handle_PUT (Request, Response, File, my_Channel);
                  when others =>
                     Response.Status := 405;
                     Write_Server_Message_No_Data (my_Channel, Response);
               end case;

               if File.Is_Open then
                  Close (File);
               end if;
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