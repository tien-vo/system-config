{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "restic-next-backup";

  runtimeInputs = with pkgs; [
    coreutils
    libnotify
    systemd
  ];

  text = ''
    timer="restic-backups-filen-fw13.timer"
    service="restic-backups-filen-fw13.service"
    notify=false

    case "$#" in
      0)
        ;;
      1)
        if [[ "$1" == "--notify" ]]; then
          notify=true
        else
          echo "Usage: restic-next-backup [--notify]" >&2
          exit 2
        fi
        ;;
      *)
        echo "Usage: restic-next-backup [--notify]" >&2
        exit 2
        ;;
    esac

    service_state="$(
      systemctl \
        --user \
        show "$service" \
        --property=ActiveState \
        --value \
        2>/dev/null ||
        true
    )"

    timer_load_state="$(
      systemctl \
        --user \
        show "$timer" \
        --property=LoadState \
        --value \
        2>/dev/null ||
        true
    )"

    case "$service_state" in
      active | activating | reloading)
        title="Restic backup is running"
        message="fw13 is currently backing up to Filen."
        ;;
      *)
        if [[ -z "$timer_load_state" ||
              "$timer_load_state" == "not-found" ]]; then
          title="No Restic backup is scheduled"
          message="The fw13 backup timer is not installed; backups run manually."
        else
          timer_state="$(
            systemctl \
              --user \
              show "$timer" \
              --property=ActiveState \
              --value
          )"

          next_elapse="$(
            systemctl \
              --user \
              show "$timer" \
              --property=NextElapseUSecRealtime \
              --value
          )"

          if [[ "$timer_state" != "active" ]]; then
            title="Restic backup timer is inactive"
            message="Timer: $timer"
          elif [[ -z "$next_elapse" ||
                  "$next_elapse" == "n/a" ]]; then
            title="No next Restic backup is scheduled"
            message="The timer is active but has no next calendar elapse."
          else
            next_local="$(
              date \
                --date="$next_elapse" \
                "+%A, %Y-%m-%d %H:%M:%S %Z"
            )"

            title="Next Restic backup"
            message="$next_local"
          fi
        fi
        ;;
    esac

    printf '%s\n%s\n' \
      "$title" \
      "$message"

    if [[ "$notify" == true ]]; then
      notify-send \
        --app-name="Restic" \
        --icon="drive-harddisk" \
        --urgency="normal" \
        --hint="string:x-dunst-stack-tag:restic-next-backup" \
        --hint="string:synchronous:restic-next-backup" \
        "$title" \
        "$message"
    fi
  '';
}
