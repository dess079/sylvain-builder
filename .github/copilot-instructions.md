# Copilot — sylvain-builder

This workspace is an orchestration kit for building full-stack apps with **Spring Boot 4.0.6 + Spring AI 2.0.0-M6 + Java 25 + React 19.2.6 + Vite 8 + TypeScript 6** (May 2026 stack).

## Operating rules (always active)

1. **Agents orchestrate, skills execute.** Never put domain logic in `.agent.md`. Skills hold the "how".
2. **No code examples in skills.** The model already knows how to code. If a literal file is required, place it in `templates/` and reference it via Markdown link.
3. **100-line hard cap on every generated file.** Split into sub-modules when a file would exceed this.
4. **Documentation is mandatory** on every class, method, function, component (Javadoc / JSDoc / TSDoc).
5. **Backend = JUnit tests required.** Frontend = **no tests** (no `*.test.{ts,tsx}` files).
6. **Java 25 idioms (2026):** records for DTOs, virtual threads where blocking, sealed types, pattern matching, constructor injection.
7. **React 19 idioms (2026):** rely on React Compiler 1.0 GA — never write manual `useMemo` / `useCallback` / `React.memo`. Use Actions, `use()`, `useOptimistic`, `useTransition`.
8. **Every task starts with a todo list** persisted to `.sylvain/todo.json` so work resumes after interruption.
9. **Security is blocking.** OWASP Top 10 2025 + OWASP LLM Top 10 2025 apply. A HIGH+ CVE stops the workflow until patched.
10. **Versions are verified, never invented.** Before scaffolding or upgrading, the `suggest-latest-stack` skill cross-checks the matrix against the canonical URLs in `instructions/web-references.instructions.md`.
11. **Reply in the language the developer uses** (French or English).

## When in doubt

- Read [docs/PLAN.md](../docs/PLAN.md), [docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md), [docs/HOW-TO-EXTEND.md](../docs/HOW-TO-EXTEND.md).
- Check `.sylvain/compatibility-matrix.json` for locked versions and `.sylvain/architecture-decisions.md` for ADRs.
- Canonical web sources live in [.github/instructions/web-references.instructions.md](instructions/web-references.instructions.md).
- Default agent for anything full-stack: **`sylvain`**. For modifying an existing app, route via `architect` → `modify-existing-app`.

