#!/usr/bin/env bash
# Re-syncs references/ with the official Inertia.js docs (Mintlify).
# Source of truth: https://inertiajs.com/docs/llms.txt (every page serves .md)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"
LLMS_TXT="$REFS_DIR/llms.txt"

mkdir -p "$REFS_DIR"
curl -sfL "https://inertiajs.com/docs/llms.txt" -o "$LLMS_TXT"

urls=$(grep -o 'https://inertiajs\.com/docs/[^)]*\.md' "$LLMS_TXT" | sort -u)
total=$(echo "$urls" | wc -l | tr -d ' ')
echo "Fetching $total pages into $REFS_DIR"

ok=0; failed=0
for url in $urls; do
  rel="${url#https://inertiajs.com/docs/}"
  # Guard: upstream controls these paths - only allow safe chars, no traversal
  if [[ ! "$rel" =~ ^[A-Za-z0-9._/-]+$ || "$rel" == *..* || "$rel" == /* ]]; then
    echo "SKIP unsafe path: $rel"
    failed=$((failed + 1))
    continue
  fi
  dest="$REFS_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  curl -sfL --retry 2 "$url" -o "$dest" || true
  # Strip the Mintlify "Documentation Index" boilerplate blockquote (3 lines + blank)
  if [[ -f "$dest" ]] && head -1 "$dest" | grep -q 'Documentation Index'; then
    tail -n +5 "$dest" > "$dest.tmp" && mv "$dest.tmp" "$dest"
  fi
  if [[ -f "$dest" ]] && ! head -1 "$dest" | grep -qiE '<!DOCTYPE html|Redirecting'; then
    ok=$((ok + 1))
  else
    echo "FAILED: $url"
    rm -f "$dest"
    failed=$((failed + 1))
  fi
done

# Remove stale files no longer listed upstream
find "$REFS_DIR" -name '*.md' | while read -r f; do
  rel="${f#$REFS_DIR/}"
  grep -q "docs/$rel)" "$LLMS_TXT" || { echo "STALE: $rel"; rm -f "$f"; }
done
find "$REFS_DIR" -type d -empty -delete

echo "Done: $ok fetched, $failed failed"
