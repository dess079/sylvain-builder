---
name: scaffold-fullstack-app
description: Scaffolds a new full-stack monorepo (Maven backend + Vite frontend + shared OpenAPI types) using Spring Boot 4.1.1, Spring AI 2.0.1, Java 27, React 19.3 and MUI 9. Use when the user asks to "create", "scaffold", "init" or "bootstrap" a new application from scratch.
---

# scaffold-fullstack-app
Me caveman. Me scaffold-fullstack-app skill. Me do one thing and keep contract short.

## When to use

Brand-new application. No existing `pom.xml` or `package.json` to extend.

## Output layout

```
<app>/
  backend/        — Maven module, Spring Boot 4.1.1, Java 27, Spring AI 2.0.1
  frontend/       — Vite 8 + React 19.3 + MUI 9 + TS 7 + Compiler 1.0
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
7. Copy `vitest.config.ts` and `src/test/setup.ts` from the Vitest templates so frontend tests run from the first feature.
8. Append an ADR entry to `.sylvain/architecture-decisions.md`.

## Validation

- Changed source files over 300 lines have a documented cohesion review.
- `mvn -q validate` passes in `backend/`.
- `pnpm install && pnpm run lint && pnpm run test && pnpm run build` passes in `frontend/`.

## Failure modes

- If the target directory is not empty → stop, ask the user.
- If the matrix says a tool version differs from what is requested → stop, route to `architect` for ADR.
