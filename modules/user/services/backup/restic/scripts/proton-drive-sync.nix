{ config, pkgs, repository }:
pkgs.writeShellApplication {
  name = "proton-drive-sync-restic-fw13";

  runtimeInputs = [
    pkgs.coreutils
    pkgs.findutils
    pkgs.libnotify
    pkgs.restic
  ];

  text = ''
    password_file="${config.sops.secrets.restic-proton-password.path}"
    proton_drive="${config.home.profileDirectory}/bin/proton-drive"
    remote_parent="/my-files/backups/restic"

    if [[ ! -d "${repository}" ]]; then
      notify-send \
        --app-name="Restic" \
        --icon="dialog-error" \
        --urgency="critical" \
        "Proton backup sync failed" \
        "The local Restic repository does not exist."

      exit 1
    fi

    if [[ ! -x "$proton_drive" ]]; then
      notify-send \
        --app-name="Restic" \
        --icon="dialog-error" \
        --urgency="critical" \
        "Proton backup sync failed" \
        "The Proton Drive CLI is not installed."

      exit 1
    fi

    restic \
      --repo "${repository}" \
      --password-file "$password_file" \
      check

    "$proton_drive" filesystem upload \
      --folder-conflict-strategy merge \
      --file-conflict-strategy skip \
      --skip-thumbnails \
      "${repository}" \
      "$remote_parent"

    notify-send \
      --app-name="Restic" \
      --icon="emblem-default" \
      --urgency="normal" \
      "Proton backup completed" \
      "The local repository was validated and uploaded."
  '';
}
