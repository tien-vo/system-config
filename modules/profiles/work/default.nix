{ pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/toolkits/nix"
    "${src}/modules/user/toolkits/gtk"
    "${src}/modules/user/toolkits/xdg"
    "${src}/modules/user/toolkits/ssh"
    "${src}/modules/user/toolkits/cryptomator"

    "${src}/modules/user/hardware/network"
    "${src}/modules/user/hardware/bluetooth"

    "${src}/modules/user/daemon/syncthing"
    "${src}/modules/user/daemon/mako"
    "${src}/modules/user/daemon/swww"

    "${src}/modules/user/shells/zsh"

    "${src}/modules/user/console/git"
    "${src}/modules/user/console/neovim"
    "${src}/modules/user/console/alacritty"
    "${src}/modules/user/console/autojump"

    "${src}/modules/user/window-managers/hyprland"
    "${src}/modules/user/status-bars/waybar"
    "${src}/modules/user/launchers/fuzzel"

    "${src}/modules/user/browsers/web/firefox"
    "${src}/modules/user/browsers/file/zathura"
    "${src}/modules/user/browsers/file/thunar"
    "${src}/modules/user/browsers/file/vifm"

    "${src}/modules/user/devenv"

    "${src}/modules/user/theme"

    "${src}/modules/user/apps/zotero"
    "${src}/modules/user/apps/megasync"
  ];

  config.home.packages = [
    pkgs.jq
    pkgs.eza
    pkgs.unzip
    pkgs.grim
    pkgs.slurp
    pkgs.wlogout
    pkgs.wl-clipboard
    pkgs.brightnessctl
    pkgs.swayimg
    pkgs.htop
    pkgs.neofetch
    pkgs.dex
    pkgs.gnumake
  ];

  config.home.sessionVariables = {
    BROWSER = "firefox";
  };
}
