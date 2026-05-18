---
name: modify-app
description: Safely modifies an already-scaffolded sylvain-builder app — add/change/remove a feature while preserving the locked stack and quality bars.
agent: sylvain
argument-hint: "<short description of the change>"
---

The user wants to modify an existing app. Description: `${input:change}`.

Route via `architect` and invoke the `modify-existing-app` skill.

Mandatory pre-checks (in this order):

1. Confirm `.sylvain/` exists in the workspace (otherwise this is a scaffolding job, not a modification).
2. Run `audit-pom-dependencies` and `audit-npm-dependencies` — block on HIGH+ CVE.
3. Run `enforce-file-size-limit` and `enforce-documentation` to record the baseline.
4. If matrix drift is suspected, run `/suggest-stack` first; do not silently bump.

Then follow the `modify-existing-app` planning + execution + done criteria.

Reply in the developer's language. One PR = one subject (Conventional Commits).
