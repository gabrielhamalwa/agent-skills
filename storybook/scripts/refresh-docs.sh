#!/usr/bin/env bash
# Re-syncs references/ with the official Storybook docs.
# Source of truth: https://storybook.js.org/llms.txt (page list under "Docs Pages";
# every page serves markdown at <path>.md, default variant: current version, React, TS)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"
LLMS_TXT="$REFS_DIR/llms.txt"

mkdir -p "$REFS_DIR"
curl -sfL "https://storybook.js.org/llms.txt" -o "$LLMS_TXT"

paths=$(grep -oE '^[[:space:]]*- /docs/[A-Za-z0-9._/-]+' "$LLMS_TXT" | awk '{print $2}' | sort -u)
total=$(echo "$paths" | wc -l | tr -d ' ')
echo "Fetching $total pages into $REFS_DIR"

ok=0; failed=0
for path in $paths; do
  rel="${path#/docs/}"
  # Guard: upstream controls these paths - only allow safe chars, no traversal
  if [[ ! "$rel" =~ ^[A-Za-z0-9._/-]+$ || "$rel" == *..* || "$rel" == /* ]]; then
    echo "SKIP unsafe path: $rel"
    failed=$((failed + 1))
    continue
  fi
  dest="$REFS_DIR/$rel.md"
  mkdir -p "$(dirname "$dest")"
  curl -sfL --retry 2 "https://storybook.js.org${path}.md" -o "$dest" || true
  # Strip the version/renderer boilerplate header ("> **Version X** ..." through first blank line)
  if [[ -f "$dest" ]] && head -1 "$dest" | grep -q '^> \*\*Version'; then
    awk 'NR==1{skip=1} skip && /^$/{skip=0; next} !skip' "$dest" > "$dest.tmp" && mv "$dest.tmp" "$dest"
  fi
  if [[ -f "$dest" ]] && ! head -1 "$dest" | grep -qiE '<!DOCTYPE html|Redirecting'; then
    ok=$((ok + 1))
  else
    echo "FAILED: $path"
    rm -f "$dest"
    failed=$((failed + 1))
  fi
done

# Remove stale files no longer listed upstream
find "$REFS_DIR" -name '*.md' | while read -r f; do
  rel="${f#$REFS_DIR/}"; rel="${rel%.md}"
  grep -q " /docs/$rel\$" "$LLMS_TXT" || { echo "STALE: $rel"; rm -f "$f"; }
done
find "$REFS_DIR" -type d -empty -delete

echo "Done: $ok fetched, $failed failed"
