---
name: generate-typescript-types
description: Generates TypeScript types from the backend OpenAPI spec. Single source of truth — frontend never re-declares backend DTOs by hand. Use after any backend contract change.
---

# generate-typescript-types
Me caveman. Me generate-typescript-types skill. Me do one thing and keep contract short.

## When to use

- Right after `generate-rest-endpoint`, `generate-jpa-entity` or `generate-spring-ai-feature` modify the OpenAPI surface.
- During `frontend-builder` startup if generated types are missing.

## Required behaviour

- Source: `backend/target/openapi.json` (or `/v3/api-docs` if running) produced by `springdoc-openapi`.
- Output: `shared-types/src/api.ts`, importable from the frontend.
- Tool: `openapi-typescript` (preferred) or equivalent — version pinned in `package.json`.
- Generated file is **read-only** — never hand-edit. A header comment marks it as generated.
- Re-running the skill is idempotent: same input → byte-identical output.

## Required rules

- Generated files are exempt from the cohesion review.
- Keep a hand-written `index.ts` focused on a curated public surface.
- Frontend import paths use the curated re-export, not the raw generated file.

## Validation

- `pnpm run build` in `shared-types/` clean.
- `tsc --noEmit` in `frontend/` clean after regeneration.

## Failure modes

- Backend not running and `openapi.json` stale by more than the current branch's last build → ask the user to rebuild backend first.
