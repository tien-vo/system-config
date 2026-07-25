{ config, settings, ... }:
{
  config.sops = {
    defaultSopsFormat = "yaml";

    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    secrets = {
      restic-filen-password = {
        sopsFile = "${settings.src}/secrets/restic-filen-fw13.yaml";
        key = "restic-filen-password";
        mode = "0400";
      };

      restic-proton-password = {
        sopsFile = "${settings.src}/secrets/restic-proton-fw13.yaml";
        key = "restic-proton-password";
        mode = "0400";
      };

      rclone-config-password = {
        sopsFile = "${settings.src}/secrets/rclone-fw13.yaml";
        key = "rclone-config-password";
        mode = "0400";
      };
    };

    templates."rclone-fw13.env" = {
      content = ''
        RCLONE_CONFIG_PASS=${config.sops.placeholder.rclone-config-password}
      '';

      mode = "0400";
    };
  };
}
