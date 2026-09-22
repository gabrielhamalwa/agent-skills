---
name: tailwind
description: "Tailwind CSS documentation and reference (v4). Use when installing, configuring, or writing Tailwind: CSS-first setup with @import and @theme, Vite/PostCSS/CLI/framework integrations, utility classes, responsive design, dark mode and other variants, custom utilities and variants (@utility, @custom-variant), @reference and @source directives, theme variables, container queries, or upgrading from v3."
metadata:
    source: https://github.com/tailwindlabs/tailwindcss.com
    mirrored: "2026-09-22"
    version: "1.0"
---

# Tailwind CSS Skill Reference

## Overview

Tailwind is a utility-first CSS framework. v4 is CSS-first: `@import "tailwindcss"` in a stylesheet replaces `tailwind.config.js`, theme values live in `@theme` CSS variables, and content detection is automatic. Integration options: `@tailwindcss/vite` plugin, `@tailwindcss/postcss`, `@tailwindcss/cli`, or per-framework guides.

`references/` contains the Tailwind documentation: 197 `.mdx` pages (every utility reference plus core concept guides) and `references/installation/` with the install guides (`.tsx` source pages — prose is readable). `references/VERSION` records the upstream commit. Update with `bash scripts/refresh-docs.sh`.

## When to Use

- **Install**: Vite plugin, PostCSS, Tailwind CLI, Play CDN, framework guides (Next.js, Laravel, Astro, SvelteKit, Nuxt, React Router, ...)
- **Core concepts**: utility classes, hover/focus/other states, responsive design, dark mode, adding custom styles, theme variables, preflight, content detection
- **Utilities**: every utility page — layout, flexbox, grid, spacing, sizing, typography, backgrounds, borders, effects, filters, transforms, transitions, interactivity, SVG, accessibility
- **Directives**: `@theme`, `@utility`, `@custom-variant`, `@source`, `@reference`, `@plugin`, `@config`, `@apply`, `@variant`
- **Upgrading**: v3 → v4 changes and the automated upgrade tool

## Reference Index

Pages are flat `.mdx` files matching `tailwindcss.com/docs/<slug>` → `references/<slug>.mdx`:

| Area | Path | Covers |
|------|------|--------|
| Install guides | `references/installation/` | using-vite.tsx, using-postcss.tsx, tailwind-cli.tsx, play-cdn.tsx, framework-guides/ (19 per-framework .tsx pages + index.ts) |
| Core concepts | `references/` root | styling-with-utility-classes, hover-focus-and-other-states, responsive-design, dark-mode, adding-custom-styles, theme, colors, preflight, functions-and-directives, detecting-classes-in-source-files |
| Setup/meta | `references/` root | editor-setup, compatibility, upgrade-guide |
| Utilities | `references/` root | ~180 pages, one per utility: `accent-color` … `z-index` — layout (display, position, flex, grid, order), spacing (padding, margin, gap), sizing (width, height, size, min/max-*), typography (font-*, text-*, letter-spacing, line-height), backgrounds (bg-*, background-image), borders (border-*, outline-*, box-shadow), effects (opacity, mix-blend), filters (blur, brightness, drop-shadow, backdrop-*), transforms (rotate, scale, skew, translate, perspective, transform-style), transitions/animation, interactivity (cursor, pointer-events, scroll-*, touch-action, user-select), SVG (fill, stroke), accessibility (forced-color-adjust). Folded topics: `space-*` lives in margin.mdx, `ring-*` in box-shadow.mdx, `divide-*` in border-width.mdx/border-color.mdx |
| Images | `references/img/` | Guide screenshots/diagrams |

## Quick Reference

| Task | Code | Notes |
|------|------|-------|
| Vite setup | `npm i tailwindcss @tailwindcss/vite` → `plugins: [tailwindcss()]` → `@import "tailwindcss";` | Recommended path for Vite projects |
| PostCSS setup | `npm i tailwindcss @tailwindcss/postcss postcss` → `plugins: { "@tailwindcss/postcss": {} }` | For non-Vite bundlers |
| CLI | `npx @tailwindcss/cli -i input.css -o output.css --watch` | Standalone, no bundler needed |
| Theme tokens | `@theme { --color-mint-500: oklch(...); --font-display: "..."; --breakpoint-3xl: 120rem; }` | Defines utilities: `bg-mint-500`, `font-display`, `3xl:` |
| Dark mode (class) | `@custom-variant dark (&:where(.dark, .dark *));` | Default `dark:` uses `prefers-color-scheme` |
| Custom utility | `@utility btn { border-radius: .5rem; ... }` | Generates real utilities incl. variants |
| Custom variant | `@custom-variant theme-midnight (&:where([data-theme="midnight"] *));` | Then `theme-midnight:bg-black` |
| Use theme in other CSS | `@reference "../../app.css";` | Needed in Vue SFC `<style>`, CSS modules, `@apply` outside the main file; `@reference "tailwindcss"` when there's no customization |
| Scan extra dirs | `@source "../templates";` | Content detection is automatic; `@source inline("underline")` safelists |
| Legacy JS config | `@config "../../tailwind.config.js";` | v4 fallback, not needed normally |
| Legacy plugin | `@plugin "@tailwindcss/typography";` | First-party plugins still JS |
| Container query | `@container` on parent + `@sm:` / named `@container/main` + `@lg/main:` | Built into v4; variant takes the name after a slash |
| Arbitrary value | `w-[320px]`, `bg-(--brand)` | `(--var)` shorthand for CSS vars |
| Prefix | `@import "tailwindcss" prefix(tw);` | Then `tw:flex`, theme vars `--tw-*` |
| Class sorting | `prettier-plugin-tailwindcss` | Official Prettier plugin |
| Upgrade v3→v4 | `npx @tailwindcss/upgrade` | Migrates config + templates; see upgrade-guide.mdx |

## Common Gotchas

- **v4 has no `@tailwind base/components/utilities` directives** — a single `@import "tailwindcss"` does everything; `tailwind.config.js` is optional via `@config`.
- **Content detection is automatic** — no `content` array; it scans sources (respecting `.gitignore`, skipping binaries and node_modules). `@source` is the escape hatch — the docs' canonical example is scanning a Tailwind-built library: `@source "../node_modules/@acmecorp/ui-lib"`.
- **`@apply` and `@theme` values don't resolve in isolated CSS files** (Vue SFC `<style>`, CSS modules, other entry points) — add `@reference` pointing at the file that imports Tailwind.
- **Browser floor moved up**: v4 needs Safari 16.4+, Chrome 111+, Firefox 128+ (cascade layers, `@property`, `color-mix`). Older browsers → stay on v3.
- **Spacing scale is derived from `--spacing`** — change that one theme var to rescale every `p-*`, `m-*`, `w-*`, `gap-*` utility.
- **Dynamic values are built in** — `w-17`, `grid-cols-15`, any integer works without arbitrary-value syntax.
- **`dark:` variant defaults to `prefers-color-scheme`** — class/toggle strategies need `@custom-variant dark` (see dark-mode.mdx).
- **Ring/shadow/blur defaults shifted in v4** — `shadow-sm` → `shadow-xs`, `blur-sm` → `blur-xs`, `ring` default 3px → 1px (`ring-3` for old behavior). The upgrade tool handles renames.
- **Play CDN is dev-only** — `<script src="https://cdn.tailwindcss.com">` compiles in-browser; never ship to production.
- **`.tsx` install guides are source pages** — prose lives inside JSX (`<Steps>` components); read the text, ignore the component imports.

## Maintenance

Update `references/` with `bash scripts/refresh-docs.sh` (pulls the latest docs source, prunes stale pages). Runs weekly via GitHub Actions.
