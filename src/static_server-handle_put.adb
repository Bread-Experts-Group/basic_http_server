separate (Static_Server)
procedure Handle_PUT
   (Request  :        Client_Message;
    Response :    out Server_Message;
    File     : in out File_Type;
    Channel  :        GNAT.Sockets.Stream_Access)
is
   task type Write_Task is
      entry Setup (File_Stream : Stream_Access);
      entry Start;
   end Write_Task;

   task body Write_Task is
      Stream : Stream_Access;
      Index  : Integer := 1;
   begin
      accept Setup (File_Stream : Stream_Access)
      do
         Stream := File_Stream;
      end Setup;

      accept Start;
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
            String'Write (Stream, Chunk);
            Index := @ + Chunk'Length;
         end;
      end loop;
   exception
      when End_Error =>
         Ada.Text_IO.Put_Line ("Terminated copying of " & File.Name);
         File.Delete;
      when E : others =>
         Ada.Text_IO.Put_Line (E.Exception_Information);
   end Write_Task;

   type Write_Task_Access is access Write_Task;
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

   Write_Server_Message_No_Data (Channel, Response);

   declare
      New_Task : constant Write_Task_Access := new Write_Task;
   begin
      New_Task.Setup (Stream (File));
      New_Task.Start;
   end;
end Handle_PUT;