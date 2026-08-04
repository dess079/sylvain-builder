# Copilot — sylvain-builder

Repo-wide GitHub Copilot instructions. Keep durable, non-task-specific, and short.

## Work rules

- Stack: Spring boot 4.0.7, Spring AI 2.0.0-M6, Java 25, React 19.2.6, Vite 8, TypeScript 6.
- Agents route; skills execute. No domain logic in `.agent.md`; no code examples in skills; literals go in `templates/`.
- Every written file stays ≤100 lines. Split before done.
- Docs required: Java public API Javadoc; TS exported functions/components/hooks TSDoc/JSDoc.
- Backend changes require JUnit tests. Frontend changes add no `*.test.{ts,tsx}`.
- Java: records DTOs, virtual threads for blocking work, sealed types, pattern matching, constructor injection.
- React: rely on Compiler 1.0; no manual `useMemo`, `useCallback`, or `React.memo`.
- Non-trivial tasks update `.sylvain/todo.json` from start to finish.
- Security blocks: OWASP Top 10 + LLM Top 10. HIGH+ CVE stops work.
- Versions come from `.sylvain/compatibility-matrix.json`; verify via `.github/instructions/web-references.instructions.md`.
- Reply in the user's language.

## Low-token mode

- Minimize chat tokens by default: infer from evidence; output only result, changed files, validation, blockers.
- Do not restate plans, unchanged todos, tool output, docs, or logs.
- Prefer bullets and fragments. Aim ≤5 bullets unless detail is requested.
- On GitHub issues, PRs, reviews, and notifications: keep only actionable facts; cite files, symbols, or URLs only when useful.
- Trust these instructions and repo memories first. Search only when missing, stale, or contradicted.

## Quick refs

- Read when needed: `docs/PLAN.md`, `docs/ARCHITECTURE.md`, `docs/HOW-TO-EXTEND.md`.
- Check when needed: `.sylvain/compatibility-matrix.json`, `.sylvain/architecture-decisions.md`.
- Full-stack default: `sylvain`; existing app changes: `architect` → `modify-existing-app`.

