---
name: inertia
description: Use when building or debugging Inertia.js apps — server-driven SPAs connecting Laravel/Rails/Django/etc. backends to React, Vue, or Svelte without an API. Covers Inertia::render, router visits, Link/Form components, useForm, shared and deferred props, partial reloads, prefetching, validation errors, file uploads, CSRF, asset versioning, SSR, and v1/v2/v3 differences.
metadata:
    source: https://inertiajs.com/docs/llms.txt
    mirrored: "2026-09-22"
    version: "1.0"
---

# Inertia.js Skill Reference

## Overview

Inertia is a protocol plus adapters that let server-side frameworks (Laravel first-class; community adapters for Rails, Django, Symfony, and more) drive React/Vue/Svelte page components without building an API. Routes return `Inertia::render()` responses; the client adapter swaps the page component and hydrates props. "The modern monolith."

`references/` is a mirror of inertiajs.com/docs — 122 markdown pages across all three doc versions: `v3/` (current), `v2/`, `v1/` (legacy apps). `references/llms.txt` is the upstream index. Refresh with `bash scripts/refresh-docs.sh`.

## When to Use

- **Setup**: server-side adapter install, `HandleInertiaRequests` middleware, root template, `createInertiaApp` client setup
- **Pages/responses**: `Inertia::render`, props (closures, deferred, merged, once, optional), `Inertia::location`
- **Navigation**: `<Link>`, `router.visit()`, manual visits, redirects, scroll management
- **Forms**: `<Form>` component, `useForm`, validation errors, file uploads
- **Data**: shared data, flash data, partial reloads (`only`/`except`), prefetching, polling, infinite scroll, remembering state
- **Security**: auth/authorization patterns, CSRF, history encryption
- **Advanced**: asset versioning, code splitting, SSR, events, error handling, testing, TypeScript, devtools

## Reference Index

Pages mirror `inertiajs.com/docs/<version>/<section>/<page>.md` → `references/<version>/<section>/<page>.md`. v3 is current; v2/v1 sections exist for legacy apps (page sets differ slightly — check `references/llms.txt`).

| Section | Path | Covers |
|---------|------|--------|
| Getting started | `references/v3/getting-started/` | index (intro), demo-application, upgrade-guide |
| Installation | `references/v3/installation/` | server-side-setup, client-side-setup |
| Core concepts | `references/v3/core-concepts/` | who-is-it-for, how-it-works, the-protocol |
| The basics | `references/v3/the-basics/` | pages, responses, redirects, routing, title-and-meta, links, manual-visits, instant-visits, forms, http-requests, optimistic-updates, file-uploads, validation, layouts, view-transitions |
| Data & props | `references/v3/data-props/` | shared-data, flash-data, partial-reloads, deferred-props, merging-props, once-props, polling, prefetching, load-when-visible, infinite-scroll, remembering-state |
| Security | `references/v3/security/` | authentication, authorization, csrf-protection, history-encryption |
| Advanced | `references/v3/advanced/` | asset-versioning, code-splitting, devtools, error-handling, events, progress-indicators, scroll-management, server-side-rendering, testing, typescript |

## Quick Reference

Server side (Laravel adapter shown; community adapters are analogous):

| Task | Code | Notes |
|------|------|-------|
| Render page | `Inertia::render('Users/Index', ['users' => $users])` | Component resolved client-side by convention |
| Lazy prop | `'users' => fn () => User::all()` | Evaluated when needed; use `Inertia::optional()` to skip unless requested. `Inertia::lazy()` removed in v3 |
| Shared props | `Inertia::share('auth.user', ...)` | Or `share()` in `HandleInertiaRequests` |
| Deferred prop | `Inertia::defer(fn () => ..., 'group')` | Loaded after initial render; group for parallel |
| Scroll prop | `Inertia::scroll(fn () => User::paginate())` | Normalizes pagination metadata for `<InfiniteScroll>`; pairs with it |
| Merge prop | `Inertia::merge($items)` | Underlying primitive for append/prepend; `<InfiniteScroll>` uses it internally |
| External redirect | `Inertia::location($url)` | Full browser visit (409 + X-Inertia-Location) |
| Redirect after PUT/PATCH/DELETE | `return redirect()->route('...')` | Server sends 303 so the follow-up request uses GET |
| Validation errors | `return back()` (errors flash to session) | Laravel does this automatically on `ValidationException`; surfaced as `errors` prop / `form.errors` |
| Encrypt history | `Inertia::encryptHistory()` | Per-request; also `inertia.history.encrypt` config, `EncryptHistory` middleware / `'inertia::encrypt'` alias, `Inertia::clearHistory()` to rotate the key |

Client side:

| Task | Code | Notes |
|------|------|-------|
| App boot | `createInertiaApp({ resolve, setup })` | `resolve` maps page names to components |
| Link | `<Link href="/users">` | `method="post" as="button"`, `prefetch`, `preserve-scroll` |
| Visit | `router.visit(url, { method, data })` | Or `router.get/post/put/patch/delete` |
| Form helper | `useForm({...}).post('/users')` | Tracks `processing`, `errors`, `progress` |
| Form component | `<Form action="/users" method="post">` | v3: declarative form, validation slots |
| Shared props | `usePage().props` | Or `$page.props` in Vue/Svelte |
| Partial reload | `router.reload({ only: ['users'] })` | `except` also supported |
| Head | `<Head title="Users" />` | Managed `<title>`/meta; Svelte adapter has no `<Head>` — use `<svelte:head>` |
| Infinite scroll | `<InfiniteScroll data="users">` | Pairs with `Inertia::scroll()` server-side; `manual` prop for load-more buttons |
| Progress | Automatic | NProgress-style; customize in events |
| SSR | `php artisan inertia:start-ssr` | Production needs SSR bundle + Node runtime; v3 + `@inertiajs/vite` runs SSR under `npm run dev` |

## Common Gotchas

- **Inertia is not an API.** `Inertia::render` responses exist to hydrate page components — for data endpoints, return normal JSON. Non-Inertia requests get full HTML; `X-Inertia` requests get JSON.
- **303 redirects required after PUT/PATCH/DELETE** — otherwise the browser re-issues the wrong verb on refresh. Laravel `redirect()` does this correctly; custom responses must too.
- **Asset version mismatch triggers a full page reload** — bump `version()` when assets change; the client receives a 409 and does a hard visit automatically (v3.6+ exempts background requests like polling and `router.reload`).
- **Validation errors flow through redirects**, not JSON — `back()->withErrors()` lands them in the `errors` prop (or `form.errors` with `useForm`). Never render error JSON for forms.
- **File uploads use FormData automatically** via `useForm`/`<Form>`/`router.post`. Manual axios/fetch visits need `forceFormData: true`.
- **`preserveState`/`preserveScroll`** — essential for filter/search inputs and paginated lists so typing doesn't reset component state or scroll position.
- **`Vary: X-Inertia` must be set on responses** or caches can serve the wrong body type. The official middleware handles it; custom setups must add it.
- **CSRF uses the XSRF cookie convention** — Inertia sends `X-XSRF-TOKEN` from the `XSRF-TOKEN` cookie (axios-style). Laravel works out of the box; other frameworks may need cookie/header config.
- **History encryption matters for sensitive props** — page props live in browser history state; `encryptHistory` encrypts them (requires HTTPS — `window.crypto.subtle` only exists in secure contexts). `clearHistory` rotates the key, after which older entries need a fresh server request.
- **SSR needs a Node process and separate build in production** — optional and adds ops complexity; in dev, v3 + `@inertiajs/vite` handles SSR automatically under `npm run dev`. Most apps don't need it.
- **Doc versions diverge** — v3 adds instant visits, optimistic updates, `useHttp`/http-requests, layout props, `preserveErrors`, and `@inertiajs/vite` dev-mode SSR; `<Form>`, once props, view transitions, and `<InfiniteScroll>` already exist in v2. v1 has no `data-props/` or `security/` sections — those pages live under `advanced/` and `the-basics/`. Check which version the app runs before trusting a page.

## Maintenance

Docs mirror regenerated from `https://inertiajs.com/docs/llms.txt`. To update: `bash scripts/refresh-docs.sh`.
