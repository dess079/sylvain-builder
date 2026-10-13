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
2. Generate project-specific Maven and pnpm manifests plus a committed `pnpm-lock.yaml`. Pin the baseline versions from `.sylvain/compatibility-matrix.json`; use the POM and package instructions for mandatory plugins, dependencies, scripts and security checks.
3. Add a project-appropriate `.gitignore` covering dependencies, build output, reports and secrets.
4. Configure `spring.threads.virtual.enabled=true` in `application.yml`.
5. Generate `vite.config.ts` per the contract in `instructions/frontend.instructions.md` (React Compiler enabled, `build.target: 'es2024'`) and set up Vitest + React Testing Library from the first behavioural feature.
6. Copy the security automation (`scripts/`, `.gitleaks.toml`, `.semgrep/`, `.github/hooks/`, `.github/workflows/security.yml` and `.github/dependabot.yml`) into the generated app and retain the matching rules in `AGENTS.md`.
7. Copy `.sylvain/shared-components.json`, then configure `shared-components` through the intended workspace, private registry or reviewed local link. Do not substitute it with application copies. The root uses `AppProviders`; the toolbar uses `MenuBar` (or `ThemeSelector` + `PreferencesPanel`); AI screens use `AiChatPanel` or `AiPromptCard` + `AiResponseBlock`.
8. Append an ADR entry to `.sylvain/architecture-decisions.md`.

## Validation

- Changed source files over 300 lines have a documented cohesion review.
- `mvn -q validate` passes in `backend/`.
- `pnpm install --frozen-lockfile && pnpm run lint && pnpm run test && pnpm run build` passes in `frontend/`.

## Failure modes

- If the target directory is not empty → stop, ask the user.
- If the matrix says a tool version differs from what is requested → stop, route to `architect` for ADR.
