#!/usr/bin/env bash
# Re-syncs references/ with the official Bun docs.
# Source of truth: https://bun.com/llms.txt (every docs page is served as .md)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"
LLMS_TXT="$REFS_DIR/llms.txt"

mkdir -p "$REFS_DIR"
curl -sf "https://bun.com/llms.txt" -o "$LLMS_TXT"

urls=$(grep -o 'https://bun\.com/docs/[^)]*\.md' "$LLMS_TXT" | sort -u)
total=$(echo "$urls" | wc -l | tr -d ' ')
echo "Fetching $total pages into $REFS_DIR"

ok=0; failed=0
for url in $urls; do
  rel="${url#https://bun.com/docs/}"
  # Guard: upstream controls these paths to only allow safe chars, no traversal
  if [[ ! "$rel" =~ ^[A-Za-z0-9._/-]+$ || "$rel" == *..* || "$rel" == /* ]]; then
    echo "SKIP unsafe path: $rel"
    failed=$((failed + 1))
    continue
  fi
  dest="$REFS_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  if ! curl -sfL --retry 2 "$url" -o "$dest" || head -1 "$dest" | grep -qiE '<!DOCTYPE html|Redirecting'; then
    # Section indexes are served at docs/<section>.md, not docs/<section>/index.md
    if [[ "$rel" == */index.md || "$rel" == "index.md" ]]; then
      alt="https://bun.com/${rel%/index.md}.md"
      [[ "$rel" == "index.md" ]] && alt="https://bun.com/docs.md"
      curl -sfL --retry 2 "$alt" -o "$dest" || true
    fi
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

# API reference: bun.com/reference is generated from the bun-types package.
# Mirror the .d.ts sources so agents get real signatures, not the HTML site.
API_DIR="$REFS_DIR/api"
version=$(curl -sf "https://registry.npmjs.org/bun-types/latest" | python3 -c 'import json,sys; print(json.load(sys.stdin)["version"])')
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -sfL "https://registry.npmjs.org/bun-types/-/bun-types-$version.tgz" -o "$tmp/bun-types.tgz"
tar -xzf "$tmp/bun-types.tgz" -C "$tmp"
rm -rf "$API_DIR" && mkdir -p "$API_DIR"
rsync -a --include='*/' --include='*.d.ts' --include='package.json' --exclude='*' "$tmp/package/" "$API_DIR/"
echo "$version" > "$API_DIR/VERSION"
echo "bun-types $version mirrored to $API_DIR"

echo "Done: $ok fetched, $failed failed"
