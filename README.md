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
```

## Skills

| Skill | Description |
|-------|-------------|
| [bun](bun/) | Complete local mirror of the official Bun documentation (319 pages) plus `bun-types` API definitions and a distilled quick reference. Runtime, package manager, bundler, test runner, `Bun.serve`, native APIs, and ecosystem guides. |
| [astro](astro/) | Complete local mirror of the official Astro docs source (422 pages). Components, islands and hydration, content collections, routing, SSR adapters, config/CLI/directives reference, and recipes. |

## Attribution

Each skill's `references/` directory is an unmodified mirror of upstream documentation:

- `bun/references/` — [bun.com/docs](https://bun.com/docs) via their [llms.txt](https://bun.com/llms.txt) endpoint, plus the [bun-types](https://www.npmjs.com/package/bun-types) `.d.ts` files. Authored by the Bun team (Oven, Inc.), MIT license — see `bun/references/project/license.md`.
- `astro/references/` — [withastro/docs](https://github.com/withastro/docs) `src/content/docs/en/` (the source of docs.astro.build). Authored by the Astro team and contributors.

This repo's own content (SKILL.md files, scripts, workflows) is MIT-licensed under the repo [LICENSE](LICENSE).

Mirrors refresh weekly via GitHub Actions. To update manually:

```bash
bash bun/scripts/refresh-docs.sh
bash astro/scripts/refresh-docs.sh
```

## Updating installed skills

```bash
npx skills update -g
```
