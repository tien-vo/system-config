{ pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/tools/nix"
    "${src}/modules/user/tools/xdg"
    "${src}/modules/user/tools/ssh"
    "${src}/modules/user/tools/cryptomator"

    "${src}/modules/user/hardware/network"
    "${src}/modules/user/hardware/bluetooth"

    "${src}/modules/user/daemon/syncthing"
    "${src}/modules/user/daemon/mako"
    "${src}/modules/user/daemon/swww"

    "${src}/modules/user/devenv"
    "${src}/modules/user/devenv/git"
    "${src}/modules/user/devenv/micromamba"

    "${src}/modules/user/shells/zsh"

    "${src}/modules/user/console/neovim"
    "${src}/modules/user/console/autojump"
    "${src}/modules/user/console/alacritty"

    "${src}/modules/user/window-managers/hyprland"
    "${src}/modules/user/status-bars/waybar"
    "${src}/modules/user/launchers/fuzzel"

    "${src}/modules/user/browsers/web/firefox"
    "${src}/modules/user/browsers/file/zathura"
    "${src}/modules/user/browsers/file/thunar"
    "${src}/modules/user/browsers/file/vifm"

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
  ];

  config.home.sessionVariables = {
    BROWSER = "firefox";
  };
}
