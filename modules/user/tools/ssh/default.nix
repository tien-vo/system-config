{ ... }:
{
  config.programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    hashKnownHosts = true;
    matchBlocks = {
      "remarkable" = {
        hostname = "10.11.99.1";
        user = "root";
      };
    };
  };
}
