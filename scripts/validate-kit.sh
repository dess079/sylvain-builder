#!/usr/bin/env bash
# validate-kit.sh — integrity check for the sylvain-builder orchestration kit.
# Verifies: referenced skills exist, handoff agents exist, templates exist,
# frontmatter keys, and version consistency (matrix vs docs/agents/skills).
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
      sylvain|architect|backend-builder|frontend-builder|security-guardian|quality-gate) continue ;;
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
SB_LOCKED=$(python3 -c "import json;print(json.load(open('.sylvain/compatibility-matrix.json'))['backend']['springBoot'])")
SA_LOCKED=$(python3 -c "import json;print(json.load(open('.sylvain/compatibility-matrix.json'))['backend']['springAi'])")
TS_LOCKED=$(python3 -c "import json;print(json.load(open('.sylvain/compatibility-matrix.json'))['frontend']['typescript'])")
REACT_LOCKED=$(python3 -c "import json;print(json.load(open('.sylvain/compatibility-matrix.json'))['frontend']['react'])")

scan_versions() {
  local stale=0
  while IFS=: read -r file line text; do
    case "$text" in *"compatibility-matrix"*|*"_doc"*|*"ADR"*|*"adr"*|*"aligné"*|"aligned"*) continue ;; esac
    if echo "$text" | grep -qE "Spring [Bb]oot 4\.0\.[0-6]([^0-9.]|$)"; then
      wn "stale Spring Boot version ($SB_LOCKED expected): $file:$line"; stale=1
    fi
    if echo "$text" | grep -qE "spring-ai-bom:1\.[0-9]+"; then
      wn "stale Spring AI BOM ($SA_LOCKED expected): $file:$line"; stale=1
    fi
    if echo "$text" | grep -qE "Spring AI 1\.[0-9]+"; then
      wn "stale Spring AI version ($SA_LOCKED expected): $file:$line"; stale=1
    fi
  done < <(grep -rn --include="*.md" -iE "spring (boot|ai)|spring-ai-bom" .github docs README.md 2>/dev/null | grep -v "GRAPH_REPORT")
  [ "$stale" -eq 0 ] && note "no stale backend versions"
}

scan_versions
while IFS=: read -r file line text; do
  if echo "$text" | grep -qE "typescript@(~)?5\.|vite@(~)?6\." ; then
    wn "stale frontend version (TS $TS_LOCKED / Vite 8.0.11 expected): $file:$line"
  fi
done < <(grep -rn --include="*.md" -E "typescript@|vite@" .github docs 2>/dev/null)

if grep -rEn --include="*.md" "(^|[^p])npm (run|install|audit)|(^|[^p])npx " .github/skills .github/agents docs 2>/dev/null | grep -v "audit-npm\|npm CVE\|npm dependencies\|every package.json\|Maven or npm"; then
  wn "possible npm usage left in docs/skills (pnpm is the policy):"
  grep -rEn --include="*.md" "(^|[^p])npm (run|install|audit)|(^|[^p])npx " .github/skills .github/agents docs 2>/dev/null | grep -v "audit-npm\|npm CVE\|npm dependencies\|every package.json\|Maven or npm" | sed 's/^/    /'
fi

echo "== 6. Hook files parse as JSON =="
for hook in .github/hooks/*.json; do
  python3 -m json.tool "$hook" > /dev/null 2>&1 || err "invalid JSON: $hook"
done
note "done"

echo "== 7. Matrix keys =="
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