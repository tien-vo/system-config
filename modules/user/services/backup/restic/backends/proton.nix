{ config, machine-name, pkgs, ... }:
let
  scope = import ../scope.nix {
    home = config.home.homeDirectory;
  };

  repository = "${config.xdg.stateHome}/restic/proton/${machine-name}";
  backup-name = "proton-local-${machine-name}";
  backup-unit = "restic-backups-${backup-name}";
  sync-unit = "proton-sync-restic-${machine-name}";

  proton-sync = import ../scripts/proton-sync.nix {
    inherit config machine-name pkgs repository;
  };
in
{
  config.home.packages = [
    proton-sync
  ];

  config.services.restic.backups.${backup-name} = {
    inherit repository;

    initialize = true;

    passwordFile = config.sops.secrets.restic-proton-password.path;

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
      OnCalendar = "Sat *-*-* 03:00:00";
      Persistent = true;
    };
  };

  config.systemd.user.services = {
    ${backup-unit} = {
      Unit = {
        "X-SwitchMethod" = "keep-old";

        OnSuccess = [
          "${sync-unit}.service"
        ];
      };
    };

    ${sync-unit} = {
      Unit = {
        Description = "Upload the local ${machine-name} Restic repository to Proton";

        After = [
          "graphical-session.target"
        ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${proton-sync}/bin/proton-sync-restic-${machine-name}";
      };
    };
  };
}
