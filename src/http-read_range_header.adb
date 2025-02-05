separate (HTTP)
function Read_Range_Header (Header : String; Content_Size : Natural)
return Range_Parsing_Result is
   Ranges    : Range_Vectors.Vector;
   Read_Size : Integer;

   From, To : Unbounded_String;
   Read_To  : Boolean := False;
   Char     : Character;

   Error : Server_Message;
begin
   for Index in 8 .. Header'Last loop
      Char := Header (Index);
      case Char is
         when '-' =>
            if Read_To then
               Error.Status := 400;
               return (False, Error);
            end if;
            Read_To := True;
         when ',' =>
            --  TODO, multipart ranging
            Error.Status := 501;
            return (False, Error);
         when others =>
            if Read_To then
               To.Append (Char);
            else
               From.Append (Char);
            end if;
      end case;
      goto Add when Index = Header'Last;
      goto Next;
      <<Add>>
      if not Read_To then
         Error.Status := 400;
         return (False, Error);
      end if;
      Read_To := False;
      declare
         From_I : Integer := -1;
         To_I   : Integer := -1;
      begin
         --  NOTE:
         --  These error handlers also catch on overflow.
         --  Fix in the future?
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
            if To_I = -1 then
               Error.Status := 416;
               return (False, Error);
            end if;
            Error.Status := 501;
            return (False, Error);
         elsif To_I = -1 then
            To_I := Content_Size;
         end if;

         if From_I > To_I or else To_I > Content_Size or else From_I < 1 then
            Error.Status := 416;
            return (False, Error);
         end if;

         Read_Size := @ + (To_I - From_I) + 1;
         Ranges.Append (Response_Range'(From_I, To_I));
      end;
      To.Delete (1, To.Length);
      From.Delete (1, From.Length);
      <<Next>>
   end loop;
   return (True, Ranges, Read_Size);
end Read_Range_Header;