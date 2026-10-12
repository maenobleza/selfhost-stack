# Restore

1. `restic snapshots` — pick the snapshot id.
2. `restic restore <id> --target /tmp/restore`
3. Recreate the volume and untar:
   `docker volume create kuma_data && docker run --rm -v kuma_data:/dst -v /tmp/restore/<path>:/src alpine tar xzf /src/kuma_data.tgz -C /dst`
4. `docker compose up -d` in the stack directory.

Last tested: (date, result)
