with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Indefinite_Vectors;
with Ada.Strings.Hash;
with Ada.Streams;

with Octet_Memory_Stream;

package HTTP is

   -- Base Message --

   package Header_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type        => String,
      Element_Type    => String,
      Hash            => Ada.Strings.Hash,
      Equivalent_Keys => "=");

   type HTTP_Method is
      (GET);

   type HTTP_Version is
      (HTTP_1_1);

   type Data_Transmission_Type is
      (NONE, CONTENT_LENGTH, CHUNKED);

   type Message is abstract tagged record
      Version           : HTTP_Version           := HTTP_1_1;
      Headers           : Header_Maps.Map;
      Transmission_Type : Data_Transmission_Type := NONE;
   end record;

   -- Client Message --

   type Client_Message (Path_Length : Natural) is new Message with record
      Method  : HTTP_Method;
      Path    : String (1 .. Path_Length);
      Data    : Octet_Memory_Stream.Stream_Access;
   end record;

   function Input_Client_Message
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class)
   return Client_Message;

   for Client_Message'Input use Input_Client_Message;

   -- Server Message --

   package Data_Vectors is new Ada.Containers.Indefinite_Vectors
      (Positive, String);

   type Server_Message is new Message with record
      Status : Integer range 100 .. 999;
      Data   : Data_Vectors.Vector;
   end record;

   procedure Write_Server_Message
      (Stream  : not null access Ada.Streams.Root_Stream_Type'Class;
       Message : Server_Message);

   for Server_Message'Write use Write_Server_Message;

   -- MIME --

   function MIME_From_Extension (Extension : String; Full : Boolean)
      return String;

private

   function Read_Until_Delimiter
      (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
       Delimiter : String)
   return String;

end HTTP;