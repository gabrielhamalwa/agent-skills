---
name: vite
description: Use when configuring, debugging, or extending Vite — vite.config.ts options, plugins, dev server and HMR, environment variables (import.meta.env, VITE_ prefix), production builds and library mode, SSR, dependency pre-bundling, Environment API, or migrating between Vite versions.
metadata:
    source: https://vite.dev/llms.txt
    mirrored: "2026-09-22"
    version: "1.0"
---

# Vite Skill Reference

## Overview

Vite is a frontend build tool: a dev server serving native ESM with instant HMR, plus a Rolldown-powered production bundler. Key files: `vite.config.ts`, `.env*` files, `index.html` as entry. Commands: `vite` (dev), `vite build`, `vite preview`.

`references/` is a mirror of vite.dev — 42 markdown pages covering the full guide, config reference, and plugin/Environment APIs. `references/llms.txt` is the upstream index. Refresh with `bash scripts/refresh-docs.sh`.

## When to Use

- **Config**: `vite.config.ts`, shared/server/build/preview/ssr/worker options
- **Dev server**: proxy, HTTPS, HMR issues, `optimizeDeps`, `--force` re-bundling
- **Env**: `.env` files, modes, `import.meta.env`, `VITE_` prefix
- **Build**: output options, library mode, code splitting, assets, `base`, deploys
- **Plugins**: write/consume plugins, hooks (`transform`, `hotUpdate`, `configResolved`), plugin API
- **SSR/backends**: SSR builds, middleware mode, backend integration
- **Environment API**: multi-environment configs and plugins (v6+)

## Reference Index

Pages mirror `vite.dev/<path>` → `references/<path>`:

| Area | Path | Covers |
|------|------|--------|
| Intro | `references/` root + `guide/` | `guide.md` (getting started), `guide/why.md`, `guide/philosophy.md` |
| Guide | `references/guide/` | features, cli, using-plugins, dep-pre-bundling, assets, build, static-deploy, env-and-mode, ssr, backend-integration, troubleshooting, performance, migration |
| Config | `references/config/` + `config.md` | shared-options, server-options, build-options, preview-options, dep-optimization-options, ssr-options, worker-options |
| Plugin/HMR APIs | `references/guide/` | api-plugin, api-hmr, api-javascript |
| Environment API | `references/guide/` | api-environment, api-environment-instances, api-environment-plugins, api-environment-frameworks, api-environment-runtimes |
| Upcoming changes | `references/changes/` | Deprecation/migration notices (this.environment in hooks, hotUpdate hook, per-environment APIs, ModuleRunner SSR, shared build plugins) |
| Other | `references/` root | plugins.md (ecosystem list), releases.md, changes.md, acknowledgements.md, live.md |

## Quick Reference

| Task | Command / code | Notes |
|------|---------------|-------|
| Scaffold | `npm create vite@latest` | Framework templates + variants |
| Dev server | `vite` / `vite --host` | `--port`, `--mode`, `--force` (re-prebundle deps) |
| Build | `vite build` | `vite preview` to serve `dist/` locally |
| Config | `vite.config.ts` + `defineConfig` | ESM only; plugins array, `resolve.alias`, `server.proxy`, `build.*` |
| Env var (client) | `import.meta.env.VITE_API_URL` | Only `VITE_*` prefixed vars exposed |
| Env files | `.env`, `.env.local`, `.env.[mode]` | Loaded per `--mode` |
| Asset import | `import logo from './logo.svg'` | `?url`, `?raw`, `?worker`, `?inline` suffixes; `public/` = verbatim copy |
| Plugin | object with hooks | `name`, `transform`, `handleHotUpdate`, `configResolved`, `configureServer` — Rolldown-compatible interface |
| Library build | `build.lib` + `build.rolldownOptions.external` | Externalize peer deps (`rollupOptions` is a deprecated alias) |
| SSR | `vite build --ssr` + middleware mode | `createServer({ server: { middlewareMode: true } })` |

## Common Gotchas

- **`import.meta.env` only exposes `VITE_*` to the browser** — never put secrets in `VITE_` vars; they're shipped to the client.
- **Dev and build are different pipelines** — dev serves native ESM with pre-bundled deps (`optimizeDeps`); stale pre-bundle cache causes weird errors → `vite --force` or delete `node_modules/.vite`.
- **`define` does literal text replacement** — string values need `JSON.stringify`.
- **`public/` assets are copied verbatim** — no hashing/processing; reference by absolute path. Use imports for processed assets.
- **`base` must be set for non-root deploys** (e.g. GitHub Pages subpath) or asset URLs break.
- **CJS config/API is gone** — `vite.config.ts`/`.mts` with ESM; CommonJS API removed in current versions.
- **SSR needs separate handling** — `ssr.external`/`ssr.noExternal` control bundling; frontmatter runs in Node, not browser.
- **Plugin order matters** — `enforce: 'pre' | 'post'` controls sequencing vs core plugins.
- **Docs track Rolldown-powered Vite (v8)** — `build.rolldownOptions` replaces `build.rollupOptions` (deprecated alias); `hotUpdate` is a newer per-environment hook but `handleHotUpdate` remains the documented canonical hook — don't migrate to `hotUpdate` yet.

## Maintenance

Docs mirror regenerated from `https://vite.dev/llms.txt`. To update: `bash scripts/refresh-docs.sh`.
