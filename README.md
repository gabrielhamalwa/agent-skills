# skills

Agent skills for Claude Code, Codex, Copilot, Gemini CLI, Devin, and other agents that support the [agentskills.io](https://agentskills.io/specification) format.

## Install

```bash
# Install all skills
npx skills add gabrielhamalwa/skills -g

# Install a single skill
npx skills add gabrielhamalwa/skills --skill bun -g
```

## Skills

| Skill | Description |
|-------|-------------|
| [bun](bun/) | Complete local mirror of the official Bun documentation (319 pages) plus a distilled quick reference. Runtime, package manager, bundler, test runner, `Bun.serve`, native APIs, and ecosystem guides. |

## Attribution

The `bun` skill's `references/` directory is a mirror of the official Bun documentation at [bun.com/docs](https://bun.com/docs), fetched via their [llms.txt](https://bun.com/llms.txt) endpoint. All documentation content is authored by the Bun team (Oven) — see `references/project/license.md`. This repo only adds the `SKILL.md` index and the sync script.

The mirror refreshes weekly via GitHub Actions (`bun/scripts/refresh-docs.sh`). To update manually:

```bash
bash bun/scripts/refresh-docs.sh
```

## Updating installed skills

```bash
npx skills update -g
```
