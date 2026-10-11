---
name: provision-cloudflare-tunnel
description: Provisions a new Cloudflare Tunnel to expose an app (frontend or backend) publicly. Asks clarifying questions before acting — never assumes hostname, port or credentials location. Use when the user asks to expose a new app via Cloudflare or create a tunnel for it.
argument-hint: "<app name to expose>"
user-invocable: true
disable-model-invocation: false
---

# provision-cloudflare-tunnel
Me caveman. Me provision-cloudflare-tunnel skill. Me do one thing and keep contract short.

## Purpose

Carries the contract for exposing a new app through a dedicated Cloudflare
Tunnel, consistent with the tunnels already running in `dockerportail`.

## Mandatory clarifying questions (ask before any action)

1. App name (kebab-case, e.g. `mon-app-backend`)?
2. Frontend or backend? Which internal port does the service listen on (e.g. `3000`, `8080`)?
3. Docker service name / internal hostname on the `app-network` network?
4. Desired public hostname (e.g. `mon-app-backend.sdfullstackdev.ca`) — default zone `sdfullstackdev.ca`?
5. Does this tunnel also need `/api*` path routing to an existing backend (shared hostname)?
6. Is `dockerportail` the target orchestration repo, or a different `docker-compose.yml`?
7. Default credentials directory (`CLOUDFLARE_CREDENTIALS_DIR`), or a different one?

Do not proceed until every answer is known or explicitly confirmed as "use default".

## Execution contract

Reference implementation: `dockerportail/docs/CLOUDFLARE_TUNNEL_GUIDE.md` (canonical steps and file formats — read it before executing).

1. Create the tunnel and capture the generated UUID + credentials JSON.
2. Move the credentials JSON into the confirmed credentials directory.
3. Write the ingress config file for the new tunnel.
4. Create the DNS route for the new hostname.
5. Add the matching `cloudflared-<app-name>` service entry to the target `docker-compose.yml`.
6. Update the port/tunnel registry (`dockerportail/PORTS.md`) — both the per-app table and the tunnel mapping table.
7. Register the app in the apps database (`portail-backend/db_apps_full.sql` pattern) for the `cloud` environment, if the portail registry applies.
8. Start the new tunnel service and verify the hostname resolves over HTTPS.

## Invariants

- Never guess a hostname, tunnel UUID, or credentials path — always confirmed by the user or read from `dockerportail/PORTS.md`.
- One tunnel = one dedicated `cloudflared-<app-name>` service; do not silently reuse an existing tunnel unless the user confirmed shared-hostname routing (question 5).
- `PORTS.md` stays the single source of truth — update it in the same task, not as a follow-up.

## Failure handling

- If tunnel creation or DNS routing fails, surface the exact CLI/API error and stop — do not retry blindly.
- If credentials permissions block the container from starting, report the failing mount and ask before touching file permissions.
