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
```

## Skills

| Skill | Description |
|-------|-------------|
| [bun](bun/) | Complete local mirror of the official Bun documentation (319 pages) plus `bun-types` API definitions and a distilled quick reference. Runtime, package manager, bundler, test runner, `Bun.serve`, native APIs, and ecosystem guides. |
| [astro](astro/) | Complete local mirror of the official Astro docs source (422 pages). Components, islands and hydration, content collections, routing, SSR adapters, config/CLI/directives reference, and recipes. |
| [symfony](symfony/) | Complete local mirror of the official Symfony documentation (430 pages, reStructuredText, 7.4 branch). Controllers, routing, service container, Doctrine, forms, security, Messenger, Twig, console, testing. |
| [vite](vite/) | Complete local mirror of vite.dev docs (42 pages). Config options, plugin and HMR APIs, env/modes, build and library mode, SSR, Environment API, migration guides. |

## Attribution

Each skill's `references/` directory is an unmodified mirror of upstream documentation, and retains its upstream license:

- `bun/references/` — [bun.com/docs](https://bun.com/docs) via their [llms.txt](https://bun.com/llms.txt) endpoint, plus the [bun-types](https://www.npmjs.com/package/bun-types) `.d.ts` files. Authored by the Bun team (Oven, Inc.), MIT license — see `bun/references/project/license.md`.
- `astro/references/` — [withastro/docs](https://github.com/withastro/docs) `src/content/docs/en/` (the source of docs.astro.build). Authored by the Astro team and contributors, MIT license.
- `symfony/references/` — [symfony/symfony-docs](https://github.com/symfony/symfony-docs) (the source of symfony.com/doc). Authored by Symfony SAS and contributors under [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) — see `symfony/references/LICENSE.md`. Mirrored verbatim as a Collection; the mirrored pages remain under CC BY-SA.
- `vite/references/` — [vite.dev](https://vite.dev) docs via their [llms.txt](https://vite.dev/llms.txt) endpoint (source: [vitejs/vite](https://github.com/vitejs/vite)). Authored by the Vite team and contributors, MIT license.

This repo's own content (SKILL.md files, scripts, workflows) is MIT-licensed under the repo [LICENSE](LICENSE).

Mirrors refresh weekly via GitHub Actions. To update manually:

```bash
bash bun/scripts/refresh-docs.sh
bash astro/scripts/refresh-docs.sh
bash symfony/scripts/refresh-docs.sh
bash vite/scripts/refresh-docs.sh
```

## Updating installed skills

```bash
npx skills update -g
```
