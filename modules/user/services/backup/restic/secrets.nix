{ config, machine-name, settings, ... }:
{
  config.sops = {
    defaultSopsFormat = "yaml";

    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    secrets = {
      restic-filen-password = {
        sopsFile = "${settings.src}/secrets/restic-filen-${machine-name}.yaml";

        key = "restic-filen-password";
        mode = "0400";
      };

      restic-proton-password = {
        sopsFile = "${settings.src}/secrets/restic-proton-${machine-name}.yaml";

        key = "restic-proton-password";
        mode = "0400";
      };

      rclone-config-password = {
        sopsFile = "${settings.src}/secrets/rclone-${machine-name}.yaml";
        key = "rclone-config-password";
        mode = "0400";
      };
    };

    templates."rclone-${machine-name}.env" = {
      content = ''
        RCLONE_CONFIG_PASS=${config.sops.placeholder.rclone-config-password}
      '';
      mode = "0400";
    };
  };
}
