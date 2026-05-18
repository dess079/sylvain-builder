---
name: suggest-latest-stack
description: Before scaffolding or upgrading, fetches the current latest versions of the locked stack from official sources and proposes a diff against `.sylvain/compatibility-matrix.json`. Read-only. Runs in a forked context to keep results isolated.
argument-hint: "[scope: backend|frontend|all]"
context: fork
user-invocable: true
disable-model-invocation: false
---

# suggest-latest-stack

## Purpose

Make sure every new project — and every dependency upgrade — starts from the **verified current latest** versions of the locked stack, not from training-data assumptions.

## Inputs

- Optional scope argument: `backend`, `frontend`, `all` (default: `all`).
- The current matrix at `.sylvain/compatibility-matrix.json`.

## Sources to consult (in order)

Use the URLs catalogued in `.github/instructions/web-references.instructions.md`. For each tracked component, fetch the **official releases page** (GitHub releases or vendor site).

For each component, return:
- current locked version (from matrix)
- latest stable version (from web)
- latest preview/milestone if any (informative only)
- breaking-changes summary (from release notes)
- patched-CVE list since the locked version

Components to check:

- Spring Boot, Spring Framework, Spring Security, Spring AI, springdoc-openapi
- React, react-dom, react-compiler, eslint-plugin-react-hooks, babel-plugin-react-compiler
- Vite, create-vite, TypeScript, Node.js LTS, ESLint
- Maven, maven-compiler-plugin, maven-surefire-plugin, maven-enforcer-plugin, dependency-check-maven, jacoco-maven-plugin

## Output contract

A Markdown table with columns: Component | Locked | Latest stable | Drift | CVE since lock | ADR required?

Followed by:
1. **Recommended bumps** (semver-patch and minor) — safe to apply automatically.
2. **Proposed bumps requiring ADR** (major versions or behaviour-changing minors).
3. **Status quo** (already on latest).

## Invariants

- This skill **never edits** the matrix or any project file. It only proposes.
- Any major version bump produces a draft ADR entry written to a temporary buffer that the user confirms before persistence.
- If a CVE of HIGH/CRITICAL severity is found on a locked version, mark the bump as **mandatory** and escalate to `security-guardian`.
- Output language matches the developer's language (French or English).

## Validation steps

1. Every URL fetched must come from `web-references.instructions.md`. No ad-hoc URLs.
2. Versions reported as `latest` must exist on the official releases page within the last 30 days; otherwise also report the previous stable.
3. The skill must complete in under 60 seconds; if the network is unavailable, report which sources failed and fall back to matrix values without inventing data.
4. Result is appended to `.sylvain/todo.json` as a `suggestion` task so the developer can resume the decision later.

## When to invoke

- At the start of `scaffold-fullstack-app`.
- At the start of `/upgrade-deps` prompt.
- On demand via `/suggest-latest-stack [scope]`.

## Companion skills

- `audit-pom-dependencies`, `audit-npm-dependencies` — run after a bump is accepted.
- `manage-task-todo` — persist the decision.
