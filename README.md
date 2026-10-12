# selfhost-stack

Docker Compose stacks I run on client and personal servers. Each directory is self-contained: copy it, fill in `.env`, `docker compose up -d`.

| stack | what it is | why I run it |
|---|---|---|
| `proxy/` | Caddy with automatic TLS | single entry point for everything below |
| `postiz/` | Postiz social-media scheduler | scheduling posts for client Facebook/Instagram/LinkedIn pages |
| `uptime-kuma/` | Uptime Kuma | monitoring client sites, alerts to Telegram |

Prerequisite: a server prepared with [vps-baseline](https://github.com/maenobleza/vps-baseline) (Docker installed, ports 80/443 open). Create the shared network once: `docker network create proxy`.

## Conventions

- One compose project per directory, one external network `proxy` shared with Caddy
- Secrets only in `.env` (git-ignored); `.env.example` documents every variable
- Data in named volumes; backed up nightly with restic (see `backup/`)
- Images pinned to a version tag, bumped deliberately and noted in CHANGELOG.md

## Backup and restore

`backup/restic-backup.sh` snapshots the volumes and pushes to a Backblaze B2 bucket. Restore procedure is in `backup/RESTORE.md` and is tested quarterly.

License: MIT
