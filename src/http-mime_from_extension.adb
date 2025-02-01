separate (HTTP)
function MIME_From_Extension (Extension : String; Full : Boolean)
return String is
begin
   case Extension is
      when "html" =>
         return "text/html";
      when "css" =>
         return "text/css";
      when "js" =>
         return "text/javascript";
      when "ads" | "adb" | "ali" | "gpr" | "gitignore" =>
         return "text/plain";
      when "png" =>
         return "image/png";
      when "ico" =>
         return "image/vnd.microsoft.icon";
      when "otf" =>
         return "font/otf";
      when "ttf" =>
         return "font/ttf";
      when "mp3" =>
         return "audio/mpeg";
      when "ogg" =>
         return "audio/ogg";
      when "mp4" =>
         return "video/mp4";
      when "json" =>
         return "application/json";
      when "zip" =>
         return "application/zip";
      when "toml" =>
         return "application/toml";
      when others  =>
         if not Full then
            case Extension is
               when "map" | "rpgmvp" | "rpgmvo" =>
                  null;
               when others =>
                  raise Program_Error with Extension;
            end case;
         end if;
         return "application/octet-stream";
   end case;
end MIME_From_Extension;