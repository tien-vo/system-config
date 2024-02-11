{ ... }:
{
  config.programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    hashKnownHosts = true;
    matchBlocks = {
      "reMarkable.usb" = {
        hostname = "10.11.99.1";
        user = "root";
      };
      "reMarkable.wifi" = {
        hostname = "192.168.0.6";
        user = "root";
      };
    };
  };
}
