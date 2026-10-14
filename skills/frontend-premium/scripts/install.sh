#!/usr/bin/env bash
# Installs every skill used by the frontend-premium workflow into Claude Code's global scope.
# Usage: bash install.sh [--force]   (--force overwrites already-installed Stitch/playwright-cli skills)
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

say() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }
warn() { printf '\033[33m[warn]\033[0m %s\n' "$1"; }

mkdir -p "$SKILLS_DIR"

say "Checking requirements"
for bin in node npm npx git; do
  command -v "$bin" >/dev/null || { echo "Missing '$bin' in PATH."; exit 1; }
done
NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
if [ "$NODE_MAJOR" -lt 22 ]; then
  warn "Node $(node -v) detected. The design-taste-frontend scripts need Node 22+ (e.g. 'nvm install 22')."
fi

# Copies a skill folder into ~/.claude/skills, honoring --force.
copy_skill() {
  local src="$1" name
  name="$(basename "$src")"
  if [ -e "$SKILLS_DIR/$name" ] && [ "$FORCE" -eq 0 ]; then
    echo "  = $name (already installed, use --force to overwrite)"
  else
    rm -rf "${SKILLS_DIR:?}/$name"
    cp -R "$src" "$SKILLS_DIR/$name"
    echo "  + $name"
  fi
}

say "0/5 frontend-premium (this workflow)"
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ "$SELF_DIR" != "$SKILLS_DIR/frontend-premium" ]; then
  copy_skill "$SELF_DIR"
else
  echo "  = frontend-premium (running from the installed copy)"
fi

say "1/5 taste-skill (Leonxlnx/taste-skill)"
npx -y skills add Leonxlnx/taste-skill -g -a claude-code -y

say "2/5 web-design-guidelines (vercel-labs/agent-skills)"
npx -y skills add vercel-labs/agent-skills --skill web-design-guidelines -g -a claude-code -y

say "3/5 Stitch skills (google-labs-code/stitch-skills)"
git clone -q --depth 1 https://github.com/google-labs-code/stitch-skills.git "$TMP/stitch"
for dir in "$TMP"/stitch/plugins/*/skills/*/; do
  [ -f "$dir/SKILL.md" ] && copy_skill "${dir%/}"
done

say "4/5 playwright-cli (microsoft/playwright-cli)"
git clone -q --depth 1 https://github.com/microsoft/playwright-cli.git "$TMP/pwcli"
copy_skill "$TMP/pwcli/skills/playwright-cli"
npm install -g @playwright/cli@latest
npx -y playwright install chromium

say "5/5 SwiftUI skills (avdlee + twostraws/swiftui-agent-skill)"
npx -y skills add https://github.com/avdlee/swiftui-agent-skill --skill swiftui-expert-skill -g -a claude-code -y
npx -y skills add https://github.com/twostraws/swiftui-agent-skill --skill swiftui-pro -g -a claude-code -y
command -v xcodebuild >/dev/null || warn "Xcode not found: the Native iOS track needs it (App Store) to build and run the Simulator."

say "Done"
echo "playwright-cli $(playwright-cli --version 2>/dev/null || echo '(not found in PATH)')"
echo "Skills are in $SKILLS_DIR. Start a new Claude Code session to load them."
