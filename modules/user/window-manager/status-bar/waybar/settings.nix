{ pkgs, settings, ... }:
let
  inherit (builtins) ceil;
  inherit (settings.window) gap;
  inherit (settings.theme.font) size;

  iconSize = ceil (1.1 * size * 1.6);
in
{
  config.programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    margin-bottom = 0;
    margin-top = gap.outer;
    margin-left = gap.outer;
    margin-right = gap.outer;
    modules-left = [
      "clock"
    ];
    modules-center = [
      "hyprland/workspaces"
    ];
    modules-right = [
      "tray"
      "wireplumber"
      "upower"
      "temperature"
      "memory"
      "cpu"
      "custom/powermenu"
    ];
    tray = {
      icon-size = iconSize;
      spacing = 4;
    };
    "hyprland/window" = {
      max-length = 200;
      separate-outputs = true;
    };
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        "1" = "󰲠 ";
        "2" = "󰲢 ";
        "3" = "󰲤 ";
        "4" = "󰲦 ";
        "5" = "󰲨 ";
        "6" = "󰲪 ";
        "7" = "󰲬 ";
        "8" = "󰲮 ";
        "9" = "󰲰 ";
        "10" = "󰿬 ";
      };
      sort-by-number = true;
      active-only = false;
    };
    temperature = {
      format = "{icon} {temperatureC}°C";
      hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
      critical-threshold = 80;
      format-icons = [ "" "" "" "" "" ];
    };
    memory = {
      format = "󰍛 {percentage}%";
      tooltip = false;
    };
    cpu = {
      interval = 1;
      format = "  {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
      format-icons = [
        "<span color='#a9b665'>▁</span>"
        "<span color='#94A6FF'>▂</span>"
        "<span color='#d4be98'>▃</span>"
        "<span color='#d4be98'>▄</span>"
        "<span color='#FFFFA8'>▅</span>"
        "<span color='#FFFFA8'>▇</span>"
        "<span color='#d8a657'>▆</span>"
        "<span color='#ea6962'>█</span>"
      ];
    };
    "custom/powermenu" = {
      format = "⏻";
      tooltip = false;
      on-click = "exec ${pkgs.wlogout}/bin/wlogout -p layer-shell";
    };
    wireplumber = {
      format = "{icon} {volume}%";
      format-muted = "";
      format-icons = [ "" "" "" ];
    };
    upower = {
      icon-size = iconSize;
      hide-if-empty = true;
      format = "{percentage}";
      tooltip = false;
    };
    clock = {
      format = "󰥔  {:%A, %B %Oe %H:%M:%S}";
      interval = 1;
    };
    battery = {
      interval = 60;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰂀" "󰂁" "󰂁" "󰁹" ];
    };
  };
}
