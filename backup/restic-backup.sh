#!/usr/bin/env bash
# Nightly snapshot of all named Docker volumes to a restic repo.
# Env: RESTIC_REPOSITORY, RESTIC_PASSWORD, B2_ACCOUNT_ID, B2_ACCOUNT_KEY (from /etc/restic.env, mode 600)
set -euo pipefail
source /etc/restic.env
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
for v in $(docker volume ls -q); do
  docker run --rm -v "$v":/src:ro -v "$TMP":/dst alpine tar czf "/dst/$v.tgz" -C /src .
done
restic backup "$TMP" --tag docker-volumes
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
