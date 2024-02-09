{ ... }:
{
  config.services.fwupd.enable = true;
  config.environment.systemPackages = [
    pkgs.dmidecode
  ];
}
