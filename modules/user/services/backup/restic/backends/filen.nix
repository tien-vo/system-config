{ config, pkgs, ... }:
let
  scope = import ../scope.nix {
    home = config.home.homeDirectory;
  };

  restic-filen-fw13 = pkgs.writeShellApplication({
    name = "restic-filen-fw13";

    runtimeInputs = [
      pkgs.rclone
      pkgs.restic
    ];

    text = ''
      RCLONE_CONFIG_PASS="$(
        cat "${config.sops.secrets.rclone-config-password.path}"
      )"

      export RCLONE_CONFIG_PASS

      exec restic \
        --repo "rclone:filen:backups/restic/fw13" \
        --password-file "${config.sops.secrets.restic-filen-password.path}" \
        "$@"
    '';
  });
in
{
  config.home.packages = [
    restic-filen-fw13
  ];

  config.services.restic.backups.filen-fw13 = {
    repository = "rclone:filen:backups/restic/fw13";
    initialize = false;

    passwordFile = config.sops.secrets.restic-filen-password.path;

    paths = scope.paths;
    exclude = scope.excludes;

    extraBackupArgs = [
      "--host=fw13"
      "--json"
    ];

    createWrapper = false;
    inhibitsSleep = true;
    progressFps = 0.0166;

    timerConfig = {
      OnCalendar = "Sun *-*-* 03:00:00";
      Persistent = true;
    };
  };

  config.systemd.user.services.restic-backups-filen-fw13 = {
    Unit = {
      "X-SwitchMethod" = "keep-old";

      Wants = [
        "restic-progress-filen-fw13.service"
      ];
    };

    Service = {
      EnvironmentFile = config.sops.templates."rclone-fw13.env".path;
    };
  };
}
