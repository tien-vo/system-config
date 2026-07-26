{
  config,
  pkgs,
  repository,
}:

pkgs.writeShellApplication {
  name = "proton-drive-sync-restic-fw13";

  runtimeInputs = [
    pkgs.coreutils
    pkgs.findutils
    pkgs.gawk
    pkgs.gnugrep
    pkgs.jq
    pkgs.libnotify
    pkgs.restic
  ];

  text = ''
    password_file="${config.sops.secrets.restic-proton-password.path}"
    proton_drive="${config.home.profileDirectory}/bin/proton-drive"

    remote_repository="/my-files/backups/restic/fw13"
    remote_data="$remote_repository/data"

    state_directory="${config.xdg.stateHome}/proton-drive-sync"
    state_file="$state_directory/fw13.state"
    manifest_file="$state_directory/fw13-batches.tsv"

    mkdir -p "$state_directory"

    phase="initializing"
    completed_batches=0
    total_batches=0
    completed_bytes=0
    total_bytes=0
    percent=0
    current_batch="initializing"
    transferred_items=0
    transferred_bytes=0
    skipped_items=0
    failed_items=0
    next_notification_percent=5

    write_state() {
      temporary_state="$state_file.tmp"

      {
        printf 'phase=%s\n' "$phase"
        printf 'completed_batches=%s\n' "$completed_batches"
        printf 'total_batches=%s\n' "$total_batches"
        printf 'completed_bytes=%s\n' "$completed_bytes"
        printf 'total_bytes=%s\n' "$total_bytes"
        printf 'percent=%s\n' "$percent"
        printf 'current_batch=%s\n' "$current_batch"
        printf 'transferred_items=%s\n' "$transferred_items"
        printf 'transferred_bytes=%s\n' "$transferred_bytes"
        printf 'skipped_items=%s\n' "$skipped_items"
        printf 'failed_items=%s\n' "$failed_items"
      } > "$temporary_state"

      mv \
        --force \
        "$temporary_state" \
        "$state_file"
    }

    fail() {
      message="$1"

      phase="failed"
      write_state

      notify-send \
        --app-name="Restic" \
        --icon="dialog-error" \
        --urgency="critical" \
        "Proton backup sync failed" \
        "$message" \
        || true

      printf 'ERROR: %s\n' "$message" >&2
      exit 1
    }

    path_bytes() {
      path="$1"

      if [[ -f "$path" ]]; then
        stat \
          --format='%s' \
          -- "$path"

        return
      fi

      find "$path" \
        -type f \
        -printf '%s\n' |
      awk '
        { total += $1 }

        END {
          print total + 0
        }
      '
    }

    ensure_remote_folder() {
      path="$1"
      parent="$2"
      name="$3"

      if "$proton_drive" \
        filesystem info \
        "$path" \
        >/dev/null 2>&1
      then
        return
      fi

      "$proton_drive" \
        filesystem create-folder \
        "$parent" \
        "$name"
    }

    notify_progress_thresholds() {
      while (( next_notification_percent <= 95 &&
               percent >= next_notification_percent )); do
        completed_human="$(
          numfmt \
            --to=iec-i \
            --suffix=B \
            "$completed_bytes"
        )"

        total_human="$(
          numfmt \
            --to=iec-i \
            --suffix=B \
            "$total_bytes"
        )"

        notify-send \
          --app-name="Restic" \
          --icon="drive-harddisk" \
          --urgency="low" \
          --hint="int:value:$next_notification_percent" \
          "Proton backup progress" \
          "$next_notification_percent% complete — $completed_human of $total_human" \
          || true

        next_notification_percent="$((next_notification_percent + 5))"
      done
    }

    upload_batch() {
      local_path="$1"
      remote_parent="$2"
      batch_name="$3"
      batch_bytes="$4"

      current_batch="$batch_name"
      transferred_items=0
      transferred_bytes=0
      skipped_items=0
      failed_items=0

      write_state

      printf 'Uploading batch %d/%d: %s\n' \
        "$((completed_batches + 1))" \
        "$total_batches" \
        "$batch_name"

      output_file="$(
        mktemp \
          --tmpdir="$state_directory" \
          proton-drive-output.XXXXXXXX
      )"

      if ! "$proton_drive" \
        filesystem upload \
        --folder-conflict-strategy merge \
        --file-conflict-strategy skip \
        --skip-thumbnails \
        "$local_path" \
        "$remote_parent" \
        --json \
        > "$output_file"
      then
        rm -f -- "$output_file"
        fail "Upload failed while processing $batch_name."
      fi

      if ! jq \
        --exit-status \
        'type == "object"' \
        "$output_file" \
        >/dev/null
      then
        rm -f -- "$output_file"
        fail "Invalid Proton Drive JSON for $batch_name."
      fi

      transferred_items="$(
        jq \
          --raw-output \
          '.transferredItems // 0' \
          "$output_file"
      )"

      transferred_bytes="$(
        jq \
          --raw-output \
          '.transferredBytes // 0' \
          "$output_file"
      )"

      skipped_items="$(
        jq \
          --raw-output \
          '.skippedItems // 0' \
          "$output_file"
      )"

      failed_items="$(
        jq \
          --raw-output \
          '.failedItems // 0' \
          "$output_file"
      )"

      if (( failed_items != 0 )); then
        jq . "$output_file" >&2
        rm -f -- "$output_file"

        fail "Proton Drive reported failed items in $batch_name."
      fi

      rm -f -- "$output_file"

      completed_batches="$((completed_batches + 1))"
      completed_bytes="$((completed_bytes + batch_bytes))"

      if (( total_bytes > 0 )); then
        percent="$((completed_bytes * 100 / total_bytes))"
      else
        percent=100
      fi

      write_state
      notify_progress_thresholds

      completed_human="$(
        numfmt \
          --to=iec-i \
          --suffix=B \
          "$completed_bytes"
      )"

      total_human="$(
        numfmt \
          --to=iec-i \
          --suffix=B \
          "$total_bytes"
      )"

      printf 'Progress: %d/%d batches, %s/%s, %d%%\n' \
        "$completed_batches" \
        "$total_batches" \
        "$completed_human" \
        "$total_human" \
        "$percent"
    }

    write_state

    if [[ ! -d "${repository}" ]]; then
      fail "The local Restic repository does not exist."
    fi

    if [[ ! -x "$proton_drive" ]]; then
      fail "The Proton Drive CLI is not installed."
    fi

    phase="checking"
    current_batch="repository-check"

    write_state

    if ! restic \
      --repo "${repository}" \
      --password-file "$password_file" \
      check
    then
      fail "The local Restic repository failed validation."
    fi

    if find "${repository}/locks" \
      -mindepth 1 \
      -maxdepth 1 \
      -type f \
      -print \
      -quit |
      grep \
        --quiet \
        .
    then
      fail "The local Restic repository is locked."
    fi

    ensure_remote_folder \
      "/my-files/backups" \
      "/my-files" \
      "backups"

    ensure_remote_folder \
      "$remote_repository" \
      "/my-files/backups/restic" \
      "fw13"

    ensure_remote_folder \
      "/my-files/backups/restic" \
      "/my-files/backups" \
      "restic"

    ensure_remote_folder \
      "$remote_repository" \
      "/my-files/backups/restic" \
      "fw13"

    ensure_remote_folder \
      "$remote_data" \
      "$remote_repository" \
      "data"

    : > "$manifest_file"

    for metadata_path in \
      "${repository}/config" \
      "${repository}/keys" \
      "${repository}/index" \
      "${repository}/snapshots"
    do
      if [[ -e "$metadata_path" ]]; then
        batch_name="$(
          basename \
            -- "$metadata_path"
        )"

        batch_bytes="$(
          path_bytes \
            "$metadata_path"
        )"

        printf '%s\t%s\t%s\t%s\n' \
          "$metadata_path" \
          "$remote_repository" \
          "$batch_name" \
          "$batch_bytes" \
          >> "$manifest_file"
      fi
    done

    find "${repository}/data" \
      -mindepth 1 \
      -maxdepth 1 \
      -type d \
      -print0 |
    sort \
      --zero-terminated |
    while IFS= read -r -d "" data_directory; do
      data_prefix="$(
        basename \
          -- "$data_directory"
      )"

      batch_name="data/$data_prefix"

      batch_bytes="$(
        path_bytes \
          "$data_directory"
      )"

      printf '%s\t%s\t%s\t%s\n' \
        "$data_directory" \
        "$remote_data" \
        "$batch_name" \
        "$batch_bytes" \
        >> "$manifest_file"
    done

    total_batches="$(
      wc \
        --lines \
        < "$manifest_file"
    )"

    total_bytes="$(
      awk \
        -F '\t' \
        '{ total += $4 } END { print total + 0 }' \
        "$manifest_file"
    )"

    phase="uploading"
    current_batch="starting"

    write_state

    total_human="$(
      numfmt \
        --to=iec-i \
        --suffix=B \
        "$total_bytes"
    )"

    notify-send \
      --app-name="Restic" \
      --icon="drive-harddisk" \
      --urgency="normal" \
      --hint="int:value:0" \
      "Proton backup upload started" \
      "$total_batches batches totaling $total_human" \
      || true

    while IFS=$'\t' read -r \
      local_path \
      remote_parent \
      batch_name \
      batch_bytes
    do
      upload_batch \
        "$local_path" \
        "$remote_parent" \
        "$batch_name" \
        "$batch_bytes"
    done < "$manifest_file"

    phase="complete"
    percent=100
    current_batch="none"

    write_state

    notify-send \
      --app-name="Restic" \
      --icon="emblem-default" \
      --urgency="normal" \
      --hint="int:value:100" \
      "Proton backup completed" \
      "100% complete — $completed_batches batches totaling $total_human synchronized." \
      || true

    printf 'Proton Drive synchronization completed successfully.\n'
  '';
}
