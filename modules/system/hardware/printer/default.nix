{ ... }:
{
  config.services.printing.enable = true;
  config.services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
