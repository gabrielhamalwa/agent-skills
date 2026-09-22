#!/usr/bin/env bash
# Re-syncs references/ with the official Vite docs.
# Source of truth: https://vite.dev/llms.txt (pages serve as .md at vite.dev/<path>.md)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"
LLMS_TXT="$REFS_DIR/llms.txt"

mkdir -p "$REFS_DIR"
curl -sfL "https://vite.dev/llms.txt" -o "$LLMS_TXT"

# Links are relative (/guide/x.md) or absolute (https://vite.dev/x.md)
rels=$(grep -oE '(https://vite\.dev)?/[A-Za-z0-9._/-]+\.md' "$LLMS_TXT" \
  | sed -E 's|^https://vite\.dev||; s|^/||' | sort -u)
total=$(echo "$rels" | wc -l | tr -d ' ')
echo "Fetching $total pages into $REFS_DIR"

ok=0; failed=0
for rel in $rels; do
  # Guard: upstream controls these paths - only allow safe chars, no traversal
  if [[ ! "$rel" =~ ^[A-Za-z0-9._/-]+$ || "$rel" == *..* ]]; then
    echo "SKIP unsafe path: $rel"
    failed=$((failed + 1))
    continue
  fi
  dest="$REFS_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  curl -sfL --retry 2 "https://vite.dev/$rel" -o "$dest" || true
  if [[ -f "$dest" ]] && ! head -1 "$dest" | grep -qiE '<!DOCTYPE html|Redirecting'; then
    ok=$((ok + 1))
  else
    echo "FAILED: https://vite.dev/$rel"
    rm -f "$dest"
    failed=$((failed + 1))
  fi
done

# Remove stale files no longer listed upstream
find "$REFS_DIR" -name '*.md' | while read -r f; do
  rel="${f#$REFS_DIR/}"
  grep -q "/$rel)" "$LLMS_TXT" || { echo "STALE: $rel"; rm -f "$f"; }
done
find "$REFS_DIR" -type d -empty -delete

echo "Done: $ok fetched, $failed failed"
