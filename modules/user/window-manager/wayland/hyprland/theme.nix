{ config, settings, ... }:
let
  inherit (builtins) toString;
  inherit (settings.theme) cursorTheme;
in
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.env("HYPRCURSOR_THEME", "${cursorTheme.name}")
hl.env("HYPRCURSOR_SIZE", "${toString(cursorTheme.size)}")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor '${cursorTheme.name}' ${toString(cursorTheme.size)}")
end)
  '';
}
