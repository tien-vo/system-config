{ config, inputs, pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/package-management/nix"

    "${src}/modules/user/security/gpg"
    "${src}/modules/user/security/ssh"
    "${src}/modules/user/security/vpn"

    "${src}/modules/user/services/sync/syncthing"
    "${src}/modules/user/services/backup/restic"
    "${src}/modules/user/services/backup/proton-drive-cli"
    #  "${src}/modules/user/services/sync/megasync"
    #  "${src}/modules/user/services/cryptomator"

    "${src}/modules/user/shell/zsh"
    "${src}/modules/user/shell/autojump"

    "${src}/modules/user/terminal/alacritty"
    "${src}/modules/user/terminal/kitty"

    "${src}/modules/user/development-environment/git"
    "${src}/modules/user/development-environment/micromamba"

    "${src}/modules/user/editor/neovim"

    "${src}/modules/user/desktop/xdg"
    "${src}/modules/user/desktop/fcitx5"

    "${src}/modules/user/theme"
    "${src}/modules/user/window-manager/wayland/hyprland"

    "${src}/modules/user/reference-management/zotero"

    "${src}/modules/user/knowledge-management/obsidian"
    #  "${src}/modules/user/knowledge-management/logseq"

    "${src}/modules/user/finance/actual-server"

    "${src}/modules/user/web-browser/firefox"
    "${src}/modules/user/web-browser/chromium"

    "${src}/modules/user/viewer/swayimg"
    "${src}/modules/user/viewer/zathura"

    "${src}/modules/user/file-management/yazi"
    "${src}/modules/user/file-management/thunar"
    #  "${src}/modules/user/file-management/vifm"

    "${src}/modules/user/office/libreoffice"

    "${src}/modules/user/communication/slack"
    #  "${src}/modules/user/communication/thunderbird"
  ];

  config.home.packages = [
    pkgs.cryptomator
    pkgs.htop
    pkgs.jq
    pkgs.kdePackages.okular
    pkgs.ncdu
    pkgs.pandoc
    pkgs.sshfs
    pkgs.trash-cli
    pkgs.tree
    pkgs.zip
    pkgs.unzip
    pkgs.uv
    pkgs.vlc
    pkgs.wget
    pkgs.wl-clipboard
  ];
}
