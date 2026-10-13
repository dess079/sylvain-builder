# sylvain-builder

This repository is a portable orchestration kit for full-stack projects. Use it with Codex, OpenCode, Claude Code or GitHub Copilot.

## Start here

1. Read `.sylvain/compatibility-matrix.json` before adding or upgrading a dependency.
2. For a non-trivial change, update `.sylvain/todo.json`; preserve its append-only history.
3. Inspect the existing build files, conventions and tests before editing.
4. Implement the smallest complete change, then run the relevant validation commands.
5. Run `bash scripts/validate-kit.sh` after changing this kit's agents, skills, instructions or runtime adapters.

## Stack baseline

- Backend: Java 27, Spring Boot 4.1.1, Spring AI 2.0.1, PostgreSQL.
- Frontend: React 19.3, TypeScript 7, MUI 9.4, Vite 8, Node 26 LTS, pnpm 12.
- Treat `.sylvain/compatibility-matrix.json` as the version contract. Generate manifests suited to the project; use stable releases and record a behaviour-changing upgrade in `.sylvain/architecture-decisions.md`.

## Delivery rules

- Use `rg` for search and `apply_patch` for edits. Preserve unrelated working-tree changes.
- Backend changes need JUnit coverage. Frontend behaviour changes need focused Vitest + React Testing Library coverage.
- Run the narrowest relevant checks first; final gates are Maven tests plus `pnpm run lint`, `pnpm run test`, and `pnpm run build` when those projects exist.
- Treat HIGH or CRITICAL dependency findings, secrets, injection paths and unsafe AI tool inputs as blocking.
- Generated code must be cohesive. Review source files over 300 lines, but do not split code only to satisfy a line count.
- Public contracts deserve useful documentation; avoid boilerplate that only repeats names and types.

## Shared UI components

- Read `.sylvain/shared-components.json` before adding React or MUI UI. Reuse the
  public `shared-components` package before writing any generic component or hook.
- Use `MenuBar` for application toolbars whenever it fits; otherwise retain the
  existing `ThemeSelector` and `PreferencesPanel`/`PreferencesIcon` controls.
- AI screens use `AiChatPanel`, or compose `AiPromptCard` and `AiResponseBlock`.
  Never recreate those prompt and answer surfaces inside an application.
- Promote a generic, backend-agnostic artifact useful to two applications into
  `shared-components`, with tests, public root export and release notes.

## UI design guidance

- For a new or visually reworked interface, read the scoped `frontend-design`
  skill. It guards against generic generated styling while leaving the product
  brief in control.
- For major UI decisions, complex interactions or visual QA, use the local
  search data in `ui-ux-pro-max`; load and query it only when relevant.
- Apply UI guidance through the existing MUI theme and shared-components
  contract. Do not add Tailwind, shadcn or a parallel component library.

## Runtime-specific integrations

- GitHub Copilot: `.github/agents/`, `.github/skills/` and `.github/instructions/` are native customizations.
- OpenCode: select `sylvain` or a specialist from `.opencode/agents/`.
- Claude Code: `CLAUDE.md` imports this file.
- Codex: this `AGENTS.md` is the primary repository instruction file.

The GitHub agent and skill files are optional, task-specific guidance. Read only the smallest relevant instruction or skill; do not preload the kit or force a handoff when direct, scoped work is clearer.
