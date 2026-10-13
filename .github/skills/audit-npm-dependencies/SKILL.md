---
name: audit-npm-dependencies
description: Audits npm dependencies (every package.json) for known CVEs, typosquatting, license risk. Read-only. Blocks on HIGH or CRITICAL findings.
context: fork
---

# audit-npm-dependencies
Me caveman. Me audit-npm-dependencies skill. Me do one thing and keep contract short.

## When to use

- After any `package.json` change.
- On the `pre-commit-security` hook.
- On demand via `/security-scan`.

## Required scans

1. `pnpm audit --prod --audit-level high` — strict.
2. **Socket.dev** (or equivalent) signals: typosquatting, install scripts, network access, supply-chain risk.
3. **License check** — same policy as backend.
4. **Version policy** — every dependency pinned exactly (no `^`, no `~`). Cross-check against `.sylvain/compatibility-matrix.json`.
5. **Test-tooling verification** — allow Vitest and React Testing Library; flag obsolete, duplicate or unpinned test tooling.

## Output

`.sylvain/reports/npm-audit-<timestamp>.md` with the same structure as the POM audit.

## Blocking rules

- Any HIGH+ CVE.
- Any unpinned dep.
- Suspicious package signal (high typosquatting score, recent ownership change, malicious install script).

## Failure modes

- `pnpm` or `node` missing → `blocked`, install instructions in report.
