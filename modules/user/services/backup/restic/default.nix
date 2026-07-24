{ config, pkgs, settings, ... }:
let
  home = config.home.homeDirectory;

  progress-notifier = import ./progress-notifier.nix {
    inherit pkgs;
  };

  restic-filen-fw13 = pkgs.writeShellApplication {
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

  };
in
{
  config.home.packages = [
    pkgs.age
    pkgs.rclone
    pkgs.restic
    pkgs.sops
    restic-filen-fw13
  ];

  config.sops = {
    defaultSopsFile =
      "${settings.src}/secrets/restic-filen-fw13.yaml";

    defaultSopsFormat = "yaml";

    age.keyFile =
      "${config.xdg.configHome}/sops/age/keys.txt";

    secrets = {
      restic-filen-password = {
        mode = "0400";
      };

      rclone-config-password = {
        sopsFile =
          "${settings.src}/secrets/rclone-fw13.yaml";

        mode = "0400";
      };
    };

    templates."rclone-filen-fw13.env" = {
      content = ''
        RCLONE_CONFIG_PASS=${config.sops.placeholder.rclone-config-password}
      '';

      mode = "0400";
    };
  };

  config.services.restic = {
    enable = true;

    backups.filen-fw13 = {
      repository = "rclone:filen:backups/restic/fw13";

      # The repository already exists.
      initialize = false;

      passwordFile =
        config.sops.secrets.restic-filen-password.path;

      paths = [
        "${home}/70_collections"
        "${home}/80_archive"
      ];

      exclude = [
        # Cryptomator plaintext views
        "${home}/70_collections/03_personal-records/01_content"
        "${home}/70_collections/04_work-records/01_content"

        # Volatile/generated directories
        "**/__pycache__"
        "**/.mypy_cache"
        "**/.pytest_cache"
        "**/.ruff_cache"
        "**/.cache"
        "**/.venv"
        "**/node_modules"
        "**/.debris"
      ];

      extraBackupArgs = [
        "--host=fw13"
        "--json"
      ];

      # A custom wrapper is defined above so it can read
      # the rclone configuration password from sops-nix.
      createWrapper = false;

      inhibitsSleep = true;
      timerConfig = null;
      progressFps = 0.0166;
    };
  };

  config.systemd.user.services = {
    restic-backups-filen-fw13 = {
      Unit = {
        "X-SwitchMethod" = "keep-old";

        Wants = [
          "restic-progress-filen-fw13.service"
        ];
      };

      Service = {
        EnvironmentFile =
          config.sops.templates."rclone-filen-fw13.env".path;
      };
    };

    restic-progress-filen-fw13 = {
      Unit = {
        Description =
          "Desktop progress notifications for fw13 Restic backup";

        After = [
          "graphical-session.target"
        ];
      };

      Service = {
        Type = "exec";

        ExecStart =
          "${progress-notifier}/bin/restic-progress-notifier";
      };
    };
  };
}
