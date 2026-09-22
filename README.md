# agent-skills

[![skills.sh](https://skills.sh/b/gabrielhamalwa/agent-skills)](https://skills.sh/gabrielhamalwa/agent-skills)

Agent skills for Claude Code, Codex, Copilot, Gemini CLI, Devin, and other agents that support the [agentskills.io](https://agentskills.io/specification) format.

## Install

```bash
# Install all skills
npx skills add gabrielhamalwa/agent-skills -g

# Install a single skill
npx skills add gabrielhamalwa/agent-skills --skill bun -g
npx skills add gabrielhamalwa/agent-skills --skill astro -g
npx skills add gabrielhamalwa/agent-skills --skill symfony -g
npx skills add gabrielhamalwa/agent-skills --skill vite -g
npx skills add gabrielhamalwa/agent-skills --skill inertia -g
npx skills add gabrielhamalwa/agent-skills --skill storybook -g
npx skills add gabrielhamalwa/agent-skills --skill tailwind -g
npx skills add gabrielhamalwa/agent-skills --skill accessibility-wcag -g
```

## Skills

| Skill | Description |
|-------|-------------|
| [bun](bun/) | Official Bun documentation (319 pages) plus `bun-types` API definitions and a distilled quick reference. Runtime, package manager, bundler, test runner, `Bun.serve`, native APIs, and ecosystem guides. |
| [astro](astro/) | Official Astro documentation (422 pages). Components, islands and hydration, content collections, routing, SSR adapters, config/CLI/directives reference, and recipes. |
| [symfony](symfony/) | Official Symfony documentation (430 pages, reStructuredText, 7.x branch). Controllers, routing, service container, Doctrine, forms, security, Messenger, Twig, console, testing. |
| [vite](vite/) | Official Vite documentation (42 pages). Config options, plugin and HMR APIs, env/modes, build and library mode, SSR, Environment API, migration guides. |
| [inertia](inertia/) | Official Inertia.js documentation (122 pages, v1-v3). Pages/responses, links and router visits, forms and validation, shared/deferred props, prefetching, CSRF and history encryption, SSR, testing. |
| [storybook](storybook/) | Official Storybook documentation (167 pages, v10). Stories/CSF, args, decorators, play functions, interaction/visual/a11y testing, autodocs and MDX, addons, configuration, framework guides, migration. |
| [tailwind](tailwind/) | Official Tailwind CSS documentation (197 pages + install guides, v4). CSS-first `@theme` config, every utility reference, variants and dark mode, custom utilities/variants, Vite/PostCSS/CLI setup, framework guides, v3 upgrade. |
| [accessibility-wcag](accessibility-wcag/) | WCAG 2.2 AA audit methodology and checklist for any UI codebase: semantics, keyboard, focus, names/roles, forms, contrast, motion, live regions, pointer targets, reflow. Audit workflow, severity rubric, report format, tooling (axe, jsx-a11y). |

## Attribution

Each skill ships the complete upstream documentation under `references/` (unmodified, retaining its upstream license):

- `bun/references/` — [bun.com/docs](https://bun.com/docs) via their [llms.txt](https://bun.com/llms.txt) endpoint, plus the [bun-types](https://www.npmjs.com/package/bun-types) `.d.ts` files. Authored by the Bun team (Oven, Inc.), MIT license — see `bun/references/project/license.md`.
- `astro/references/` — [withastro/docs](https://github.com/withastro/docs) `src/content/docs/en/` (the source of docs.astro.build). Authored by the Astro team and contributors, MIT license.
- `symfony/references/` — [symfony/symfony-docs](https://github.com/symfony/symfony-docs) (the source of symfony.com/doc). Authored by Symfony SAS and contributors under [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) — see `symfony/references/LICENSE.md`. Mirrored verbatim as a Collection; the mirrored pages remain under CC BY-SA.
- `vite/references/` — [vite.dev](https://vite.dev) docs via their [llms.txt](https://vite.dev/llms.txt) endpoint (source: [vitejs/vite](https://github.com/vitejs/vite)). Authored by the Vite team and contributors, MIT license.
- `inertia/references/` — [inertiajs.com/docs](https://inertiajs.com/docs/v3/getting-started/index) via their [llms.txt](https://inertiajs.com/docs/llms.txt) endpoint. Authored by Jonathan Reinink and the Inertia.js contributors.
- `storybook/references/` — [storybook.js.org/docs](https://storybook.js.org/docs) via their [llms.txt](https://storybook.js.org/llms.txt) endpoint (React + TypeScript variant, current version). Authored by the Storybook team and contributors, MIT license.
- `tailwind/references/` — [tailwindlabs/tailwindcss.com](https://github.com/tailwindlabs/tailwindcss.com) `src/docs/` plus the installation guide pages (the source of tailwindcss.com/docs). Authored by Tailwind Labs and contributors.

This repo's own content (SKILL.md files, scripts, workflows) is MIT-licensed under the repo [LICENSE](LICENSE).

`accessibility-wcag` is authored content, not a mirror — it has no refresh workflow and is covered by this repo's MIT license like the SKILL.md files.

Mirrors refresh weekly via GitHub Actions. To update manually:

```bash
bash bun/scripts/refresh-docs.sh
bash astro/scripts/refresh-docs.sh
bash symfony/scripts/refresh-docs.sh
bash vite/scripts/refresh-docs.sh
bash inertia/scripts/refresh-docs.sh
bash storybook/scripts/refresh-docs.sh
bash tailwind/scripts/refresh-docs.sh
```

## Updating installed skills

```bash
npx skills update -g
```
