#!/usr/bin/env bash
# Re-syncs references/ with the official Astro docs source (withastro/docs on GitHub).
# docs.astro.build serves no .md/llms.txt, so we mirror the .mdx source tree directly.
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFS_DIR="$SKILL_DIR/references"
DOCS_SUBDIR="src/content/docs/en"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 --filter=blob:none --sparse \
  https://github.com/withastro/docs "$tmp/docs" -q
(cd "$tmp/docs" && git sparse-checkout set "$DOCS_SUBDIR")
sha=$(git -C "$tmp/docs" rev-parse HEAD)

rm -rf "$REFS_DIR"
mkdir -p "$REFS_DIR"
rsync -a "$tmp/docs/$DOCS_SUBDIR/" "$REFS_DIR/"
echo "$sha" > "$REFS_DIR/VERSION"

pages=$(find "$REFS_DIR" -name '*.mdx' | wc -l | tr -d ' ')
echo "withastro/docs@${sha:0:12} mirrored: $pages pages"
