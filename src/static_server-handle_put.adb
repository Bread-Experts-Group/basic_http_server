separate (Static_Server)
procedure Handle_PUT
   (Request  :        Client_Message;
    Response :    out Server_Message;
    File     : in out File_Type;
    Channel  :        GNAT.Sockets.Stream_Access)
is
   S     : Stream_Access;
   Index : Natural := 1;
begin
   if Exists (".." & Request.Path) then
      if Kind (".." & Request.Path) /= Ordinary_File then
         Response.Status := 400;
         return;
      end if;
      Response.Status := 200;
      Open (File, Out_File, ".." & Request.Path, "shared=no");
      File.Reset;
   else
      Response.Status := 201;
      Create_Path (Containing_Directory (".." & Request.Path));
      Create (File, Out_File, ".." & Request.Path, "shared=no");
   end if;
   S := Stream (File);

   loop
      declare
         Chunk : String
            (1 .. Integer'Min (2 ** 20,
                                 (Request.Data_Length - Index) + 1));
      begin
         Ada.Text_IO.Put_Line (File.Name & Index'Image & " /" &
                                 Request.Data_Length'Image);
         exit when Chunk'Length = 0;
         String'Read (Channel, Chunk);
         String'Write (S, Chunk);
         Index := @ + Chunk'Length;
      end;
   end loop;

   Write_Server_Message_No_Data (Channel, Response);
end Handle_PUT;