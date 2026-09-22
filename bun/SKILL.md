---
name: bun
description: Use when working with the Bun JavaScript/TypeScript toolkit — running or bundling .ts/.tsx files, managing dependencies with bun install/add/update/bunx, writing tests with bun test, building HTTP/WebSocket servers with Bun.serve, compiling single-file executables, configuring bunfig.toml or bun.lock, or migrating a Node.js/npm project to Bun.
metadata:
    source: https://bun.com/llms.txt
    mirrored: "2026-09-22"
    version: "2.0"
---

# Bun Skill Reference

## Overview

Bun is an all-in-one JavaScript/TypeScript toolkit (runtime, package manager, bundler, test runner) powered by JavaScriptCore. Key files: `bunfig.toml`, `package.json`, `bun.lock`. Primary commands: `bun run`, `bun install`, `bun build`, `bun test`, `bunx`.

`references/` contains a complete local mirror of the official docs — 319 pages as markdown. `references/llms.txt` is the index: every page title, path, and one-line description. Grep it or browse `references/` to find the page for any topic. Refresh with `bash scripts/refresh-docs.sh`.

## When to Use

- **Running code**: Execute `.ts`, `.tsx`, `.jsx` directly, no build step
- **Package management**: `bun install/add/remove/update/outdated/audit`, workspaces, catalogs, isolated vs hoisted linking
- **Building**: `bun build` for browsers/servers, single-file executables via `--compile`, CSS/HTML bundling, fullstack dev server
- **Testing**: `bun test` — Jest-compatible runner with mocks, snapshots, coverage, DOM testing
- **Servers/APIs**: `Bun.serve` routes, WebSockets, fetch, TCP/UDP, file I/O, SQLite, `Bun.sql` (Postgres/MySQL/SQLite), S3, Redis, shell API, FFI
- **Migrating**: Node.js compatibility, npm → bun install, Jest → bun test, esbuild → bun build

## Reference Index

Pages mirror `bun.com/docs/<path>` → `references/<path>`:

| Area | Path | Covers |
|------|------|--------|
| Getting started | `references/` root | `index`, `installation`, `quickstart`, `typescript`, `typescript-6` |
| Runtime core | `references/runtime/` | bunfig.toml, file-types, module-resolution, jsx, watch-mode, auto-install, env vars, debugger, plugins, file-system-router |
| HTTP/WebSockets | `references/runtime/http/` | server, routing, websockets, cookies, tls, error-handling, metrics |
| Networking | `references/runtime/networking/` | fetch, tcp, udp, dns |
| Native APIs | `references/runtime/` | file-io, sqlite, sql, s3, redis, shell, child-process, workers, ffi, node-api, cron, glob, semver, hashing, secrets, archive, image, html-rewriter, streams, binary-data, markdown, yaml, toml, json5, xml, jsonl, csrf, color, webview, c-compiler, transpiler |
| Compatibility | `references/runtime/` | nodejs-compat, bun-apis, web-apis, globals |
| Package manager | `references/pm/` | cli/ (install, add, remove, update, dedupe, prune, publish, outdated, why, audit, info, link, patch, pm), workspaces, catalogs, filter, lockfile, lifecycle, isolated-installs, global-cache, global-store, scopes-registries, overrides, npmrc, bunx |
| Bundler | `references/bundler/` | index, fullstack, hot-reloading, html-static, standalone-html, css, loaders, executables, plugins, macros, bytecode, minifier, esbuild |
| Test runner | `references/test/` | index, writing-tests, configuration, runtime-behavior, discovery, parallel, lifecycle, mocks, snapshots, dates-times, dom, code-coverage, reporters |
| Guides | `references/guides/` | Task recipes: deployment (vercel, railway, aws-lambda, ...), ecosystem (nextjs, elysia, hono, prisma, drizzle, react, vite, docker, ...), http, websocket, process, install, test, read-file, write-file, binary, streams |

## Quick Reference

| Task | Command | Notes |
|------|---------|-------|
| Run a file | `bun run index.ts` | `.ts`, `.tsx`, `.jsx` natively |
| Run a script | `bun run dev` | From `package.json` scripts |
| Install deps | `bun install` | Creates `bun.lock` (text format since 1.2) |
| Add / remove | `bun add react` / `bun remove react` | `-d` for devDependencies |
| Update deps | `bun update` / `bun outdated` | Interactive: `bun update -i` |
| Execute package | `bunx cowsay hello` | Like `npx` |
| Bundle | `bun build ./index.ts --outdir ./dist` | Flags: `--minify`, `--target browser\|bun\|node`, `--format esm`, `--splitting`, `--sourcemap`, `--watch` |
| Executable | `bun build ./cli.ts --compile --outfile mycli` | Standalone binary |
| Run tests | `bun test` | Flags: `--watch`, `--coverage`, `--bail`, `--timeout`, `-t "pattern"`, `--parallel`, `--shard` |
| Watch mode | `bun --watch run index.ts` | `--hot` for HTTP servers |
| New project | `bun init` / `bun create <template>` | |

## Common Gotchas

- **Lifecycle scripts disabled by default**: add packages to `trustedDependencies` in `package.json`. See `references/pm/lifecycle.md`.
- **Flags go after `bun`, not after the command**: `bun --watch run dev`, not `bun run dev --watch`.
- **Isolated installs are default for new workspaces**: packages can only access declared deps; use `publicHoistPattern` for exceptions. See `references/pm/isolated-installs.md`.
- **TypeScript 6/7 doesn't auto-discover @types**: add `"types": ["bun"]` to tsconfig or fix "Cannot find name Bun" errors. See `references/typescript-6.md`.
- **Type errors don't block execution**: Bun strips types without checking; run `tsc --noEmit` in CI.
- **Peer deps installed by default**: unlike npm; disable with `peer = false` in bunfig.toml.
- **`#!/usr/bin/env node` scripts run with Node**: use `bun run --bun script` to force Bun.
- **Auto-install can mask missing deps**: `install.auto` installs on the fly; use `--frozen-lockfile` in CI.

## Verification Checklist

- [ ] `bun install --frozen-lockfile` succeeds (lockfile in sync, committed to VCS)
- [ ] `bun test` passes
- [ ] `bun build` produces output without errors
- [ ] `tsc --noEmit` clean if strict typing required
- [ ] `bunfig.toml` linker/test settings match project needs

## Maintenance

Docs mirror regenerated from `https://bun.com/llms.txt`. To update: `bash scripts/refresh-docs.sh` (fetches new/changed pages, prunes stale ones).
