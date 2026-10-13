---
name: upgrade-deps
description: Audit and upgrade dependencies (pom.xml + every package.json) within the locked compatibility matrix.
agent: security-guardian
---

# /upgrade-deps

1. Run `audit-pom-dependencies` and `audit-npm-dependencies` (both in forked context).
2. Cross-check findings against `.sylvain/compatibility-matrix.json`.
3. Propose patch / minor bumps that resolve HIGH+ CVEs **without** violating the matrix.
4. If a major bump is required to fix a CVE, stop and route to `architect` for an ADR.
5. Hand back to `sylvain` with the proposed changes (do not apply them — let the user review).
