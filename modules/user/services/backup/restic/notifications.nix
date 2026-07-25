{ pkgs, ... }:
let
  progress-notifier = import ./scripts/progress-notifier.nix {
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
    restic-progress-filen-fw13 = {
      Unit = {
        Description = "Desktop progress notifications for fw13 Restic backup";

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
          "mako.service"
        ];
      };

      Service = {
        Type = "oneshot";

        ExecStart =
          "${restic-next-backup}/bin/restic-next-backup --notify";
      };
    };
  };
}
