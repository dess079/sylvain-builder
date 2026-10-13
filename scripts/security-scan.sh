#!/usr/bin/env bash
# Deterministic local security gate for projects generated with sylvain-builder.
# A missing scanner is a failed scan, never a passing scan.
set -uo pipefail

root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "SECURITY_GATE: run inside a Git worktree." >&2
  exit 2
}
cd "$root"

report_dir=".sylvain/reports"
report_file="$report_dir/security-scan-current.json"
mkdir -p "$report_dir"

worktree_hash() {
  python3 scripts/worktree-hash.py
}

head_sha="$(git rev-parse HEAD 2>/dev/null || printf 'UNBORN')"
tree_hash="$(worktree_hash)"
timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
status=0
results=()

record() {
  local label="$1"
  local result="$2"
  results+=("${label}: ${result}")
  printf 'SECURITY_GATE: %s: %s\n' "$label" "$result"
}

require_tool() {
  local tool="$1"
  if command -v "$tool" >/dev/null 2>&1; then
    return 0
  fi
  record "$tool" "BLOCKED (missing executable)"
  status=1
  return 1
}

run_check() {
  local label="$1"
  shift
  if "$@"; then
    record "$label" "PASS"
  else
    record "$label" "FAIL"
    status=1
  fi
}

if require_tool gitleaks; then
  run_check "gitleaks" gitleaks detect --source . --redact --no-banner --config .gitleaks.toml
fi

if source_file="$(find . -path './.git' -prune -o -type f \( -name '*.java' -o -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' \) -not -path '*/node_modules/*' -not -path '*/dist/*' -print -quit)"; then
  if [ -n "$source_file" ]; then
    if require_tool semgrep; then
      if semgrep_expected="$(python3 -c 'import json; print(json.load(open(".sylvain/compatibility-matrix.json"))["security"]["semgrep"])' 2>/dev/null)"; then
        semgrep_actual="$(semgrep --version 2>/dev/null | awk 'NR == 1 { print $1 }')"
        if [ "$semgrep_actual" = "$semgrep_expected" ]; then
          run_check "semgrep" semgrep scan --config .semgrep/security.yml --error --quiet
        else
          record "semgrep" "BLOCKED (expected ${semgrep_expected}, found ${semgrep_actual:-unknown})"
          status=1
        fi
      else
        record "semgrep" "BLOCKED (cannot read pinned version)"
        status=1
      fi
    fi
  else
    record "semgrep" "SKIPPED (no application source files)"
  fi
else
  record "semgrep" "BLOCKED (source discovery failed)"
  status=1
fi

while IFS= read -r -d '' pom; do
  module_dir="$(dirname "$pom")"
  if require_tool mvn; then
    run_check "dependency-check:${pom}" bash -c 'cd "$1" && mvn -q org.owasp:dependency-check-maven:check' _ "$module_dir"
    run_check "spotbugs:${pom}" bash -c 'cd "$1" && mvn -q spotbugs:check' _ "$module_dir"
  fi
done < <(find . -name pom.xml -not -path '*/target/*' -print0)

while IFS= read -r -d '' manifest; do
  module_dir="$(dirname "$manifest")"
  if require_tool pnpm; then
    run_check "pnpm-audit:${manifest}" bash -c 'cd "$1" && pnpm audit --prod --audit-level high' _ "$module_dir"
  fi
done < <(find . -name package.json -not -path '*/node_modules/*' -not -path '*/dist/*' -print0)

if find . \( -name Dockerfile -o -name '*.tf' -o -name 'docker-compose*.yml' -o -name 'docker-compose*.yaml' -o -name Chart.yaml \) -not -path '*/node_modules/*' -print -quit | grep -q .; then
  if require_tool trivy; then
    run_check "trivy" trivy fs --scanners vuln,misconfig,secret --severity HIGH,CRITICAL --exit-code 1 .
  fi
else
  record "trivy" "SKIPPED (no container or IaC scan targets)"
fi

if [ "$status" -eq 0 ]; then result="passed"; else result="failed"; fi

SECURITY_RESULT="$result" SECURITY_HEAD="$head_sha" SECURITY_TREE="$tree_hash" \
SECURITY_TIMESTAMP="$timestamp" SECURITY_DETAILS="$(printf '%s\n' "${results[@]}")" \
python3 - "$report_file" <<'PY'
import json
import os
import sys

with open(sys.argv[1], 'w', encoding='utf-8') as report:
    json.dump({
        'result': os.environ['SECURITY_RESULT'],
        'gitHead': os.environ['SECURITY_HEAD'],
        'worktreeHash': os.environ['SECURITY_TREE'],
        'completedAt': os.environ['SECURITY_TIMESTAMP'],
        'checks': [line for line in os.environ['SECURITY_DETAILS'].splitlines() if line],
    }, report, indent=2)
    report.write('\n')
PY

printf 'SECURITY_GATE: report: %s\n' "$report_file"
[ "$status" -eq 0 ]
