with Ada.Strings; use Ada.Strings;

separate (Static_Server)
procedure Handle_GET_HEAD
   (Request  :        Client_Message;
    Response :    out Server_Message;
    File     : in out File_Type)
is
   Dot_Index   : constant Natural := Index (Request.Path, ".", Backward);
   Extension   : constant String  := Tail (Request.Path,
                                           Request.Path'Length - Dot_Index,
                                           ' ');
   File_Stream : Stream_Access;
begin
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
         return;
      when Ada.IO_Exceptions.Name_Error =>
         Response.Status := 404;
         return;
      when Ada.IO_Exceptions.Use_Error =>
         Response.Status := 503;
         return;
   end;

   Response.Status := 200;
   Response.Headers.Include
      ("Content-Type",
         MIME_From_Extension (Extension, Dot_Index = 0));
   Response.Headers.Include
      ("Last-Modified",
         Image_HTTP (Modification_Time (File.Name)));
   if
      Request.Headers.Contains ("If-Modified-Since") and then
      Request.Headers.Element ("If-Modified-Since") =
      Response.Headers.Element ("Last-Modified")
   then
      Response.Status := 304;
      return;
   end if;
   Response.Headers.Include ("Accept-Ranges", "bytes");
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
            return;
      end case;
   exception
      when End_Error =>
         Response.Status := 416;
         Response.Transmission_Type := NONE;
   end;
end Handle_GET_HEAD;