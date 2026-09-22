#!/usr/bin/env bash
# Re-syncs references/ with the official Tailwind CSS docs source
# (tailwindlabs/tailwindcss.com on GitHub - the site serves no .md/llms.txt).
# Two source trees:
#   src/docs/                                -> references/          (.mdx pages + img)
#   src/app/(docs)/docs/installation/        -> references/installation/  (.tsx guide pages)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 --filter=blob:none --sparse \
  https://github.com/tailwindlabs/tailwindcss.com "$tmp/docs" -q
(cd "$tmp/docs" && git sparse-checkout set "src/docs" "src/app/(docs)/docs/installation")
sha=$(git -C "$tmp/docs" rev-parse HEAD)

rm -rf "$REFS_DIR"
mkdir -p "$REFS_DIR/installation"

rsync -a "$tmp/docs/src/docs/" "$REFS_DIR/"

# Install guides live as page.tsx inside route-group dirs: flatten <name>/page.tsx -> <name>.tsx
for page in "$tmp/docs/src/app/(docs)/docs/installation/(tabs)"/*/page.tsx; do
  name=$(basename "$(dirname "$page")")
  cp "$page" "$REFS_DIR/installation/$name.tsx"
done
rsync -a "$tmp/docs/src/app/(docs)/docs/installation/framework-guides/" \
  "$REFS_DIR/installation/framework-guides/"

echo "$sha" > "$REFS_DIR/VERSION"

pages=$(find "$REFS_DIR" -name '*.mdx' | wc -l | tr -d ' ')
guides=$(find "$REFS_DIR/installation" -type f | wc -l | tr -d ' ')
echo "tailwindcss.com@${sha:0:12} mirrored: $pages mdx pages, $guides install-guide files"
