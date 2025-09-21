{ ... }:
{
  config.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        hashKnownHosts = true;
        addKeysToAgent = "confirm";
      };
      "reMarkable.usb" = {
        hostname = "10.11.99.1";
        user = "root";
      };
      "reMarkable.wifi" = {
        hostname = "192.168.0.6";
        user = "root";
      };
      "msi-agate" = {
        hostname = "agate.msi.umn.edu";
        user = "voxxx266";
      };
      "msi-mesabi" = {
        hostname = "mesabi.msi.umn.edu";
        user = "voxxx266";
      };
      "lasp-macl2556-ethernet" = {
        hostname = "10.247.21.135";
        user = "tienad";
      };
    };
  };
}
