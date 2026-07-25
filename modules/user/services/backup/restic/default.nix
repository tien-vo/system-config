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

  restic-proton-fw13 = pkgs.writeShellApplication {
    name = "restic-proton-fw13";

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
        --repo "rclone:proton:backups/restic/fw13" \
        --password-file "${config.sops.secrets.restic-proton-password.path}" \
        "$@"
    '';
  };

  restic-next-backup = import ./restic-next-backup.nix({ inherit pkgs; });

  backup-paths = [
    "${home}/70_collections"
    "${home}/80_archive"
  ];

  backup-excludes = [
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
in
{
  config.home.packages = [
    pkgs.age
    pkgs.rclone
    pkgs.restic
    pkgs.sops
    restic-filen-fw13
    restic-proton-fw13
    restic-next-backup
  ];

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

  config.services.restic = {
    enable = true;

    backups = {
      filen-fw13 = {
        repository = "rclone:filen:backups/restic/fw13";
        initialize = false;

        passwordFile = config.sops.secrets.restic-filen-password.path;

        paths = backup-paths;
        exclude = backup-excludes;

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

      proton-fw13 = {
        repository = "rclone:proton:backups/restic/fw13";
        initialize = false;

        passwordFile = config.sops.secrets.restic-proton-password.path;

        paths = backup-paths;
        exclude = backup-excludes;

        extraBackupArgs = [
          "--host=fw13"
          "--json"
          "--pack-size=8"
          "--option=rclone.connections=1"
        ];

        createWrapper = false;
        inhibitsSleep = true;
        progressFps = 0.0166;

        timerConfig = null;
        #  timerConfig = {
        #    OnCalendar = "Sat *-*-* 03:00:00";
        #    Persistent = true;
        #  };
      };
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
        EnvironmentFile = config.sops.templates."rclone-fw13.env".path;
      };
    };

    restic-backups-proton-fw13 = {
      Unit = {
        "X-SwitchMethod" = "keep-old";
      };
    
      Service = {
        EnvironmentFile = config.sops.templates."rclone-fw13.env".path;
      };
    };

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
  };

  config.systemd.user.services.restic-login-notification = {
    Unit = {
      Description = "Show the next Restic backup at Hyprland login";
  
      After = [
        "graphical-session.target"
        "mako.service"
      ];
    };
  
    Service = {
      Type = "oneshot";
  
      ExecStart = "${restic-next-backup}/bin/restic-next-backup --notify";
    };
  };
}
