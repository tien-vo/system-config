{ config, inputs, pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/tools/nix"
    "${src}/modules/user/tools/xdg"
    "${src}/modules/user/tools/ssh"
    "${src}/modules/user/tools/vpn"
    "${src}/modules/user/tools/fcitx5"

    "${src}/modules/user/devenv/git"
    "${src}/modules/user/devenv/micromamba"

    "${src}/modules/user/console/shell/zsh"
    "${src}/modules/user/console/neovim"
    "${src}/modules/user/console/autojump"
    "${src}/modules/user/console/alacritty"
    "${src}/modules/user/console/kitty"

    "${src}/modules/user/theme"
    "${src}/modules/user/window-manager/wayland/hyprland"

    #  "${src}/modules/user/services/sync/megasync"
    "${src}/modules/user/services/sync/syncthing"

    #  "${src}/modules/user/information-management/logseq"
    #  "${src}/modules/user/information-management/thunderbird"
    "${src}/modules/user/information-management/zotero"
    "${src}/modules/user/information-management/obsidian"

    "${src}/modules/user/web-browser/firefox"
    "${src}/modules/user/web-browser/chromium"

    "${src}/modules/user/app/multi-media/swayimg"

    #  "${src}/modules/user/app/file-manager/vifm"
    "${src}/modules/user/app/file-manager/yazi"
    "${src}/modules/user/app/file-manager/thunar"
    #  "${src}/modules/user/app/file-manager/zathura"
    #  "${src}/modules/user/app/cloud-service/cryptomator"
    #  "${src}/modules/user/app/office/libreoffice"
  ];

  config.home.packages = [
    pkgs.cryptomator
    pkgs.htop
    pkgs.kdePackages.okular
    pkgs.unzip
    pkgs.sshfs
    pkgs.vlc
    #  pkgs.xdg-utils
    #  pkgs.wl-clipboard
    #  pkgs.neofetch
    #  pkgs.dex
    #  pkgs.zoom-us
    #  pkgs.imagemagick
    #  pkgs.tomato-c
    #  pkgs.nh
    #  pkgs.ventoy-full
  ];
}
