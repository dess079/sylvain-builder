#!/usr/bin/env bash
# validate-kit.sh — integrity check for the sylvain-builder orchestration kit.
# Verifies: referenced skills exist, handoff agents exist, concise runtime
# guidance, security assets, runtime adapters and version-contract completeness.
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

echo "== 3. No boilerplate templates =="
if [ -d templates ] && find templates -type f -print -quit | grep -q .; then
  err "boilerplate templates remain; use the matrix and scoped instructions instead"
fi
note "done"

echo "== 4. Frontmatter minimal contract =="
for agent in .github/agents/*.agent.md; do
  grep -q "^name:" "$agent" || err "$(basename "$agent"): no name field"
  grep -q "^description:" "$agent" || err "$(basename "$agent"): no description field"
done
for skill in .github/skills/*/SKILL.md; do
  grep -q "^name:" "$skill" || err "$(basename "$(dirname "$skill")"): no name field"
  grep -q "^description:" "$skill" || err "$(basename "$(dirname "$skill")"): no description field"
done
note "done"

echo "== 5. Version contract completeness =="
python3 - <<'EOF'
import json
import sys

matrix = json.load(open('.sylvain/compatibility-matrix.json'))
required = {
    'backend': ('java', 'springBoot', 'springAi', 'maven', 'owaspDependencyCheckPlugin', 'spotbugsMavenPlugin', 'findSecBugsPlugin'),
    'frontend': ('node', 'react', 'vite', 'typescript', 'mui', 'pnpm'),
    'security': ('owaspTop10', 'owaspLlmTop10', 'semgrep', 'blockingSeverity'),
}
missing = [f'{section}.{key}' for section, keys in required.items() for key in keys if not matrix.get(section, {}).get(key)]
if missing:
    print(f'  FAIL: compatibility matrix missing: {", ".join(missing)}')
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

echo "== 6b. Deterministic security gate assets =="
for file in scripts/security-scan.sh scripts/guard-git-commit-hook.sh scripts/validate-hook-contracts.sh scripts/worktree-hash.py .gitleaks.toml .semgrep/security.yml .github/workflows/security.yml .github/workflows/dependency-review.yml .github/dependabot.yml; do
  [ -f "$file" ] || err "missing security gate asset: $file"
done
rg -q 'guard-git-commit-hook\.sh' .github/hooks/pre-commit-security.json || err "pre-commit hook does not call the deterministic guard"
bash scripts/validate-hook-contracts.sh || err "security hook contract failed"
if rg -n 'rg --files|\| true' scripts/security-scan.sh; then
  err "security source discovery must not fail open"
fi
rg -q 'BLOCKED \(source discovery failed\)' scripts/security-scan.sh || err "security scan does not fail closed on source discovery"
rg -q -- "-path './.git' -prune" scripts/security-scan.sh || err "security source discovery scans Git internals"
rg -q 'no container or IaC scan targets' scripts/security-scan.sh || err "Trivy skip message omits IaC targets"
if rg -n 'shasum' scripts/security-scan.sh scripts/guard-git-commit-hook.sh scripts/validate-hook-contracts.sh; then
  err "security worktree hashing must use the portable Python helper"
fi
rg -q 'corepack prepare "pnpm@\$\{version\}" --activate' .github/workflows/security.yml || err "CI does not pin pnpm to the matrix"
if rg -n 'uses: [^@]+@v[0-9]' .github/workflows; then
  err "GitHub Actions must be pinned to immutable commit SHAs"
fi
note "done"

echo "== 7. Runtime adapters =="
for file in AGENTS.md CLAUDE.md .opencode/opencode.jsonc; do
  [ -f "$file" ] || err "missing runtime adapter: $file"
done
for agent in sylvain architect backend-builder frontend-builder database prompt-caveman cloudflare-tunnel security-guardian quality-gate; do
  [ -f ".opencode/agents/$agent.md" ] || err "missing OpenCode agent: $agent"
done
python3 -m json.tool .opencode/opencode.jsonc > /dev/null 2>&1 || err "invalid OpenCode JSON: .opencode/opencode.jsonc"
grep -q '"./.github/skills"' .opencode/opencode.jsonc || err "OpenCode does not discover shared skills"
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

echo "== 9. Shared-components policy =="
python3 -m json.tool .sylvain/shared-components.json > /dev/null 2>&1 || err "invalid shared-components policy JSON"
for component in MenuBar ThemeSelector PreferencesPanel PreferencesIcon AiChatPanel AiPromptCard AiResponseBlock; do
  rg -q "$component" .sylvain/shared-components.json .github/instructions/frontend.instructions.md || err "shared-components policy missing $component"
done
note "done"

echo "== 10. Vendored UI skills =="
for file in \
  .github/skills/frontend-design/SKILL.md \
  .github/skills/frontend-design/LICENSE.txt \
  .github/skills/frontend-design/UPSTREAM.md \
  .github/skills/ui-ux-pro-max/SKILL.md \
  .github/skills/ui-ux-pro-max/LICENSE \
  .github/skills/ui-ux-pro-max/UPSTREAM.md \
  .github/skills/ui-ux-pro-max/scripts/search.py; do
  [ -f "$file" ] || err "missing vendored UI skill asset: $file"
done
if rg -n '\$\{CLAUDE_PLUGIN_ROOT\}' .github/skills/ui-ux-pro-max/SKILL.md; then
  err "ui-ux-pro-max contains a Claude-specific script path"
fi
note "done"

echo "== 11. Context budget and hook scope =="
for file in .github/hooks/session-start-load-todo.json .github/hooks/pre-commit-security.json; do
  [ -f "$file" ] || err "missing focused hook: $file"
done
for file in .github/hooks/post-tool-use-doc-check.json .github/hooks/post-tool-use-size-check.json; do
  [ ! -e "$file" ] || err "redundant post-tool hook remains: $file"
done
if rg -n 'No active (or blocked )?sylvain todo|No active or blocked sylvain todo' scripts/load-active-todo-hook.sh; then
  err "session hook injects empty todo status into context"
fi
if rg -n '"(osx|linux|windows)"' .github/hooks/session-start-load-todo.json; then
  err "session hook contains unsupported platform-specific command overrides"
fi
for file in .github/copilot-instructions.md .github/instructions/global.instructions.md .github/instructions/security.instructions.md; do
  words=$(wc -w < "$file" | tr -d ' ')
  [ "$words" -le 260 ] || err "automatic context exceeds 260 words: $file ($words)"
done
for file in .github/agents/*.agent.md; do
  words=$(wc -w < "$file" | tr -d ' ')
  [ "$words" -le 360 ] || err "agent exceeds 360 words: $file ($words)"
done
for file in .github/skills/*/SKILL.md; do
  words=$(wc -w < "$file" | tr -d ' ')
  [ "$words" -le 650 ] || err "skill exceeds 650 words: $file ($words)"
done
note "done"

echo "== 12. Repository hygiene =="
if find . -path './.git' -prune -o -name .DS_Store -print -quit | grep -q .; then
  err "Finder metadata must not be kept in the repository"
fi
if find .github/skills -mindepth 1 -maxdepth 1 -type d -empty -print -quit | grep -q .; then
  err "empty skill directory remains"
fi
[ -f .github/skills/validate-java-idioms/SKILL.md ] || err "missing version-neutral Java idiom validator"
if find .github/skills -mindepth 1 -maxdepth 1 -type d -name 'validate-java[0-9]*-idioms' -print -quit | grep -q .; then
  err "Java idiom validator must not encode a baseline version in its name"
fi
note "done"

echo
echo "================================"
if [ "$fail" -eq 1 ]; then
  echo "VALIDATE-KIT: FAILED ($warn warnings)"
  exit 1
fi
echo "VALIDATE-KIT: OK ($warn warnings)"
exit 0
