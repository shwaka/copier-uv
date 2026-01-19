#!/usr/bin/env bash
set -eu

ignore_dir=.venv
lock_file_name=uv.lock
lock_command=(uv lock)

function update_lock_file() {
    local lock_path="$1"
    echo "Updating $lock_path"
    (
        cd "$(dirname "$lock_path")"
        "${lock_command[@]}"
        git add .
        git commit -m "Update lock file"
    )
    copierdev sync-testproj "$lock_path" --apply
}

export -f update_lock_file

copierdev create-testproj
testproj_dir="$(copierdev show-path testproj)"

find "$testproj_dir" -name "$ignore_dir" -prune \
     -o -name "$lock_file_name" \
     -exec bash -c 'update_lock_file "$1"' _ {} \;
