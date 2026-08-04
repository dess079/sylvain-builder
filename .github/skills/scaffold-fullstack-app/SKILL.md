---
name: scaffold-fullstack-app
description: Scaffolds a new full-stack monorepo (Maven backend + Vite frontend + shared OpenAPI types) using Spring boot 4.0.7, Spring AI 2.0.0-M6, Java 25, React 19.2.6. Use when the user asks to "create", "scaffold", "init" or "bootstrap" a new application from scratch.
---

# scaffold-fullstack-app
Me caveman. Me scaffold-fullstack-app skill. Me do one thing and keep contract short.

## When to use

Brand-new application. No existing `pom.xml` or `package.json` to extend.

## Output layout

```
<app>/
  backend/        — Maven module, Spring boot 4.0.7, Java 25, Spring AI 2.0.0-M6
  frontend/       — Vite 8 + React 19.2.6 + TS 6.0 + Compiler 1.0
  shared-types/   — generated TS types from backend OpenAPI
  pom.xml         — root parent POM
  package.json    — workspaces config
```

## Required steps

1. Create the directory tree above.
2. Use [templates/pom.template.xml](../../../templates/pom.template.xml) and [templates/package.template.json](../../../templates/package.template.json) as version/plugin manifests. Copy and adjust artifact id, group id, names — never edit the template in place.
3. Pin every version against `.sylvain/compatibility-matrix.json`. Reject anything that drifts.
4. Add `.gitignore` from [templates/.gitignore.template](../../../templates/.gitignore.template).
5. Configure `spring.threads.virtual.enabled=true` in `application.yml`.
6. Generate `vite.config.ts` per the contract in `instructions/frontend.instructions.md` (React Compiler enabled, `build.target: 'es2024'`).
7. Append an ADR entry to `.sylvain/architecture-decisions.md`.

## Validation

- All files written are ≤ 100 lines.
- `mvn -q validate` passes in `backend/`.
- `npm install && npm run build` passes in `frontend/`.

## Failure modes

- If the target directory is not empty → stop, ask the user.
- If the matrix says a tool version differs from what is requested → stop, route to `architect` for ADR.
