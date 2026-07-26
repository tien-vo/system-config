{ config, machine-name, pkgs, ... }:
let
  scope = import ../scope.nix {
    home = config.home.homeDirectory;
  };

  repository = "rclone:filen:backups/restic/${machine-name}";
  backup-name = "filen-${machine-name}";
  backup-unit = "restic-backups-${backup-name}";
  progress-unit = "restic-progress-${backup-name}";

  restic-filen = pkgs.writeShellApplication {
    name = "restic-filen-${machine-name}";

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
        --repo "${repository}" \
        --password-file "${config.sops.secrets.restic-filen-password.path}" \
        "$@"
    '';
  };
in
{
  config.home.packages = [
    restic-filen
  ];

  config.services.restic.backups.${backup-name} = {
    inherit repository;

    initialize = false;

    passwordFile = config.sops.secrets.restic-filen-password.path;

    paths = scope.paths;
    exclude = scope.excludes;

    extraBackupArgs = [
      "--host=${machine-name}"
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

  config.systemd.user.services.${backup-unit} = {
    Unit = {
      "X-SwitchMethod" = "keep-old";

      Wants = [
        "${progress-unit}.service"
      ];
    };

    Service = {
      EnvironmentFile = config.sops.templates."rclone-${machine-name}.env".path;
    };
  };
}
