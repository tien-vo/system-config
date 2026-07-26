{ config, pkgs, ... }:
let
  scope = import ../scope.nix {
    home = config.home.homeDirectory;
  };

  repository =
    "${config.xdg.stateHome}/restic/proton-drive/fw13";

  proton-drive-sync = import ../scripts/proton-drive-sync.nix {
    inherit config pkgs repository;
  };
in
{
  config.home.packages = [
    proton-drive-sync
  ];

  config.services.restic.backups.proton-local-fw13 = {
    inherit repository;

    initialize = true;

    passwordFile = config.sops.secrets.restic-proton-password.path;

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
      OnCalendar = "Sat *-*-* 03:00:00";
      Persistent = true;
    };
  };

  config.systemd.user.services = {
    restic-backups-proton-local-fw13 = {
      Unit = {
        "X-SwitchMethod" = "keep-old";

        OnSuccess = [
          "proton-drive-sync-restic-fw13.service"
        ];
      };
    };

    proton-drive-sync-restic-fw13 = {
      Unit = {
        Description =
          "Upload the local fw13 Restic repository to Proton Drive";

        After = [
          "graphical-session.target"
        ];
      };

      Service = {
        Type = "oneshot";

        ExecStart =
          "${proton-drive-sync}/bin/proton-drive-sync-restic-fw13";
      };
    };
  };
}
