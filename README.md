# agent-skills

[![skills.sh](https://skills.sh/b/gabrielhamalwa/agent-skills)](https://skills.sh/gabrielhamalwa/agent-skills)

Agent skills for Claude Code, Codex, Copilot, Gemini CLI, Devin, and other agents that support the [agentskills.io](https://agentskills.io/specification) format.

## Install

```bash
# Install all skills
npx skills add gabrielhamalwa/agent-skills -g

# Install a single skill
npx skills add gabrielhamalwa/agent-skills --skill bun -g
```

## Skills

| Skill | Description |
|-------|-------------|
| [bun](bun/) | Complete local mirror of the official Bun documentation (319 pages) plus a distilled quick reference. Runtime, package manager, bundler, test runner, `Bun.serve`, native APIs, and ecosystem guides. |

## Attribution

The `bun` skill's `references/` directory is an unmodified mirror of the official Bun documentation at [bun.com/docs](https://bun.com/docs), fetched via their [llms.txt](https://bun.com/llms.txt) endpoint. All documentation content is authored by the Bun team (Oven, Inc.) and distributed under Bun's MIT license — see `bun/references/project/license.md`. This repo's own content (SKILL.md files, scripts, workflows) is MIT-licensed under the repo [LICENSE](LICENSE).

The mirror refreshes weekly via GitHub Actions (`bun/scripts/refresh-docs.sh`). To update manually:

```bash
bash bun/scripts/refresh-docs.sh
```

## Updating installed skills

```bash
npx skills update -g
```
