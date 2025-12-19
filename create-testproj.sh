#!/usr/bin/env bash
set -eu

cd "$(dirname "$0")"

root_dir="$(pwd)"
# template_dir="$root_dir/template"
testproj_dir="$root_dir/testproj"
answers_file="$testproj_dir/.copier-answers.yml"

mkdir -p "$testproj_dir"

# git status
cd "$testproj_dir"
if [ -d "$testproj_dir/.git" ] && [ -n "$(git status --porcelain)" ]; then
    echo "[Error] $testproj_dir has uncommitted changes!"
    git status
    exit 1
fi

# copier copy
cd "$root_dir"
if [ -f "$answers_file" ]; then
    copier copy "$root_dir" "$testproj_dir" --force
else
    copier copy "$root_dir" "$testproj_dir"
fi

# git commit
cd "$testproj_dir"
if [ -d "$testproj_dir/.git" ]; then
    git add .
    git commit -m "Apply changes from template"
else
    git init
    git add .
    git commit -m "Initial commit"
fi
