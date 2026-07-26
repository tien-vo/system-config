{ pkgs }:

pkgs.writeShellApplication {
  name = "restic-progress-notifier";

  runtimeInputs = [
    pkgs.jq
    pkgs.libnotify
    pkgs.systemd
  ];

  text = ''
    unit="restic-backups-filen-fw13.service"
    next_percent=5

    notify_progress() {
      percent="$1"

      notify-send \
        --app-name="Restic" \
        --icon="drive-harddisk" \
        --urgency="low" \
        --hint="int:value:$percent" \
        "Filen backup progress" \
        "$percent% complete" \
        || true
    }

    notify_failure() {
      message="$1"

      notify-send \
        --app-name="Restic" \
        --icon="dialog-error" \
        --urgency="critical" \
        "Filen backup failed" \
        "$message" \
        || true
    }

    coproc JOURNAL {
      journalctl \
        --user \
        --follow \
        --unit="$unit" \
        --since=now \
        --output=cat
    }

    journal_pid="''${JOURNAL_PID:?Failed to start journal coprocess}"
    journal_fd="''${JOURNAL[0]}"

    cleanup() {
      kill "$journal_pid" 2>/dev/null || true
      wait "$journal_pid" 2>/dev/null || true
    }

    trap cleanup EXIT

    while IFS= read -r line <&"$journal_fd"; do
      if ! jq \
        --exit-status \
        . \
        >/dev/null 2>&1 \
        <<< "$line"
      then
        continue
      fi

      message_type="$(
        jq \
          --raw-output \
          '.message_type // empty' \
          <<< "$line"
      )"

      case "$message_type" in
        status)
          percent="$(
            jq \
              --raw-output \
              '((.percent_done // 0) * 100) | floor' \
              <<< "$line"
          )"

          while (( next_percent <= 95 &&
                   percent >= next_percent )); do
            notify_progress "$next_percent"
            next_percent="$((next_percent + 5))"
          done
          ;;

        summary)
          notify-send \
            --app-name="Restic" \
            --icon="emblem-default" \
            --urgency="normal" \
            --hint="int:value:100" \
            "Filen backup completed" \
            "100% complete" \
            || true

          break
          ;;

        exit_error)
          message="$(
            jq \
              --raw-output \
              '.message // "Restic reported an error."' \
              <<< "$line"
          )"

          notify_failure "$message"
          break
          ;;
      esac
    done
  '';
}
