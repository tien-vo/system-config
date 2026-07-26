{ machine-name, pkgs, ... }:
let
  filen-backup-unit = "restic-backups-filen-${machine-name}.service";

  progress-notifier = import ./scripts/progress-notifier.nix {
    backup-unit = filen-backup-unit;
    inherit pkgs;
  };

  restic-next-backup = import ./scripts/restic-next-backup.nix {
    inherit pkgs;
  };
in
{
  config.home.packages = [
    restic-next-backup
  ];

  config.systemd.user.services = {
    "restic-progress-filen-${machine-name}" = {
      Unit = {
        Description = "Desktop progress notifications for ${machine-name} Filen Restic backup";

        After = [
          "graphical-session.target"
        ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${progress-notifier}/bin/restic-progress-notifier";
      };
    };

    restic-login-notification = {
      Unit = {
        Description = "Show the next Restic backup at Hyprland login";

        After = [
          "graphical-session.target"
        ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${restic-next-backup}/bin/restic-next-backup --notify";
      };
    };
  };
}
