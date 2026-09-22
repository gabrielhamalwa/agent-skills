---
name: code-migration
description: "Run a large-scale language migration with a six-step process: create the map and the rules, stress-test the rules, translate everything, compile, run it, match behavior. Use when the user wants to migrate, port, or rewrite a codebase from one language to another ('migrate this to Rust', 'port our Python CLI to TypeScript', 'should we rewrite this in Go?'), or asks for a migration feasibility assessment. Not for incremental JS→TS adoption or single-file conversions."
metadata:
    version: "1.0"
---

# Code migration (six-step process)

You are orchestrating a language migration using the kit mirrored in `references/kit/`. `references/kit/README.md` defines the process; `references/kit/CLAUDE.md` defines your standing rules — read both before acting. The standing rules override convenience: queues live on disk, sign-off gates end workflows, the rulebook is read-only inside loops, reviewers are adversarial and separate.

## Harness notes

The kit was written for Claude Code, but everything is plain markdown — it ports mechanically to any agent harness. The only harness-specific mechanics:

- **`references/kit/CLAUDE.md`** → import it into the target repo's agent-instructions file (`CLAUDE.md`, `AGENTS.md`, `.cursorrules`, or the equivalent).
- **`templates/settings.json` deny rules** → written in Claude Code's permission format. For other harnesses, install the equivalent denies (block the compiler, test runners, and mutating VCS commands inside loops), or have the human enforce the bans manually. The intent is what matters: fixers work the rulebook, not the compiler. Never route around a live deny.
- Prompts that say "Claude Code" mean "the agent reading this."

## Routing

1. **No migration artifacts exist yet** (`migration/` absent): run `references/kit/prompts/00-feasibility.md`. Produce the report, deliver the verdict, STOP. Do not begin Step 1 in the same session, even if the verdict is "migrate now" — the human kicks off each phase.
2. **Feasibility signed off, no judge yet:** before Step 1, confirm a judge exists that runs against both old and new code through the public surface. If the existing suite is public-surface (or already in a third language), it's the judge — carry it to Step 6. If it imports internals, run `prompts/00b-judge-setup.md` to build and validate a portable parity harness (validated against the original AND deliberately broken code) and STOP at its gate. Never start Step 1 without a judge — there's no exit condition without one.
3. **Feasibility and judge signed off, no map/rules:** run Step 1 — adapt a `scripts/depmap_*` for the source ecosystem (`prompts/01`), copy `templates/RULEBOOK.md` to `migration/RULEBOOK.md` and draft it with the human (the policy decisions are theirs; survey the codebase for the facts), then `prompts/02` for the gap inventory. Each ends at its own gate.
4. **Step 1 signed off:** confirm the HUMAN has installed the deny rules from `references/kit/templates/settings.json` into the agent's permission settings (see Harness notes) — prompt 03 verifies it; never install it yourself — then run `prompts/03-stress-test.md`. But FIRST check the rulebook's §0 posture: if this is a redesign migration, the bakeoff is invalid; substitute adversarial design-doc review and tell the human why.
5. **Stress test signed off:** confirm `migration/manifest.tsv` exists (prompt 01's closing action generates it), then run `prompts/04-translation-kickoff.md` with `scripts/queue_runner.mjs` as the queue — first check the referee price: if the target's typecheck is cheap, the dissolve edit is the human's act at the gate — ask them to remove those denies from the settings; never edit it yourself (README Step 4 dissolves into Step 3).
6. **Translation queue empty:** Step 4 via `prompts/05-survey-build.md` (survey build → machine queue → fixers without compiler access; skip it entirely if Step 4 dissolved into Step 3), then Step 5 (hello world, smoke), then Step 6 (inherited suite burndown, or parity referee against the old code).
7. **Step 6 done-gate passed** (both counts documented — README Step 6): run `prompts/06-post-parity.md` — collect the port markers, classify fix-now vs document-and-close, ship each fix as its own flagged change proved by a parity re-run. Ends at its own gate.

## Constant behaviors

- Report progress as burndown numbers (`scripts/queue_runner.mjs status`), not prose.
- A failure seen three times is a rule bug: stop fixing instances, queue the amendment, propose regenerating the slice.
- "Don't migrate" and "stop here" are valid recommendations at every gate.

## Maintenance

`references/kit/` is a verbatim mirror of [anthropics/code-migration-kit-with-claude-code](https://github.com/anthropics/code-migration-kit-with-claude-code) (Apache-2.0) — update via `scripts/refresh-docs.sh`, do not hand-edit. `SKILL.md` is authored — edit directly.
