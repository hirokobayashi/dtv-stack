#!/usr/bin/env bash
# Apply all patches for an app: patches/<app>/*.patch, in sorted order.
# Usage: apply-patches.sh <app> <repo-dir>
# Fails loudly (before touching anything) if any patch no longer applies,
# which is the signal that an upstream update drifted past a patch.
set -euo pipefail

cd "$(dirname "$0")/.."

app="$1"
dir="$2"

shopt -s nullglob
patches=(patches/"$app"/*.patch)
shopt -u nullglob

if [[ ${#patches[@]} -eq 0 ]]; then
    echo "apply-patches.sh: no patches for '$app', skipping"
    exit 0
fi

# git -C <dir> apply resolves relative paths inside <dir>; absolutize first
for i in "${!patches[@]}"; do
    patches[$i]="$(realpath "${patches[$i]}")"
done

for p in "${patches[@]}"; do
    echo "apply-patches.sh: check $(basename "$p")"
    git -C "$dir" apply --check "$p"
done

for p in "${patches[@]}"; do
    echo "apply-patches.sh: apply $(basename "$p")"
    git -C "$dir" apply "$p"
done
