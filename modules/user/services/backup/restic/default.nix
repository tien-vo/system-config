{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
in
{
  config.home.packages = [
    pkgs.age
    pkgs.rclone
    pkgs.restic
    pkgs.sops
  ];

  config.sops = {
    defaultSopsFile = ../../../../../secrets/restic-filen-fw13.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets.restic-filen-password = {
      mode = "0400";
    };
  };

  config.services.restic = {
    enable = true;

    backups.filen-fw13 = {
      repository = "rclone:filen:backups/restic/fw13";

      # The repository already exists.
      initialize = false;

      passwordFile = config.sops.secrets.restic-filen-password.path;

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
        "--verbose"
      ];

      createWrapper = true;
      inhibitsSleep = true;

      timerConfig = null;
      progressFps = 0.0166;
    };
  };
}
