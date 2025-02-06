pragma Extensions_Allowed (On);

with Ada.Integer_Text_IO;

with Ada.Streams;             use Ada.Streams;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Octet_Memory_Stream;     use Octet_Memory_Stream;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

package body HTTP is

   CL   : constant String := "Content-Length";
   TE   : constant String := "Transfer-Encoding";
   CRLF : constant String := ASCII.CR & ASCII.LF;

   --  Client Message  --

   function Input_Client_Message
      (Stream : not null access Root_Stream_Type'Class)
   return Client_Message is
      Method    : constant HTTP_Method := HTTP_Method'Value
                                          (Read_Until_Delimiter (Stream, " "));
      Path      : constant String := Read_Until_Delimiter (Stream, " ");
      discard   : constant String := Read_Until_Delimiter (Stream, "/");
      Version   : constant String := Read_Until_Delimiter (Stream, CRLF);
      Headers   : Header_Maps.Map;
      DPath     : Unbounded_String;
      MVersion  : HTTP_Version;
      TransM    : Data_Transmission_Type;

      Path_Index : Positive := 1;
   begin
      loop
         if
             Path (Path_Index) = '%' and then
            (Path (Path_Index + 1) in '0' .. '9' or else
             Path (Path_Index + 1) in 'A' .. 'F') and then
            (Path (Path_Index + 2) in '0' .. '9' or else
             Path (Path_Index + 2) in 'A' .. 'F')
         then
            DPath.Append (Character'Val (Integer'Value ("16#" &
                                          Path (Path_Index + 1 ..
                                                Path_Index + 2) &
                                          "#")));
            Path_Index := Path_Index + 2;
         else
            DPath.Append (Path (Path_Index));
         end if;
         Path_Index := Path_Index + 1;
         exit when Path_Index > Path'Length;
      end loop;

      case Version is
         when "1.1" =>
            MVersion := HTTP_1_1;
         when others =>
            raise Program_Error with Version;
      end case;

      declare
         Aggregate_Stream : Stream_Access := To_Stream
            (To_Octet_Array (Read_Until_Delimiter (Stream, CRLF & CRLF)));
      begin
         loop
            declare
               Name : constant String :=
                  Read_Until_Delimiter (Aggregate_Stream, ":");
               Data : constant String :=
                  Read_Until_Delimiter (Aggregate_Stream, CRLF);
            begin
               if Name'Length = 1 and then Name (Name'First) = ASCII.NUL then
                  exit;
               end if;
               Headers.Include
                  (Name,
                   (if Data (Data'First) = ' '
                    then Truncate (Data)
                    else Data));
            end;
         end loop;
         Aggregate_Stream.Free;
      end;

      if Headers.Contains (CL) then
         TransM := CONTENT_LENGTH;
      elsif Headers.Contains (TE) then
         TransM := CHUNKED;
         raise Program_Error;
      else
         TransM := NONE;
      end if;
      return (Path_Length        => DPath.Length,
               Method            => Method,
               Version           => MVersion,
               Path              => DPath.To_String,
               Headers           => Headers,
               Transmission_Type => TransM,
               Data_Length       => (if Headers.Contains (CL)
                                     then Integer'Value (Headers.Element (CL))
                                     else 0));
   end Input_Client_Message;

   --  Server Message  --

   procedure Write_Server_Message_No_Data
      (Stream  : not null access Root_Stream_Type'Class;
       Message : Server_Message)
   is
      Headers : Header_Maps.Map := Message.Headers;
   begin
      String'Write (Stream, "HTTP/");
      case Message.Version is
         when HTTP_1_1 =>
            String'Write (Stream, "1.1");
         when HTTP_2 =>
            String'Write (Stream, "2");
         when HTTP_3 =>
            String'Write (Stream, "3");
      end case;
      String'Write (Stream, Message.Status'Image & CRLF);
      case Message.Transmission_Type is
         when NONE =>
            Headers.Include (CL, "0");
         when CONTENT_LENGTH =>
            if not Headers.Contains (CL) and then Message.Data.Length > 0 then
               declare
                  Size : Integer := 0;
               begin
                  for Datum of Message.Data loop
                     Size := Size + Datum'Length;
                  end loop;
                  Headers.Include (CL, Truncate (Size'Image));
               end;
            end if;
         when CHUNKED =>
            Headers.Include (TE, "chunked");
      end case;
      for Header in Headers.Iterate loop
         String'Write (Stream, Header.Key & ':' & Header.Element & CRLF);
      end loop;
      String'Write (Stream, CRLF);
   end Write_Server_Message_No_Data;

   procedure Write_Server_Message_Data
      (Stream  : not null access Root_Stream_Type'Class;
       Message : Server_Message)
   is
   begin
      case Message.Transmission_Type is
         when NONE =>
            null;
         when CONTENT_LENGTH =>
            for Datum of Message.Data loop
               String'Write (Stream, Datum);
            end loop;
         when CHUNKED =>
            declare
               Size : String := "16#00000#";
            begin
               for Datum of Message.Data loop
                  Ada.Integer_Text_IO.Put (Size, Datum'Length, 16);
                  String'Write (Stream, Size
                     ((Index (Size, "16#") + 3) .. Size'Last - 1)
                     & CRLF);
                  String'Write (Stream, Datum & CRLF);
               end loop;
               String'Write (Stream, '0' & CRLF & CRLF);
            end;
      end case;
   end Write_Server_Message_Data;

   --  Specialized Header Operations  --

   function MIME_From_Extension (Extension : String; Full : Boolean)
      return String
      is separate;

   function Read_Range_Header (Header : String; Content_Size : Natural)
      return Range_Parsing_Result
      is separate;

   --  General Operations  --

   function Read_Until_Delimiter
      (Stream : not null access Root_Stream_Type'Class;
       Delimiter : String)
   return String is
      Read            : Unbounded_String;
      Delimiter_Query : Unbounded_String;
   begin
      begin
         loop
            Delimiter_Query.Append (Character'Input (Stream));
            if Delimiter_Query.Element (Delimiter_Query.Length) /=
               Delimiter (Delimiter_Query.Length)
            then
               Read.Append (Delimiter_Query);
               Delimiter_Query.Delete (1, Delimiter_Query.Length);
            elsif Delimiter_Query.Length = Delimiter'Length then
               exit;
            end if;
         end loop;
      exception
         when Out_Of_Bounds_Error =>
            null;
      end;
      return (if Read.Length > 0 then Read.To_String else [ASCII.NUL]);
   end Read_Until_Delimiter;

   function Truncate (Str : String) return String is
   begin
      return Str (Str'First + 1 .. Str'Last);
   end Truncate;

   function Image_HTTP (Time : Ada.Calendar.Time) return String is
      function Pad (Str : String) return String is
      begin
         return Ada.Strings.Fixed.Tail (Truncate (Str), 2, Pad => '0');
      end Pad;

      Days   : constant array (Monday .. Sunday) of String (1 .. 3) :=
         ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
      Months : constant array (1 .. 12) of String (1 .. 3) :=
         ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
          "Nov", "Dec"];

      As_Seconds : constant Integer := Integer (Time.Seconds);
      Time_Str   : constant String :=
         Days (Day_Of_Week (Time)) & ", " &
         Pad (Time.Day'Image) & ' ' & Months (Time.Month) & Time.Year'Image &
         ' ' &
         Pad (Integer'Image (As_Seconds / 3600)) & ':' &
         Pad (Integer'Image ((As_Seconds rem 3600) / 60)) & ':' &
         Pad (Integer'Image (As_Seconds rem 60)) &
         " GMT";
   begin
      return Time_Str;
   end Image_HTTP;

end HTTP;