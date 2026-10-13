#!/usr/bin/env bash
# validate-kit.sh — integrity check for the sylvain-builder orchestration kit.
# Verifies: referenced skills exist, handoff agents exist, templates exist,
# frontmatter keys, runtime adapters and version consistency (matrix vs templates).
set -u
cd "$(dirname "$0")/.." || exit 1

fail=0
warn=0
note() { echo "  $1"; }
err()  { echo "  FAIL: $1"; fail=1; }
wn()   { echo "  WARN: $1"; warn=$((warn + 1)); }

echo "== 1. Skills referenced by agents exist =="
for agent in .github/agents/*.agent.md; do
  for skill in $(grep -o '`[a-z0-9-]*`' "$agent" | tr -d '\`' | sort -u); do
    [ -d ".github/skills/$skill" ] && continue
    case "$skill" in
      sylvain|architect|backend-builder|frontend-builder|database|prompt-caveman|cloudflare-tunnel|security-guardian|quality-gate) continue ;;
    esac
    if grep -q "skills you call" "$agent"; then
      err "agent $(basename "$agent") references missing skill: $skill"
    fi
  done
done
note "done"

echo "== 2. Handoff / agents targets exist =="
for agent in .github/agents/*.agent.md; do
  for target in $(grep -oE "agent: [a-z-]+" "$agent" | awk '{print $2}' | sort -u); do
    [ -f ".github/agents/$target.agent.md" ] || err "$(basename "$agent") hands off to missing agent: $target"
  done
  for target in $(grep -oE "agents: \[.*\]" "$agent" | sed "s/agents: \[//;s/\]//;s/'//g" | tr ',' ' '); do
    [ -f ".github/agents/$target.agent.md" ] || err "$(basename "$agent") lists missing agent: $target"
  done
done
note "done"

echo "== 3. Templates referenced by skills exist =="
for tpl in $(grep -rhoE "templates/[A-Za-z0-9._-]+" .github/skills docs 2>/dev/null | sort -u); do
  [ -f "$tpl" ] || err "referenced template missing: $tpl"
done
note "done"

echo "== 4. Frontmatter minimal contract =="
for agent in .github/agents/*.agent.md; do
  grep -q "^name:" "$agent" || err "$(basename "$agent"): no name field"
  grep -q "^description:" "$agent" || err "$(basename "$agent"): no description field"
  grep -q "shared/orchestration.md" "$agent" || err "$(basename "$agent"): does not load shared/orchestration.md"
done
for skill in .github/skills/*/SKILL.md; do
  grep -q "^name:" "$skill" || err "$(basename "$(dirname "$skill")"): no name field"
  grep -q "^description:" "$skill" || err "$(basename "$(dirname "$skill")"): no description field"
done
note "done"

echo "== 5. Version consistency (matrix is source of truth) =="
python3 - <<'EOF'
import json
import sys
import xml.etree.ElementTree as ET

matrix = json.load(open('.sylvain/compatibility-matrix.json'))
package = json.load(open('templates/package.template.json'))
root = ET.parse('templates/pom.template.xml').getroot()
ns = {'m': 'http://maven.apache.org/POM/4.0.0'}
properties = root.find('m:properties', ns)

checks = {
    'pom Spring Boot': (root.findtext('m:parent/m:version', namespaces=ns), matrix['backend']['springBoot']),
    'pom Java': (properties.findtext('m:java.version', namespaces=ns), matrix['backend']['java']),
    'pom Spring AI': (properties.findtext('m:spring-ai.version', namespaces=ns), matrix['backend']['springAi']),
    'package React': (package['dependencies']['react'], matrix['frontend']['react']),
    'package React DOM': (package['dependencies']['react-dom'], matrix['frontend']['react']),
    'package TypeScript': (package['devDependencies']['typescript'], matrix['frontend']['typescript']),
    'package Vite': (package['devDependencies']['vite'], matrix['frontend']['vite']),
    'package MUI': (package['dependencies']['@mui/material'], matrix['frontend']['mui']),
    'package pnpm': (package['packageManager'].split('@', 1)[1], matrix['frontend']['pnpm']),
}
failed = False
for label, (actual, expected) in checks.items():
    if actual != expected:
        print(f'  FAIL: {label}: expected {expected}, found {actual}')
        failed = True
if failed:
    sys.exit(1)
print('  done')
EOF
[ $? -ne 0 ] && fail=1

if grep -rEn --include="*.md" "(^|[^p])npm (run|install|audit)|(^|[^p])npx " .github/skills .github/agents docs 2>/dev/null | grep -v "audit-npm\|npm CVE\|npm dependencies\|every package.json\|Maven or npm"; then
  wn "possible npm usage left in docs/skills (pnpm is the policy):"
  grep -rEn --include="*.md" "(^|[^p])npm (run|install|audit)|(^|[^p])npx " .github/skills .github/agents docs 2>/dev/null | grep -v "audit-npm\|npm CVE\|npm dependencies\|every package.json\|Maven or npm" | sed 's/^/    /'
fi

echo "== 6. Hook files parse as JSON =="
for hook in .github/hooks/*.json; do
  python3 -m json.tool "$hook" > /dev/null 2>&1 || err "invalid JSON: $hook"
done
note "done"

echo "== 7. Runtime adapters =="
for file in AGENTS.md CLAUDE.md .opencode/opencode.jsonc; do
  [ -f "$file" ] || err "missing runtime adapter: $file"
done
for agent in sylvain architect backend-builder frontend-builder database security-guardian quality-gate; do
  [ -f ".opencode/agents/$agent.md" ] || err "missing OpenCode agent: $agent"
done
python3 -m json.tool .opencode/opencode.jsonc > /dev/null 2>&1 || err "invalid OpenCode JSON: .opencode/opencode.jsonc"
note "done"

echo "== 8. Matrix keys =="
python3 - <<'EOF'
import json, sys
m = json.load(open('.sylvain/compatibility-matrix.json'))
missing = [k for k in ("backend","frontend","security","lockedAt") if k not in m]
if missing:
    print(f"  FAIL: matrix missing keys: {missing}"); sys.exit(1)
print("  done")
EOF
[ $? -ne 0 ] && fail=1

echo
echo "================================"
if [ "$fail" -eq 1 ]; then
  echo "VALIDATE-KIT: FAILED ($warn warnings)"
  exit 1
fi
echo "VALIDATE-KIT: OK ($warn warnings)"
exit 0
