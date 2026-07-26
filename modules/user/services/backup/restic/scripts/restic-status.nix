{ config, machine-name, pkgs }:

pkgs.writeShellApplication {
  name = "restic-status";

  runtimeInputs = [
    pkgs.coreutils
    pkgs.gnugrep
    pkgs.jq
    pkgs.procps
    pkgs.restic
    pkgs.systemd
  ];

  text = ''
    filen_service="restic-backups-filen-${machine-name}.service"
    filen_timer="restic-backups-filen-${machine-name}.timer"
    filen_repository="rclone:filen:backups/restic/${machine-name}"

    proton_service="restic-backups-proton-local-${machine-name}.service"
    proton_timer="restic-backups-proton-local-${machine-name}.timer"
    proton_sync_service="proton-sync-restic-${machine-name}.service"

    proton_local_repository="${config.xdg.stateHome}/restic/proton/${machine-name}"
    proton_remote_repository="/my-files/backups/restic/${machine-name}"
    proton_password="${config.sops.secrets.restic-proton-password.path}"
    proton_cli="${config.home.profileDirectory}/bin/proton-drive"
    proton_state="${config.xdg.stateHome}/proton-sync/${machine-name}.state"

    watch_mode=false

    case "''${1:-}" in
      "")
        ;;

      --watch)
        exec watch \
          --interval 2 \
          --no-title \
          "$0" \
          --watch-once
        ;;

      --watch-once)
        watch_mode=true
        ;;

      *)
        printf 'Usage: restic-status [--watch]\n' >&2
        exit 2
        ;;
    esac

    service_field() {
      unit="$1"
      field="$2"

      systemctl \
        --user \
        show "$unit" \
        --property="$field" \
        --value \
        2>/dev/null \
        || true
    }

    unit_running() {
      unit="$1"

      active="$(
        service_field "$unit" ActiveState
      )"

      [[ "$active" == "active" ||
         "$active" == "activating" ]]
    }

    timer_next() {
      timer="$1"

      next="$(
        service_field "$timer" NextElapseUSecRealtime
      )"

      if [[ -n "$next" ]]; then
        printf '%s' "$next"
      else
        printf 'not scheduled'
      fi
    }

    timer_last() {
      timer="$1"

      last="$(
        service_field "$timer" LastTriggerUSec
      )"

      if [[ -n "$last" ]]; then
        printf '%s' "$last"
      else
        printf 'not recorded'
      fi
    }

    timer_state() {
      timer="$1"

      active="$(
        systemctl --user is-active "$timer" 2>/dev/null || true
      )"

      enabled="$(
        systemctl --user is-enabled "$timer" 2>/dev/null || true
      )"

      printf '%s, %s' \
        "''${active:-unknown}" \
        "''${enabled:-unknown}"
    }

    print_unit_result() {
      unit="$1"

      active="$(
        service_field "$unit" ActiveState
      )"

      sub="$(
        service_field "$unit" SubState
      )"

      result="$(
        service_field "$unit" Result
      )"

      status="$(
        service_field "$unit" ExecMainStatus
      )"

      started="$(
        service_field "$unit" ExecMainStartTimestamp
      )"

      if [[ "$active" == "active" ||
            "$active" == "activating" ]]; then
        printf 'running (%s/%s)' \
          "$active" \
          "$sub"
      elif [[ -z "$started" ]]; then
        printf 'not run'
      elif [[ "$result" == "success" &&
              "$status" == "0" ]]; then
        printf 'success'
      elif [[ "$result" == "exit-code" ||
              "$result" == "signal" ||
              "$active" == "failed" ]]; then
        printf 'failed (%s, exit %s)' \
          "''${result:-unknown}" \
          "''${status:-unknown}"
      else
        printf '%s/%s, result=%s, exit=%s' \
          "''${active:-unknown}" \
          "''${sub:-unknown}" \
          "''${result:-unknown}" \
          "''${status:-unknown}"
      fi
    }

    latest_restic_status() {
      unit="$1"

      started="$(
        service_field "$unit" ExecMainStartTimestamp
      )"

      if [[ -z "$started" ]]; then
        return
      fi

      journalctl \
        --user \
        --unit="$unit" \
        --since="$started" \
        --output=cat \
        --no-pager \
        2>/dev/null |
      jq \
        --raw-input \
        --compact-output \
        'fromjson?
         | select(
             .message_type == "status"
             or .message_type == "summary"
             or .message_type == "exit_error"
           )' |
      tail --lines=1
    }

    print_restic_progress() {
      unit="$1"

      status_json="$(
        latest_restic_status "$unit"
      )"

      if [[ -z "$status_json" ]]; then
        printf 'unavailable'
        return
      fi

      message_type="$(
        jq --raw-output '.message_type' <<< "$status_json"
      )"

      case "$message_type" in
        status)
          percent="$(
            jq \
              --raw-output \
              '((.percent_done // 0) * 100) | floor' \
              <<< "$status_json"
          )"

          files_done="$(
            jq --raw-output '.files_done // 0' <<< "$status_json"
          )"

          total_files="$(
            jq --raw-output '.total_files // 0' <<< "$status_json"
          )"

          bytes_done="$(
            jq --raw-output '.bytes_done // 0' <<< "$status_json"
          )"

          total_bytes="$(
            jq --raw-output '.total_bytes // 0' <<< "$status_json"
          )"

          bytes_done_human="$(
            numfmt --to=iec-i --suffix=B "$bytes_done"
          )"

          total_bytes_human="$(
            numfmt --to=iec-i --suffix=B "$total_bytes"
          )"

          printf '%s%% — %s/%s files — %s/%s' \
            "$percent" \
            "$files_done" \
            "$total_files" \
            "$bytes_done_human" \
            "$total_bytes_human"
          ;;

        summary)
          printf '100%% — completed'
          ;;

        exit_error)
          message="$(
            jq \
              --raw-output \
              '.message // "unknown error"' \
              <<< "$status_json"
          )"

          printf 'failed — %s' "$message"
          ;;
      esac
    }

    filen_repository_id() {
      if [[ "$watch_mode" == true ]]; then
        printf 'not checked in watch mode'
        return
      fi

      repository_id="$(
        restic-filen-${machine-name} \
          cat config \
          2>/dev/null |
        jq --raw-output '.id // empty' \
          2>/dev/null \
          || true
      )"

      if [[ -n "$repository_id" ]]; then
        printf '%s' "$repository_id"
      else
        printf 'unavailable'
      fi
    }

    filen_repository_access() {
      if [[ "$watch_mode" == true ]]; then
        printf 'not checked in watch mode'
        return
      fi

      if restic-filen-${machine-name} \
        cat config \
        >/dev/null 2>&1
      then
        printf 'available'
      else
        printf 'unavailable'
      fi
    }

    latest_filen_snapshot() {
      if [[ "$watch_mode" == true ]]; then
        printf 'not checked in watch mode'
        return
      fi

      if ! command -v restic-filen-${machine-name} \
        >/dev/null 2>&1
      then
        printf 'wrapper unavailable'
        return
      fi

      snapshot="$(
        restic-filen-${machine-name} \
          snapshots \
          --host "${machine-name}" \
          --latest 1 \
          --json \
          2>/dev/null |
        jq \
          --raw-output \
          '.[0]
           | if . == null then
               empty
             else
               "\(.id[0:8]) — \(.time)"
             end' \
          2>/dev/null \
          || true
      )"

      if [[ -n "$snapshot" ]]; then
        printf '%s' "$snapshot"
      else
        printf 'none or unavailable'
      fi
    }

    proton_repository_id() {
      if [[ ! -d "$proton_local_repository" ]]; then
        printf 'local repository missing'
        return
      fi

      repository_id="$(
        restic \
          --repo "$proton_local_repository" \
          --password-file "$proton_password" \
          cat config \
          2>/dev/null |
        jq --raw-output '.id // empty' \
          2>/dev/null \
          || true
      )"

      if [[ -n "$repository_id" ]]; then
        printf '%s' "$repository_id"
      else
        printf 'unavailable'
      fi
    }

    proton_repository_size() {
      if [[ -d "$proton_local_repository" ]]; then
        du \
          --summarize \
          --human-readable \
          "$proton_local_repository" |
        cut --fields=1
      else
        printf 'local repository missing'
      fi
    }

    proton_remote_access() {
      if [[ "$watch_mode" == true ]]; then
        printf 'not checked in watch mode'
        return
      fi

      if [[ ! -x "$proton_cli" ]]; then
        printf 'CLI unavailable'
        return
      fi

      if "$proton_cli" \
        filesystem info \
        "$proton_remote_repository" \
        >/dev/null 2>&1
      then
        printf 'available'
      else
        printf 'unavailable'
      fi
    }

    latest_proton_snapshot() {
      if [[ ! -d "$proton_local_repository" ]]; then
        printf 'local repository missing'
        return
      fi

      snapshot="$(
        restic \
          --repo "$proton_local_repository" \
          --password-file "$proton_password" \
          snapshots \
          --host "${machine-name}" \
          --latest 1 \
          --json \
          2>/dev/null |
        jq \
          --raw-output \
          '.[0]
           | if . == null then
               empty
             else
               "\(.id[0:8]) — \(.time)"
             end' \
          2>/dev/null \
          || true
      )"

      if [[ -n "$snapshot" ]]; then
        printf '%s' "$snapshot"
      else
        printf 'none or unavailable'
      fi
    }

    state_value() {
      key="$1"

      if [[ ! -f "$proton_state" ]]; then
        return
      fi

      grep \
        --max-count=1 \
        "^$key=" \
        "$proton_state" |
      cut \
        --delimiter='=' \
        --fields=2-
    }

    print_proton_sync_progress() {
      if [[ ! -f "$proton_state" ]]; then
        printf 'state unavailable'
        return
      fi

      phase="$(
        state_value phase
      )"

      percent="$(
        state_value percent
      )"

      completed_batches="$(
        state_value completed_batches
      )"

      total_batches="$(
        state_value total_batches
      )"

      completed_bytes="$(
        state_value completed_bytes
      )"

      total_bytes="$(
        state_value total_bytes
      )"

      current_batch="$(
        state_value current_batch
      )"

      transferred_items="$(
        state_value transferred_items
      )"

      transferred_bytes="$(
        state_value transferred_bytes
      )"

      skipped_items="$(
        state_value skipped_items
      )"

      failed_items="$(
        state_value failed_items
      )"

      completed_human="$(
        numfmt \
          --to=iec-i \
          --suffix=B \
          "''${completed_bytes:-0}"
      )"

      total_human="$(
        numfmt \
          --to=iec-i \
          --suffix=B \
          "''${total_bytes:-0}"
      )"

      transferred_human="$(
        numfmt \
          --to=iec-i \
          --suffix=B \
          "''${transferred_bytes:-0}"
      )"

      printf '%s — %s%% — %s/%s batches — %s/%s' \
        "''${phase:-unknown}" \
        "''${percent:-0}" \
        "''${completed_batches:-0}" \
        "''${total_batches:-0}" \
        "$completed_human" \
        "$total_human"

      if [[ "$phase" == "uploading" ]]; then
        printf ' — current: %s' \
          "''${current_batch:-unknown}"
      fi

      printf '\n'
      printf '  Last batch:     transferred %s items/%s — skipped %s — failed %s' \
        "''${transferred_items:-0}" \
        "$transferred_human" \
        "''${skipped_items:-0}" \
        "''${failed_items:-0}"
    }

    filen_active="$(
      service_field "$filen_service" ActiveState
    )"

    proton_active="$(
      service_field "$proton_service" ActiveState
    )"

    proton_sync_active="$(
      service_field "$proton_sync_service" ActiveState
    )"

    printf 'Backup status for %s\n' "${machine-name}"
    printf '%s\n' \
      '========================================'

    printf '\nFilen\n'
    printf '  Repository:    %s\n' "$filen_repository"
    printf '  Repository ID: %s\n' "$(filen_repository_id)"
    printf '  Remote access: %s\n' "$(filen_repository_access)"
    printf '  Remote size:   not reported by Restic\n'

    printf '  Service:       '
    print_unit_result "$filen_service"
    printf '\n'

    printf '  Progress:      '
    if unit_running "$filen_service"; then
      print_restic_progress "$filen_service"
    else
      printf 'idle'
    fi
    printf '\n'

    printf '  Last snapshot: %s\n' \
      "$(latest_filen_snapshot)"

    printf '  Timer:         %s\n' \
      "$(timer_state "$filen_timer")"

    printf '  Last trigger:  %s\n' \
      "$(timer_last "$filen_timer")"

    printf '  Next backup:   %s\n' \
      "$(timer_next "$filen_timer")"

    printf '\nProton\n'
    printf '  Local repo:     %s\n' "$proton_local_repository"
    printf '  Repository ID:  %s\n' "$(proton_repository_id)"
    printf '  Local size:     %s\n' "$(proton_repository_size)"
    printf '  Remote repo:    %s\n' "$proton_remote_repository"
    printf '  Remote access:  %s\n' "$(proton_remote_access)"
    printf '  Remote size:    unavailable through Proton CLI\n'

    printf '  Local backup:   '
    print_unit_result "$proton_service"
    printf '\n'

    printf '  Local progress: '
    if unit_running "$proton_service"; then
      print_restic_progress "$proton_service"
    else
      printf 'idle'
    fi
    printf '\n'

    printf '  Sync service:   '
    print_unit_result "$proton_sync_service"
    printf '\n'

    printf '  Sync progress:  '
    print_proton_sync_progress
    printf '\n'

    printf '  Last snapshot:  %s\n' \
      "$(latest_proton_snapshot)"

    printf '  Timer:          %s\n' \
      "$(timer_state "$proton_timer")"

    printf '  Last trigger:   %s\n' \
      "$(timer_last "$proton_timer")"

    printf '  Next backup:    %s\n' \
      "$(timer_next "$proton_timer")"

    printf '\nOverall\n'

    if [[ "$filen_active" == "failed" ||
          "$proton_active" == "failed" ||
          "$proton_sync_active" == "failed" ]]; then
      printf '  Status: attention required\n'
    elif unit_running "$filen_service" ||
         unit_running "$proton_service" ||
         unit_running "$proton_sync_service"; then
      printf '  Status: backup in progress\n'
    else
      printf '  Status: idle\n'
    fi
  '';
}
