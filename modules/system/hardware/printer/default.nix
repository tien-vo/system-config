{ ... }:
{
  config.services.printing = {
    enable = true;
    allowFrom = [
      "from localhost"
      "from 127.0.0.1"
    ];
    logLevel = "debug";
  };
  config.services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
