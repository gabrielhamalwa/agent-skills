---
name: storybook
description: "Storybook documentation and reference (v10). Use when building, testing, or documenting UI components in isolation: writing stories (CSF, args, decorators, parameters), play functions and interaction, visual or accessibility tests, autodocs and MDX, addons, main.ts and preview.ts configuration, framework setup (React, Vue, Angular, Svelte, Next.js), publishing Storybooks, or upgrading between versions."
metadata:
    source: https://storybook.js.org/llms.txt
    mirrored: "2026-09-22"
    version: "1.0"
---

# Storybook Skill Reference

## Overview

Storybook is a frontend workshop for building UI components and pages in isolation: a dev server that renders "stories" (component states written in CSF), a test harness (interaction, visual, a11y, coverage), and a static docs site. Key files: `.storybook/main.ts` (stories globs, addons, framework), `.storybook/preview.ts` (parameters, decorators, globals). Commands: `storybook dev`, `storybook build`.

`references/` contains the Storybook documentation: all 167 pages listed in the upstream index, covering stories, testing, docs, addons, configuration, the API reference, and migration guides. `references/llms.txt` is the page index. Update with `bash scripts/refresh-docs.sh`.

## When to Use

- **Setup**: `storybook init`, per-framework guides (React/Vue/Angular/Svelte/Next.js/Web Components), `.storybook/` config
- **Stories**: CSF format, args, parameters, decorators, play functions, loaders, tags, mocking modules/network/providers
- **Testing**: interaction tests, accessibility, visual tests, snapshot tests, coverage, CI, Vitest addon vs test-runner, portable stories
- **Docs**: autodocs, MDX pages, Doc Blocks, code panel
- **Addons**: install, write, configure, addon API, presets
- **Configure**: styling, story rendering/layout, UI theming, sidebar/URLs, env variables, telemetry
- **Builders/API**: vite, webpack, `main.ts` options (`main-config-*` pages), argTypes, Doc Blocks API, CLI options
- **AI/MCP**: `/docs/ai/` covers the Storybook MCP server and agent workflows
- **Upgrading**: migration guides, release notes

## Reference Index

Pages map `storybook.js.org/docs/<path>` → `references/<path>.md`:

| Area | Path | Covers |
|------|------|--------|
| Get started | `references/get-started/` | why-storybook, install, frameworks/ (per-stack setup: nextjs-vite, react-vite, vue3-vite, angular, sveltekit, ...), whats-a-story, browse-stories, setup |
| Writing stories | `references/writing-stories/` | args, parameters, decorators, play-function, loaders, tags, naming, mocking-data-and-modules/ (modules, network-requests, providers), typescript |
| Writing tests | `references/writing-tests/` | interaction-testing, accessibility-testing, visual-testing, snapshot-testing, test-coverage, in-ci, integrations/ (vitest-addon, test-runner, stories-in-unit-tests, stories-in-end-to-end-tests) |
| Writing docs | `references/writing-docs/` | autodocs, mdx, doc-blocks, code-panel, build-documentation |
| AI | `references/ai/` | setup, agentic-review, mcp/ (overview, api, sharing), best-practices, manifests |
| Sharing | `references/sharing/` | publish-storybook, embed, design-integrations, storybook-composition, package-composition |
| Essentials | `references/essentials/` | actions, backgrounds, controls, highlight, measure-and-outline, toolbars-and-globals, viewport |
| Addons | `references/addons/` | install-addons, writing-addons, configure-addons, writing-presets, integration-catalog, addon-types, addon-knowledge-base, addons-api, addon-migration-guide |
| Configure | `references/configure/` | styling-and-css, telemetry, integration/ (frameworks, compilers, typescript, eslint-plugin, images-and-assets), story-rendering, story-layout, user-interface/ (theming, sidebar-and-urls, ...), environment-variables |
| Builders | `references/builders/` | vite, webpack, builder-api |
| API | `references/api/` | main-config/ (every `main.ts` option: stories, addons, framework, staticDirs, viteFinal, webpackFinal, swc, typescript, ...), arg-types, parameters, doc-blocks/, portable-stories/ (vitest, jest), new-frameworks, cli-options |
| Releases | `references/releases/` | migration-guide, migration-guide-from-older-version, upgrading, features, roadmap |
| Other | `references/` root + `contribute/` | faq, contribute/ (code, framework, documentation) |

## Quick Reference

| Task | Command / code | Notes |
|------|---------------|-------|
| Init | `npm create storybook@latest` | Detects framework, scaffolds `.storybook/` + example stories (`init` is the pre-v10 form) |
| Dev server | `storybook dev -p 6006` | Usually via `npm run storybook` script |
| Static build | `storybook build` | Output: `storybook-static/` |
| Story (CSF3) | `const meta = { component: Btn } satisfies Meta<typeof Btn>; export default meta;` + `type Story = StoryObj<typeof meta>` | Named `const meta` required for `typeof meta`; CSF Next (`preview.meta()`, `definePreview`) is the experimental successor |
| Args | `args: { label: 'Hi', disabled: false }` | Drive controls, play functions, autodocs table |
| Decorator | `decorators: [(Story) => <Provider><Story/></Provider>]` | Per-story, meta, or global in preview |
| Parameters | `parameters: { layout: 'centered' }` | `layout`, `controls`, `backgrounds`, per-addon keys |
| Play function | `play: async ({ canvas, userEvent, args, step }) => { ... }` | v10 context API — `canvas` replaces `within(canvasElement)`; `mount` also available |
| Global config | `.storybook/preview.ts` | Global parameters/decorators/initialGlobals |
| Main config | `.storybook/main.ts` | `stories` globs are picomatch, relative to `.storybook/`; `addons`, `framework`, `staticDirs` |
| Tags | `tags: ['autodocs']` | `autodocs` generates docs page; `!dev` removes from sidebar, `!test` excludes from test runs |
| Autodocs | `tags: ['autodocs']` on meta | MDX: `<Meta>`, `<Canvas>`, `<Controls>` doc blocks |
| Mock module | `sb.mock(import('./api.ts'))` in `.storybook/preview.*` only | Core feature (Vite + Webpack), no addon; control per-story via `mocked()`/`fn()` from `storybook/test` |
| Mock network | `msw` + `msw-storybook-addon` | `loaders: [mswLoader()]` in preview; per-story `beforeEach({ msw }) { msw.use(http.get(...)) }` |
| Vitest addon | `@storybook/addon-vitest` | Component tests via portable stories in Vitest browser mode; `vitest --project=storybook` in CI |
| Test runner | `test-storybook` CLI | Superseded by the Vitest addon; Jest+Playwright against a running Storybook (`--url`/`TARGET_URL`) |
| Env var | `STORYBOOK_PUBLIC_API_URL` | `STORYBOOK_`-prefixed vars reach the browser |
| Publish | `npx chromatic` | Chromatic or any static host for `storybook-static` |

## Common Gotchas

- **Args must be serializable** to appear in controls/URLs; functions and class instances need `argTypes` mapping or decorators.
- **Empty sidebar usually means a `stories` glob miss** — `main.ts` uses fast-glob patterns relative to `.storybook/`; check `references/api/main-config/main-config-stories.md`.
- **`play` functions are async and run after render** — v10 destructures `{ canvas, userEvent, args, step, mount }` (no more `within(canvasElement)`); always `await userEvent`, use `step()` for grouping, `expect`/`fn`/`mocked`/`screen` come from `storybook/test`.
- **The test-runner is superseded by the Vitest addon** — the docs say so verbatim. Prefer `@storybook/addon-vitest` (Vitest browser mode, no running Storybook needed); keep `test-storybook` only for Webpack setups or snapshot tests, which the addon doesn't do.
- **CSF Next is the recommended format for new TypeScript stories** — experimental in v10 (`preview.meta()`, `meta.story()`, `definePreview`, `defineMain`); every doc page shows dual CSF3/CSF Next snippets. Upstream's `api/csf*` pages aren't in `llms.txt` so they're absent here — fetch them live if needed.
- **Mirrored code snippets drop `import` lines and some JSX/generics** (upstream `.md` generation artifact — `satisfies Meta<typeof X>` may render as `satisfies Meta;`). Treat snippets as patterns and supply imports yourself: `Meta`/`StoryObj` from the framework package (`@storybook/react-vite` etc.), `sb`/`expect`/`fn`/`mocked`/`screen`/`userEvent`/`step` from `storybook/test`, `mswLoader` from `msw-storybook-addon`.
- **Env vars need the `STORYBOOK_` prefix** — other vars never reach the browser bundle.
- **Addons consolidated in v9+** — most essentials moved into core; import framework types from the framework package (`@storybook/react-vite` etc.), not `@storybook/react`, and test utilities from `storybook/test` (not `@storybook/test`). See `releases/migration-guide-from-older-version.md` (v9) and `releases/migration-guide.md` (v10).
- **Renderer/language variants**: these docs are the React+TypeScript variant; upstream serves other renderers via `?renderer=` and older versions via `/docs/<9|8|11>/` — the mirrored pages are for current v10.
- **`staticDirs` copies assets verbatim** (like Vite's `public/`); processed assets should be imported.
- **Telemetry is on by default** — `--disable-telemetry` or `STORYBOOK_DISABLE_TELEMETRY=1` to opt out.
- **Portable stories** (`composeStories`/`setProjectAnnotations`) reuse stories in Vitest/Jest but need the preview annotations wired via `setProjectAnnotations`.

## Maintenance

Update `references/` with `bash scripts/refresh-docs.sh` (pulls the latest docs from storybook.js.org, prunes stale pages). Runs weekly via GitHub Actions.
