{ config, settings, pkgs, ... }:
let
  inherit (builtins) toString;
  inherit (settings.window) border;
  fw13 = settings.monitors.framework13;
  sceptre = settings.monitors.sceptre;
in {
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.bind("SUPER + SPACE",                        hl.dsp.exec_cmd("${pkgs.pyprland}/bin/pypr toggle term"))
hl.bind("SUPER + V",                            hl.dsp.exec_cmd("${pkgs.pyprland}/bin/pypr toggle vifm"))

hl.window_rule({
    match = { class = "^(kitty-dropterm)(.*)" },
    float = true,
    border_color = { colors = {"rgba(${border.active_color.top}ff)", "rgba(${border.active_color.bottom}ff)"}, angle =  60 }
})
hl.window_rule({
    match = { class = "^(fm-dropterm)(.*)" },
    float = true,
    border_color = { colors = {"rgba(${border.active_color.top}ff)", "rgba(${border.active_color.bottom}ff)"}, angle =  60 }
})
hl.window_rule({
    workspace = "special:scratchpad silent",
    match = { class = "^(fm-dropterm)(.*)" },
    border_color = { colors = {"rgba(${border.active_color.top}ff)", "rgba(${border.active_color.bottom}ff)"}, angle =  60 }
})
  '';
}
