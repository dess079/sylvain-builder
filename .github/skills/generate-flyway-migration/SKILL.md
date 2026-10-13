---
name: generate-flyway-migration
description: Creates a safe, reversible-minded Flyway migration for a PostgreSQL schema change. Use for tables, indexes, constraints, data backfills or Row Level Security policies.
---

# generate-flyway-migration

## When to use

Before code that depends on a PostgreSQL schema change is merged.

## Required rules

- Inspect existing migrations and database naming conventions first. Never rewrite an applied migration.
- Name the new versioned file according to the project convention and use PostgreSQL-safe, transactional SQL where possible.
- State the forward change, migration impact, locking risk, rollback approach and data backfill strategy in the task notes.
- Add primary keys, foreign keys, unique constraints, `NOT NULL` rules and indexes only when the domain and query path justify them.
- For large tables, use an expand-migrate-contract sequence; avoid long blocking rewrites and concurrent-index operations inside transactions.
- Scope tenant data in schema and query design. Evaluate Row Level Security explicitly when tenancy or privileged access applies.
- Use parameterised access in application code; never assemble SQL from untrusted values.

## Validation

- Flyway validates and applies against PostgreSQL Testcontainers.
- The persistence integration test covers the changed constraint or query path.
- `scan-source-vulnerabilities` finds no injection or access-control regression.

## Failure modes

- Unknown production table size, availability requirement or data-retention rule: stop and request that operational constraint.
- Destructive migration with no accepted backup or rollback plan: block the task.
