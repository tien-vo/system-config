{ config, settings, pkgs, ... }:
let
  inherit (builtins) toString;
  fw13 = settings.monitors.framework13;
  sceptre = settings.monitors.sceptre;
in
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.monitor({
    output = "desc:${fw13.name}",
    mode = "${fw13.resolution}",
    position = "0x0",
    scale = ${toString(fw13.screenScaling)}
})

hl.monitor({
    output = "desc:${sceptre.name}",
    mode = "${sceptre.resolution}",
    position = "auto",
    scale = ${toString(sceptre.screenScaling)}
})

hl.config({
    xwayland = { force_zero_scaling = true }
})
  '';
}
