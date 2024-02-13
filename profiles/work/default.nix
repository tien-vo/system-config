{ pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/tools/nix"
    "${src}/modules/user/tools/xdg"
    "${src}/modules/user/tools/ssh"

    "${src}/modules/user/hardware/network"
    "${src}/modules/user/hardware/bluetooth"

    "${src}/modules/user/daemon/syncthing"

    "${src}/modules/user/devenv"
    "${src}/modules/user/devenv/git"
    "${src}/modules/user/devenv/micromamba"

    "${src}/modules/user/console/shell/zsh"
    "${src}/modules/user/console/neovim"
    "${src}/modules/user/console/autojump"
    "${src}/modules/user/console/alacritty"

    "${src}/modules/user/theme"
    "${src}/modules/user/window-manager/wayland/hyprland"

    "${src}/modules/user/app/multi-media"
    #  "${src}/modules/user/app/personal-information-management/thunderbird"
    "${src}/modules/user/app/personal-information-management/betterbird"
    "${src}/modules/user/app/web-browser/firefox"
    "${src}/modules/user/app/file-manager/vifm"
    "${src}/modules/user/app/file-manager/thunar"
    "${src}/modules/user/app/file-manager/zathura"
    "${src}/modules/user/app/research-tool/zotero"
    "${src}/modules/user/app/cloud-service/megasync"
    "${src}/modules/user/app/cloud-service/cryptomator"
  ];

  config.home.packages = [
    pkgs.xdg-utils
    pkgs.unzip
    pkgs.wl-clipboard
    pkgs.swayimg
    pkgs.htop
    pkgs.neofetch
    pkgs.dex
  ];
}
