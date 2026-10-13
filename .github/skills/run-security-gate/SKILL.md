---
name: run-security-gate
description: Runs the deterministic security gate and returns only its concise report. Use before a commit, after a dependency change, or when source/configuration security may have changed.
context: fork
user-invocable: true
---

# run-security-gate

Run `bash scripts/security-scan.sh` from the repository root.

Do not interpret missing scanners as a clean result. The script writes
`.sylvain/reports/security-scan-current.json`, bound to the exact Git worktree.
Return the failed checks and their remediation. A failure blocks the task.

Never use a bypass. The pre-commit hook accepts only a fresh, passing report for
the exact worktree being committed.
