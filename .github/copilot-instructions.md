# sylvain-builder

- Read `AGENTS.md` and the smallest matching scoped instruction or skill; do
  not preload agents, skills, historic todos or documentation.
- The compatibility matrix is the version contract. Check it before a dependency
  change; research official sources only when upgrading or when knowledge may be stale.
- Record only non-trivial, multi-step work in `.sylvain/todo.json`.
- Preserve required tests, MUI/shared-components reuse and the executable
  security gate. HIGH/CRITICAL findings, secrets, injection paths and unsafe AI
  tool inputs block delivery.
- Reply in the user's language. Report result, changed files, validation and
  blockers concisely.
