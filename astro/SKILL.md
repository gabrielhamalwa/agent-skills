---
name: astro
description: "Astro documentation and reference. Use when building or reviewing Astro sites: .astro components and frontmatter, islands architecture with client:* hydration directives, content collections, routing, middleware and endpoints, on-demand rendering and adapters, astro.config, images, view transitions, or migrating an existing site to Astro."
metadata:
    source: https://github.com/withastro/docs
    mirrored: "2026-09-22"
    version: "1.0"
---

# Astro Skill Reference

## Overview

Astro is a content-driven web framework: islands architecture, zero-JS-by-default output, `.astro` components with a server-side frontmatter fence, and optional hydration of React/Vue/Svelte/etc. islands via `client:*` directives.

`references/` contains the full English Astro documentation: 422 pages covering guides, recipes, the tutorial, and the complete reference section (config, directives, CLI, API, errors). `references/VERSION` records the upstream commit. Update with `bash scripts/refresh-docs.sh`.

## When to Use

- **Components**: `.astro` files, frontmatter fence, props, slots, layouts
- **Islands/hydration**: framework components + `client:load|idle|visible|media|only`, `server:defer` server islands
- **Content**: content collections (v5 content layer: `src/content.config.ts`, `glob()` loader, `getCollection`, `render`), Markdown/MDX pages
- **Rendering modes**: static output vs on-demand (SSR) with `prerender = false` and adapters (node, vercel, netlify, cloudflare)
- **Routing**: file-based `src/pages/`, dynamic routes + `getStaticPaths()`, endpoints, middleware, redirects
- **Platform**: `astro.config.mjs`, integrations (`astro add`), env vars (`astro:env`, `PUBLIC_` prefix), images (`astro:assets`), view transitions (`<ClientRouter />`), actions, sessions, i18n, CSP

## Reference Index

Pages map `src/content/docs/en/<path>` → `references/<path>` (`.mdx`):

| Area | Path | Covers |
|------|------|--------|
| Start here | `references/` root | `getting-started`, `install-and-setup`, `develop-and-build`, `editor-setup`, `upgrade-astro` |
| Basics | `references/basics/` | astro-components, astro-pages, layouts, project-structure |
| Concepts | `references/concepts/` | islands, why-astro |
| Guides | `references/guides/` | routing, content-collections, on-demand-rendering, endpoints, middleware, images, environment-variables, prefetch, internationalization, actions, authentication, caching, server-islands, view-transitions, fonts, markdown-content, client-side-scripts, data-fetching, integrations, dev-toolbar, styling, typescript, sessions, testing, troubleshooting, syntax-highlighting, framework-components, imports, configuring-astro, build-with-ai, ecommerce + subdirs: `deploy/`, `cms/`, `backend/`, `media/`, `migrate-to-astro/`, `integrations-guide/`, `upgrade-to/` |
| Recipes | `references/recipes/` | Short task recipes (forms, RSS, docker, bun, i18n, streaming, sharing state, captcha, reading-time, tailwind-rendered-markdown, yaml, bundle analysis) |
| Reference | `references/reference/` | configuration-reference, directives-reference, cli-reference, api-reference, astro-syntax, adapter-reference, routing-reference, integrations-reference, content-loader-reference, image-service-reference, programmatic-reference + `errors/`, `experimental-flags/`, `modules/` (`astro:content`, `astro:actions`, `astro:env`, `astro:assets`, `astro:middleware`, `astro:transitions` virtual modules) |
| Tutorial | `references/tutorial/` | Step-by-step build-a-blog course |

## Quick Reference

| Task | Command / code | Notes |
|------|---------------|-------|
| New project | `npm create astro@latest` | `--template`, `--add`, `--install` flags |
| Dev server | `astro dev` | |
| Build | `astro build` → `astro preview` | Static output to `dist/` by default |
| Add integration | `astro add react` | Also vue, svelte, tailwind, mdx, sitemap, adapters |
| Type check | `astro check` | Uses `astro/tsconfigs/*` presets |
| Hydrate island | `<Counter client:load />` | Also `client:idle`, `client:visible`, `client:media`, `client:only="react"` |
| Server island | `<Avatar server:defer />` | Defers to its own request, needs adapter |
| On-demand page | `export const prerender = false` | Requires an installed adapter; `output: 'server'` makes SSR the default instead |
| Collections (v5) | `src/content.config.ts` | `defineCollection({ loader: glob({...}), schema: z.object({...}) })`, then `getCollection()` + `render(entry)` |
| Page params | `Astro.params`, `Astro.url` | `Astro.props`, `Astro.request`, `Astro.cookies`, `Astro.locals`, `Astro.redirect` |
| Endpoint | `src/pages/api.ts` → `export function GET()` | Return a `Response` |
| Middleware | `src/middleware.ts` → `defineMiddleware` | `context.locals` passes data |
| Typed env vars | `env.schema` in config | `import { API_URL } from 'astro:env/server'` |
| Image | `import { Image } from 'astro:assets'` | `<Image src={} alt="" />`, `<Picture />`, `getImage()` |
| View transitions | `<ClientRouter />` | From `astro:transitions` (renamed from ViewTransitions in v5) |

## Common Gotchas

- **Frontmatter never reaches the client**: code between `---` fences runs at build/server time. Browser JS goes in `<script>` (bundled+hoisted by default; `is:inline` opts out). See `references/basics/astro-components.mdx`.
- **Framework components ship zero JS without a `client:*` directive** — they render to static HTML. `client:only` skips SSR entirely. Directives need the integration installed (`astro add react`).
- **Astro 5 moved collections to the content layer API**: config lives at `src/content.config.ts` (not `src/content/config.ts`), collections need a `loader` (usually `glob`), and `entry.render()` became `render(entry)` from `astro:content`. `Astro.glob()` is deprecated — use `import.meta.glob` or collections. See `references/guides/content-collections.mdx` and `upgrade-astro.mdx`.
- **Dynamic routes need `getStaticPaths()` in static mode**; without it you need on-demand rendering (`prerender = false`) + an adapter.
- **Only `PUBLIC_`-prefixed env vars reach the client** via `import.meta.env`; secrets stay server-side or use `astro:env/server`.
- **No client-side navigation by default**: pages are full reloads unless `<ClientRouter />` is added; prefetch via `data-astro-prefetch` or `prefetch` config.

## Maintenance

Update `references/` with `bash scripts/refresh-docs.sh` (pulls the latest docs source, prunes stale pages). Runs weekly via GitHub Actions.
