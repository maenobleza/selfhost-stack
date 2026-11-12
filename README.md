# selfhost-stack

Docker Compose examples for a small self-hosted setup. Each directory is self-contained: copy it, fill in `.env`, `docker compose up -d`.

| stack | what it is |
|---|---|
| `proxy/` | Caddy with automatic TLS, single entry point for the stacks below |
| `postiz/` | Postiz social-media scheduler with Postgres and Redis |
| `uptime-kuma/` | Uptime Kuma monitoring |
| `backup/` | restic backup script for Docker volumes, with a restore procedure |

## Status

Study project. The first version of these files was written by Nils Rönnbäck with AI assistance, as learning material for Mae. The compose files pass `docker compose config`, but nothing has been deployed from this repository yet. It is not used for any client or production system.

The stacks are deployed and tested one at a time in the labs in [til/LABS.md](https://github.com/maenobleza/til/blob/main/LABS.md).

## Layout

- One compose project per directory, one external network `proxy` shared with Caddy. Create it once: `docker network create proxy`.
- Secrets only in `.env` (git-ignored). `.env.example` documents the variables.
- Data in named volumes.
- The hostnames in `proxy/Caddyfile` and `postiz/.env.example` are placeholders (`example.com`).

## Backup and restore

`backup/restic-backup.sh` archives every named Docker volume and sends it to a restic repository. The variable names in the script comment are for a Backblaze B2 repository; any restic backend works.

The restore procedure is in `backup/RESTORE.md`. It has not been tested yet. The "Last tested" line there gets filled in after the first real restore.

## Open items

- [ ] First deploy of `uptime-kuma/` on a test machine
- [ ] `proxy/` in front of it, on a test machine without a public domain
- [ ] First backup and restore test, then fill in `backup/RESTORE.md`
- [ ] `postiz/` still uses the `latest` image tag; pin it to the version that was tested
- [ ] Check how the firewall from [vps-baseline](https://github.com/maenobleza/vps-baseline) interacts with Docker published ports

License: MIT
