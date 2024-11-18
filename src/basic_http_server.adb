with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.IO_Exceptions;
with Ada.Directories;
use Ada.Directories;
with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with GNAT.OS_Lib;
with GNAT.Sockets;
with GNAT.Strings;
with GNAT.Command_Line;
use GNAT.Command_Line;

with Extensible_HTTP;
use Extensible_HTTP;
with Extensible_HTTP.HTTP11;
use Extensible_HTTP.HTTP11;
with Extensible_HTTP.Base64;
use Extensible_HTTP.Base64;

with TLS;

procedure Basic_HTTP_Server is

   Tasks_To_Create : constant := 50;

   type Integer_List is
     array (1 .. Tasks_To_Create)
     of Integer;
   subtype Counter is Integer range 0 .. Tasks_To_Create;
   subtype Index is Integer range 1 .. Tasks_To_Create;

   protected type Info is
      procedure Push_Stack (Return_Task_Index : Index);
      procedure Initialize_Stack;
      entry Pop_Stack (Get_Task_Index : out Index);

   private
      Task_Stack    : Integer_List; -- Stack of free-to-use tasks.
      Stack_Pointer : Counter := 0;

   end Info;

   protected body Info is

      procedure Push_Stack (Return_Task_Index : Index) is
      begin
         Stack_Pointer              := Stack_Pointer + 1;
         Task_Stack (Stack_Pointer) := Return_Task_Index;
      end Push_Stack;

      entry Pop_Stack (Get_Task_Index : out Index) when Stack_Pointer /= 0 is
      begin
         Get_Task_Index := Task_Stack (Stack_Pointer);
         Stack_Pointer  := Stack_Pointer - 1;
      end Pop_Stack;

      procedure Initialize_Stack is
      begin
         for I in Task_Stack'Range
         loop
            Push_Stack (I);
         end loop;
      end Initialize_Stack;

   end Info;

   Config             : Command_Line_Configuration;
   No_TLS_Port_Option : aliased Integer                    := -1;
   TLS_Port_Option    : aliased Integer                    := -1;
   IP_Option          : aliased GNAT.Strings.String_Access := new String'("0.0.0.0");
   PUT_Username       : aliased GNAT.Strings.String_Access := new String'("<none>");
   PUT_Password       : aliased GNAT.Strings.String_Access := new String'("<none>");
   PUT_Directory      : aliased GNAT.Strings.String_Access := new String'(Current_Directory);

   Task_Info_Group : array (1 .. 2)
     of aliased Info;

   task type SocketTask is
      entry Setup (Connection : GNAT.Sockets.Socket_Type; Channel : GNAT.Sockets.Stream_Access; Index : Integer; Task_Info_Index : Integer; Start_TLS : Boolean);
      entry Start;

   end SocketTask;

   task body SocketTask is

      This_Connection : GNAT.Sockets.Socket_Type;
      This_Channel    : TLS.TLS_Stream_Access;
      This_Index      : Integer;
      This_Task_Info  : access Info;

      Search      : Search_Type;
      Search_Item : Directory_Entry_Type;

   begin
      loop
         accept Setup (Connection : GNAT.Sockets.Socket_Type; Channel : GNAT.Sockets.Stream_Access; Index : Integer; Task_Info_Index : Integer; Start_TLS : Boolean) do
            This_Connection := Connection;
            This_Channel    := TLS.Wrap_Stream (TLS.Stream_Access (Channel));
            This_Index      := Index;
            This_Task_Info  := Task_Info_Group (Task_Info_Index)'Access;

            if Start_TLS
            then
               This_Channel.Enable_TLS;
            end if;
         end Setup;

         accept Start;

         declare

            Request : HTTP_11_Request_Message;
            Send    : HTTP_11_Response_Message :=
              (Status => 500,
               others => <>);
            F       : File_Type;

         begin
            select
               delay 1.0;
               Send.Status := 408;
               goto Send_Response;
            then abort
               HTTP_11_Request_Message'Read (This_Channel.Stream, Request);
            end select;

            begin
               case Request.Method is
                  when GET
                     | HEAD
                     | PUT =>
                     declare

                        Target          : constant String := Request.Target.Element;
                        Composed_Path   : constant String := (if Target'Length > 1 then Current_Directory & '/' & Target (2 .. Target'Length) else Current_Directory);
                        Composed_Actual : constant String := Full_Name (Composed_Path);

                     begin
                        if Composed_Actual'Length < Current_Directory'Length or else Composed_Actual (1 .. Current_Directory'Length) /= Current_Directory
                        then
                           Send.Status := 403;
                           goto Send_Response;
                        end if;

                        case Request.Method is
                           when GET =>
                              if Exists (Composed_Actual)
                              then
                                 case Kind (Composed_Actual) is
                                    when Ordinary_File =>
                                       Open (F, In_File, Composed_Actual);

                                       declare

                                          S        : Stream_Access;
                                          Contents : Unbounded_String;

                                       begin
                                          S := Stream (F);

                                          while not End_Of_File (F)
                                          loop
                                             Contents.Append (Character'Input (S));
                                          end loop;
                                          Send.Message_Body.Replace_Element (Contents.To_String);
                                          Send.Status := 200;
                                       end;

                                    when Directory =>
                                       declare

                                          Contents    : Unbounded_String;
                                          Padded_Kind : String (1 .. Ordinary_File'Image'Length);
                                          Padded_Size : String (1 .. 12);

                                       begin
                                          Search.Start_Search (Directory => Composed_Actual, Pattern => "");

                                          while Search.More_Entries
                                          loop
                                             Search.Get_Next_Entry (Search_Item);

                                             if (Search_Item.Simple_Name = ".." and then Composed_Actual /= Current_Directory)
                                               or else (Search_Item.Simple_Name /= "." and then Search_Item.Simple_Name /= "..")
                                             then
                                                Ada.Strings.Fixed.Move (Search_Item.Kind'Image, Padded_Kind, Justify => Ada.Strings.Right);

                                                if Search_Item.Kind = Ordinary_File
                                                then
                                                   Ada.Strings.Fixed.Move (Search_Item.Size'Image & 'B', Padded_Size, Justify => Ada.Strings.Right);

                                                else
                                                   Ada.Strings.Fixed.Delete (Padded_Size, 1, Padded_Size'Length);
                                                end if;
                                                Contents.Append (Padded_Size & ' ' & Padded_Kind & ' ' & Search_Item.Simple_Name & ASCII.LF);
                                             end if;
                                          end loop;
                                          Search.End_Search;

                                          Send.Status := 200;
                                          Send.Fields.Include ("Content-Type", "text/plain; charset=utf-8");
                                          Send.Message_Body.Replace_Element (Contents.To_String);
                                       end;

                                    when Special_File =>
                                       Send.Status := 403;
                                 end case;

                              else
                                 Send.Status := 404;
                              end if;

                           when PUT =>
                              if PUT_Username.all = "<none>" and then PUT_Password.all = "<none>"
                              then
                                 goto PUT_Actual;
                              end if;

                              if Request.Fields.Contains ("Authorization")
                              then
                                 declare

                                    Authorization : String := Request.Fields.Element ("Authorization");

                                 begin
                                    if Authorization (1 .. 5) = "Basic"
                                    then
                                       declare

                                          Decoded   : String  := Decode_Base64 (Authorization (7 .. Authorization'Last));
                                          Delimiter : Natural := Ada.Strings.Fixed.Index (Decoded, ":", 1);

                                       begin
                                          if (PUT_Username.all = "<none>" or else Decoded (1 .. Delimiter - 1) = PUT_Username.all)
                                            and then (PUT_Password.all = "<none>" or else Decoded (Delimiter + 1 .. Decoded'Length) = PUT_Password.all)
                                          then
                                             goto PUT_Actual;
                                          end if;
                                       end;
                                    end if;
                                 end;
                              end if;
                              Send.Status := 403;
                              goto Send_Response;
                              <<PUT_Actual>>

                              if Exists (Composed_Actual) and then Kind (Composed_Actual) = Directory
                              then
                                 Send.Status := 409;

                              else
                                 if not Exists (Composed_Actual)
                                 then
                                    Create_Path (Composed_Actual);
                                    Delete_Directory (Composed_Actual);
                                    Send.Status := 201;

                                 else
                                    Send.Status := 204;
                                 end if;
                                 Create (F, Out_File, Composed_Actual);
                                 String'Write (Stream (F), Request.Message_Body.Element);
                                 Close (F);
                              end if;

                           when HEAD =>
                              Send.Status := 200;

                           when others =>
                              raise Program_Error;
                        end case;
                     end;

                  when others =>
                     Send.Status := 405;
               end case;
            exception
               when E : Ada.IO_Exceptions.Name_Error =>
                  Send.Status := 400;

               when E : others =>
                  Ada.Text_IO.Put_Line (E.Exception_Information);
                  Send.Status := 500;
            end;

            <<Send_Response>>

            if Is_Open (F)
            then
               Close (F);
            end if;
            HTTP_11_Response_Message'Write (This_Channel.Stream, Send);
         exception
            when Ada.Streams.Stream_IO.End_Error =>
               null;

            when E : others =>
               Ada.Text_IO.Put_Line ("Task" & This_Index'Image & ": " & E.Exception_Information);
         end;
         GNAT.Sockets.Close_Socket (This_Connection);
         This_Task_Info.Push_Stack (This_Index);
      end loop;
   end SocketTask;

   task type Server_Task (Port : Integer; Task_Info_Index : Integer; Start_TLS : Boolean);

   task body Server_Task is

      Task_Info : access Info := Task_Info_Group (Task_Info_Index)'Access;

      Receiver   : GNAT.Sockets.Socket_Type;
      Connection : GNAT.Sockets.Socket_Type;
      Client     : GNAT.Sockets.Sock_Addr_Type;
      Channel    : GNAT.Sockets.Stream_Access;
      Worker     : array (1 .. Tasks_To_Create)
        of SocketTask;
      Use_Task   : Index;

   begin
      GNAT.Sockets.Create_Socket (Socket => Receiver);
      GNAT.Sockets.Set_Socket_Option
        (Socket => Receiver,
         Level  => GNAT.Sockets.Socket_Level,
         Option =>
           (Name    => GNAT.Sockets.Reuse_Address,
            Enabled => True));
      GNAT.Sockets.Bind_Socket
        (Socket  => Receiver,
         Address =>
           (Family => GNAT.Sockets.Family_Inet,
            Addr   => GNAT.Sockets.Inet_Addr (IP_Option.all),
            Port   => GNAT.Sockets.Port_Type (Port)));
      GNAT.Sockets.Listen_Socket (Socket => Receiver);

      Task_Info.Initialize_Stack;
      Find :
         loop
            GNAT.Sockets.Accept_Socket (Server => Receiver, Socket => Connection, Address => Client);
            Channel := GNAT.Sockets.Stream (Connection);
            Task_Info.Pop_Stack (Use_Task);
            Worker (Use_Task).Setup (Connection, Channel, Use_Task, Task_Info_Index, Start_TLS);
            Worker (Use_Task).Start;
         end loop Find;
   end Server_Task;

   Servers : array (1 .. 2)
     of access Server_Task;

begin
   Define_Switch (Config, No_TLS_Port_Option'Access, "-ntp=", "--no-tls-port=", "Listen on specified port for HTTP", Initial => -1);
   Define_Switch (Config, TLS_Port_Option'Access, "-tp=", "--tls-port=", "Listen on specified port for HTTPS (TLS)", Initial => -1);
   Define_Switch (Config, IP_Option'Access, "-ip=", "--ip-address=", "Listen on specified IP for HTTP");
   Define_Switch (Config, PUT_Username'Access, "-u=", "--username=", "Restrict HTTP PUT requests to the specified username");
   Define_Switch (Config, PUT_Password'Access, "-w=", "--password=", "Restrict HTTP PUT requests to the specified password");
   Define_Switch (Config, PUT_Directory'Access, "-d=", "--directory=", "Save uploaded files from PUTs to this directory (will be HTTP root)");
   Define_Switch (Config, "-h", "--help", "Display help");

   begin
      Getopt (Config);

      if No_TLS_Port_Option = -1 and then TLS_Port_Option = -1
      then
         raise Constraint_Error with "At least one of the TLS or No_TLS port options must be set between 0 - 65535";

      elsif No_TLS_Port_Option > -1 and then No_TLS_Port_Option not in 0 .. 65_535
      then
         raise Constraint_Error with "No_TLS port must be within 0 - 65535";

      elsif TLS_Port_Option > -1 and then TLS_Port_Option not in 0 .. 65_535
      then
         raise Constraint_Error with "TLS port must be within 0 - 65535";

      elsif TLS_Port_Option = No_TLS_Port_Option
      then
         raise Constraint_Error with "TLS and No_TLS port must be separate";
      end if;
      Create_Path (PUT_Directory.all);
      Set_Directory (PUT_Directory.all);
   exception
      when Exit_From_Command_Line =>
         Ada.Text_IO.Put_Line (ASCII.LF & "Report problems to Bread Experts Group " & "[https://github.com/Bread-Experts-Group/basic_http_server]");
         GNAT.OS_Lib.OS_Exit (0);

      when E : others =>
         Ada.Text_IO.Put_Line ("Error reading arguments: " & E.Exception_Message);
         GNAT.OS_Lib.OS_Exit (1);
   end;

   if No_TLS_Port_Option > -1
   then
      Servers (1) := new Server_Task (No_TLS_Port_Option, 1, False);
   end if;

   if TLS_Port_Option > -1
   then
      Servers (2) := new Server_Task (TLS_Port_Option, 2, True);
   end if;
end Basic_HTTP_Server;
