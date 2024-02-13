{ pkgs, inputs, settings, ... }:
let
  inherit (settings) src nixVersion;
  setBootDevices = uuid: { "luks-${uuid}".device = "/dev/disk/by-uuid/${uuid}"; };
in
{
  imports = [
    ./hardware.nix
    inputs.hardware.nixosModules.framework-13-7040-amd
    "${src}/modules/system/tools/nix"
    "${src}/modules/system/tools/nix-ld"
    "${src}/modules/system/shells/zsh"
    "${src}/modules/system/hardware"
    "${src}/modules/system/window-managers/hyprland"
  ];

  config.system.stateVersion = nixVersion;

  config.boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    initrd.luks.devices = setBootDevices ("de381c7f-5246-4e90-9fbf-0a463327df39");
  };

  config.networking = {
    hostName = "fw13";
    networkmanager.enable = true;
  };
  config.time.timeZone = "America/Denver";
  config.i18n.defaultLocale = "en_US.UTF-8";

  config.users.users.tvo = {
    isNormalUser = true;
    description = "Tien Vo";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  config.environment.systemPackages = [
    pkgs.git
    pkgs.vim
    pkgs.wget
  ];

  config.services.gnome.gnome-keyring.enable = true;
  config.systemd.user.services.protonmail-bridge = {          
    description = "Protonmail Bridge";          
    enable = true;          
    script = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";          
    path = [ pkgs.gnome3.gnome-keyring ];
    wantedBy = [ "graphical-session.target" ];          
    partOf = [ "graphical-session.target" ];
  };
}
