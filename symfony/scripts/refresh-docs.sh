#!/usr/bin/env bash
# Re-syncs references/ with symfony/symfony-docs (default branch).
# Docs are reStructuredText (.rst), mirrored verbatim - upstream license is
# CC BY-SA 3.0 (see LICENSE.md inside references/), so do not modify them.
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 --filter=blob:none \
  https://github.com/symfony/symfony-docs "$tmp/docs" -q
sha=$(git -C "$tmp/docs" rev-parse HEAD)
branch=$(git -C "$tmp/docs" rev-parse --abbrev-ref HEAD)

rm -rf "$REFS_DIR"
mkdir -p "$REFS_DIR"
rsync -a --exclude='.git' --exclude='.github' --exclude='_build' "$tmp/docs/" "$REFS_DIR/"
printf '%s %s\n' "$branch" "$sha" > "$REFS_DIR/VERSION"

pages=$(find "$REFS_DIR" -name '*.rst' | wc -l | tr -d ' ')
echo "symfony-docs@$branch ${sha:0:12} mirrored: $pages pages"
