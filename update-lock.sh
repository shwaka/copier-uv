#!/usr/bin/env bash
set -eu

function update_uv_lock() {
    local uv_lock_path="$1"
    echo "Updating $uv_lock_path"
    (
        cd "$(dirname "$uv_lock_path")"
        uv lock
    )
    copierdev sync-testproj "$uv_lock_path" --apply
}

export -f update_uv_lock

copierdev create-testproj
testproj_dir="$(copierdev show-path testproj)"
find "$testproj_dir" -name .venv -prune \
     -o -name uv.lock \
     -exec bash -c 'update_uv_lock "$1"' _ {} \;
