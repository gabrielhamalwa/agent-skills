#!/usr/bin/env bash
# Mirrors W3C ARIA Authoring Practices Guide (APG) from w3c/aria-practices:
#   content/patterns/*  -> references/apg/<name>/pattern.md + examples/
#   content/practices/* -> references/apg/practices/<name>.md
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$SKILL_DIR/references/apg"
SRC="$(mktemp -d)"
trap 'rm -rf "$SRC"' EXIT

command -v pandoc >/dev/null || { echo "pandoc required (brew install pandoc)" >&2; exit 1; }

git clone --depth 1 --filter=blob:none --sparse https://github.com/w3c/aria-practices.git "$SRC/apg" -q
git -C "$SRC/apg" sparse-checkout set content/patterns content/practices

rm -rf "$DEST"
mkdir -p "$DEST/practices"
cp "$SRC/apg/LICENSE.md" "$DEST/LICENSE.md"

# Shared cleanup: kbd spans -> code ticks, strip same-page anchor wrappers,
# div wrappers, and image refs into assets we don't mirror.
clean() {
  sed -E \
    -e 's/<span class="kbd">([^<]*)<\/span>/`\1`/g' \
    -e 's/<a href="#[^"]*" class="[^"]*">([^<]*)<\/a>/\1/g' \
    -e '/^<div[^>]*>$/d' \
    -e '/^<\/div>$/d' \
    -e '/^!\[\]\(\.\.\/\.\.\/images\//d'
}

count=0
for pattern_html in "$SRC"/apg/content/patterns/*/*-pattern.html; do
  name="$(basename "$(dirname "$pattern_html")")"
  mkdir -p "$DEST/$name"
  pandoc -f html -t gfm --wrap=none "$pattern_html" \
    | clean \
    | sed -E \
        -e 's|\.\./([a-z-]+)/[a-z-]+-pattern\.html(#[A-Za-z0-9_-]+)?|../\1/pattern.md|g' \
        -e 's|\.\./\.\./practices/+([a-z-]+)/+[a-z-]+-practice\.html(#[A-Za-z0-9_-]+)?|../practices/\1.md|g' \
    > "$DEST/$name/pattern.md"
  if [ -d "$(dirname "$pattern_html")/examples" ]; then
    cp -R "$(dirname "$pattern_html")/examples" "$DEST/$name/examples"
  fi
  count=$((count + 1))
done

for practice_html in "$SRC"/apg/content/practices/*/*-practice.html; do
  name="$(basename "$(dirname "$practice_html")")"
  pandoc -f html -t gfm --wrap=none "$practice_html" \
    | clean \
    | sed -E \
        -e 's|\.\./\.\./patterns/([a-z-]+)/[a-z-]+-pattern\.html(#[A-Za-z0-9_-]+)?|../\1/pattern.md|g' \
        -e 's|\.\./\.\./patterns/([a-z-]+)/examples/|../\1/examples/|g' \
        -e 's|\.\./([a-z-]+)/[a-z-]+-practice\.html(#[A-Za-z0-9_-]+)?|\1.md|g' \
    > "$DEST/practices/$name.md"
  count=$((count + 1))
done

# Example index: generated site page (no repo source) — reverse index of every
# example by ARIA role and by properties/states.
curl -fsSL "https://www.w3.org/WAI/ARIA/apg/example-index/" \
  | pandoc -f html -t gfm --wrap=none \
  | clean \
  | sed -E \
      -e 's|\.\./patterns/([a-z-]+)/examples/([a-zA-Z0-9_-]+)/?|../\1/examples/\2.html|g' \
      -e 's|\.\./patterns/([a-z-]+)/[a-z-]+-pattern\.html(#[A-Za-z0-9_-]+)?|../\1/pattern.md|g' \
      -e 's|^# <span[^>]*> *</span> *Index|# APG Example Index|' \
      -e '/^Index$/d' \
  > "$DEST/example-index.md"
count=$((count + 1))

echo "Mirrored $count APG pages to $DEST"
