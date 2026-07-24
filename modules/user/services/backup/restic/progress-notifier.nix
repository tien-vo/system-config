{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "restic-progress-notifier";

  runtimeInputs = with pkgs; [
    coreutils
    jq
    libnotify
    systemd
  ];

  text = ''
        unit="restic-backups-filen-fw13.service"
        tag="restic-filen-fw13"
        started_at="$(date --iso-8601=seconds)"

        backup_is_running() {
          active_state="$(
            systemctl \
              --user \
              show "$unit" \
              --property=ActiveState \
              --value
          )"

          case "$active_state" in
            active | activating | reloading)
              return 0
              ;;
            *)
              return 1
              ;;
          esac
        }

        restic_started=false

        for _ in $(seq 1 30); do
          if backup_is_running; then
            restic_started=true
            break
          fi

          sleep 1
        done

        if [[ "$restic_started" != true ]]; then
          notify-send \
            --app-name="Restic" \
            --icon="dialog-error" \
            --urgency="critical" \
            --hint="string:x-dunst-stack-tag:$tag" \
            --hint="string:synchronous:$tag" \
            "Restic backup did not start" \
            "The backup service did not become active."

          exit 1
        fi

        notify-send \
          --app-name="Restic" \
          --icon="drive-harddisk" \
          --urgency="normal" \
          --hint="string:x-dunst-stack-tag:$tag" \
          --hint="string:synchronous:$tag" \
          "Restic backup started" \
          "Backing up fw13 to Filen"

        while backup_is_running; do
          status="$(
            journalctl \
              --user \
              --unit="$unit" \
              --since="$started_at" \
              --output=cat \
              --no-pager |
              jq -Rrc '
                fromjson?
                | select(.message_type == "status")
              ' |
              tail -n 1
          )"

          if [[ -n "$status" ]]; then
            percent="$(
              jq -r '
                ((.percent_done // 0) * 100)
                | floor
              ' <<< "$status"
            )"

            files_done="$(
              jq -r '.files_done // 0' <<< "$status"
            )"

            total_files="$(
              jq -r '.total_files // 0' <<< "$status"
            )"

            bytes_done="$(
              jq -r '.bytes_done // 0' <<< "$status"
            )"

            total_bytes="$(
              jq -r '.total_bytes // 0' <<< "$status"
            )"

            seconds_remaining="$(
              jq -r '.seconds_remaining // 0' <<< "$status"
            )"

            bytes_done_human="$(
              numfmt \
                --to=iec-i \
                --suffix=B \
                "$bytes_done"
            )"

            total_bytes_human="$(
              numfmt \
                --to=iec-i \
                --suffix=B \
                "$total_bytes"
            )"

            if (( seconds_remaining > 0 )); then
              remaining_human="$(
                printf '%02d:%02d:%02d' \
                  "$((seconds_remaining / 3600))" \
                  "$(((seconds_remaining % 3600) / 60))" \
                  "$((seconds_remaining % 60))"
              )"
            else
              remaining_human="calculating"
            fi

            notify-send \
              --app-name="Restic" \
              --icon="drive-harddisk" \
              --urgency="low" \
              --hint="string:x-dunst-stack-tag:$tag" \
              --hint="string:synchronous:$tag" \
              --hint="int:value:$percent" \
              "Restic backup: $percent%" \
              "$files_done / $total_files files
    $bytes_done_human / $total_bytes_human processed
    Remaining: $remaining_human"
          fi

          sleep 60
        done

        result="$(
          systemctl \
            --user \
            show "$unit" \
            --property=Result \
            --value
        )"

        summary="$(
          journalctl \
            --user \
            --unit="$unit" \
            --since="$started_at" \
            --output=cat \
            --no-pager |
            jq -Rrc '
              fromjson?
              | select(.message_type == "summary")
            ' |
            tail -n 1
        )"

        if [[ "$result" == "success" && -n "$summary" ]]; then
          snapshot="$(
            jq -r '.snapshot_id // "unknown"' <<< "$summary"
          )"

          files="$(
            jq -r '.total_files_processed // 0' <<< "$summary"
          )"

          bytes="$(
            jq -r '.total_bytes_processed // 0' <<< "$summary"
          )"

          bytes_human="$(
            numfmt \
              --to=iec-i \
              --suffix=B \
              "$bytes"
          )"

          notify-send \
            --app-name="Restic" \
            --icon="emblem-default" \
            --urgency="normal" \
            --hint="string:x-dunst-stack-tag:$tag" \
            --hint="string:synchronous:$tag" \
            --hint="int:value:100" \
            "Restic backup completed" \
            "Snapshot: $snapshot
    $files files, $bytes_human processed"
        else
          notify-send \
            --app-name="Restic" \
            --icon="dialog-error" \
            --urgency="critical" \
            --hint="string:x-dunst-stack-tag:$tag" \
            --hint="string:synchronous:$tag" \
            "Restic backup stopped" \
            "Result: $result
    Inspect the user journal for details."
        fi
  '';
}
