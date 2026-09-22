#!/usr/bin/env bash
# Mirrors Anthropic's code migration kit (prompts, templates, scripts, examples)
# from anthropics/code-migration-kit-with-claude-code.
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$SKILL_DIR/references/kit"
SRC="$(mktemp -d)"
trap 'rm -rf "$SRC"' EXIT

git clone --depth 1 https://github.com/anthropics/code-migration-kit-with-claude-code.git "$SRC/kit" -q

rm -rf "$DEST"
mkdir -p "$DEST"
# Glob copy: excludes .git and other dotfiles automatically.
cp -R "$SRC"/kit/* "$DEST/"

echo "Mirrored $(find "$DEST" -type f | wc -l | tr -d ' ') files to $DEST"
