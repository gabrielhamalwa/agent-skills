---
name: accessibility-wcag
description: "Use when auditing, reviewing, or writing UI code for accessibility: WCAG 2.2 AA compliance checks, ARIA and semantic HTML, keyboard navigation and focus management, forms and error handling, contrast and color, motion and animation, screen-reader behavior, accessibility testing setup (axe, eslint-plugin-jsx-a11y), or preparing accessibility review reports."
metadata:
    version: "1.0"
---

# Accessibility Audit & WCAG Skill

## Overview

A systematic accessibility audit is not "spot the obvious issues" — it is walking a fixed checklist so nothing is skipped. This skill gives the audit process, the checklist, and the report format. Works for any framework, design system, or plain HTML.

`references/wcag-2.2-checklist.md` is the full checklist: code-level checks mapped to WCAG success criteria, organized by audit area. Consult it for anything beyond the quick pass below.

## When to Use

- **Audit/review**: checking existing components, pages, or PRs for a11y issues
- **Writing UI**: building modals, menus, tabs, forms, tables, tooltips, custom widgets accessibly from the start
- **Fixing issues**: resolving axe/Lighthouse/manual findings
- **Setup**: adding a11y linting or automated testing to a project

## Audit Workflow

1. **Static code pass** — read/grep the markup for every checklist category. Checklist order: semantics → keyboard → focus → names/roles → forms → media → contrast → motion → dynamic content → pointer/touch → reflow/text.
2. **Automated pass** — run whatever tooling exists (`axe`, Lighthouse, eslint-plugin-jsx-a11y). Automated tools catch ~30-40% of issues; they cannot replace the manual checklist (they don't test focus traps, keyboard flows, or screen-reader output).
3. **Manual verification** — keyboard-only walkthrough (Tab/Shift+Tab/Enter/Space/Escape/arrows), 200% zoom + 320px reflow, `prefers-reduced-motion` emulation, screen-reader spot check if possible.
4. **Report** — findings grouped by severity, each citing the WCAG criterion and location.

## Quick Reference

| Area | Check | WCAG |
|------|-------|------|
| Semantics | Real elements (`<button>` not `<div onClick>`), heading hierarchy, landmarks (`nav`/`main`/`header`), lists, `lang` on `<html>` | 1.3.1, 3.1.1, 4.1.2 |
| Keyboard | Everything interactive reachable + operable; no `tabindex>0`; no keyboard traps; Escape closes overlays; skip link | 2.1.1, 2.1.2, 2.4.3 |
| Focus | Visible `:focus-visible` indicator (never bare `outline:none`), focus moves into dialogs/menus on open, returns to trigger on close, not obscured by sticky headers | 2.4.7, 2.4.11, 2.4.12 |
| Names | Accessible name on every control (`alt`, `aria-label`, `<label>`, `aria-labelledby`); icon buttons get names; `aria-modal` + `role="dialog"` on modals | 4.1.2, 1.1.1 |
| Forms | Every input labeled, errors announced + tied via `aria-describedby`, `aria-invalid`, groups use `<fieldset>`/`<legend>`, `autocomplete` on personal data | 1.3.1, 3.3.1, 3.3.2, 1.3.5 |
| Media | `alt` on informative images, `alt=""` on decorative, captions on video, no text-in-images | 1.1.1, 1.2.2 |
| Contrast | Text ≥ 4.5:1 (3:1 if large), UI/focus indicators ≥ 3:1, info not conveyed by color alone | 1.4.3, 1.4.11, 1.4.1 |
| Motion | Honor `prefers-reduced-motion`, no >3 flashes/sec, pause/stop for auto-moving content | 2.3.3, 2.3.1, 2.2.2 |
| Dynamic | `aria-live`/status roles for async updates, toasts, validation; don't announce decorative changes | 4.1.3 |
| Pointer | Targets ≥ 24×24px (AA), dragging has single-pointer alternative, actions fire on up-event | 2.5.8, 2.5.7, 2.5.2 |
| Text/reflow | 200% zoom usable, reflow at 320px width, no horizontal scroll for text, user text-spacing override survives | 1.4.4, 1.4.10, 1.4.12, 1.3.4 |
| Timing | Warn before session expiry; allow extension | 2.2.1 |

## Report Format

```
## Accessibility Audit — <scope>

### Critical (blocks users)
- [WCAG 4.1.2] ConfirmDialog.tsx:10 — "Cancel" is a <div>, unreachable by keyboard → use <button type="button">

### Warnings (degraded experience)
- [WCAG 1.1.1] ConfirmDialog.tsx:7 — <img> missing alt → alt="" (decorative)

### Notes / needs manual check
- Contrast of .hint text needs measurement (≥ 4.5:1)

### Verified OK
- Real <button> submit, checkbox wrapped in <label>
```

Severity: **Critical** = keyboard/SR cannot operate it, or required information is unavailable (e.g. an error message or required-field hint a SR user never hears); **Warning** = usable but degraded/non-conformant; **Note** = can't verify statically or hardening suggestion. `File.tsx:NN` can be a snippet label when auditing pasted code. Always include a "Verified OK" section — it prevents reviewers re-flagging correct code.

## Tooling

| Tool | Use |
|------|-----|
| `eslint-plugin-jsx-a11y` | Lint-time: alt-text, click-events-have-key-events, anchor-is-valid, no-noninteractive-tabindex |
| `axe-core` / `@axe-core/playwright` | Runtime DOM audit in tests; `await new AxeBuilder({ page }).analyze()` |
| Lighthouse CI | Page-level a11y score in CI |
| carbon-mcp `code_audit` (if connected) | `categories: ["accessibility"]`, single `code` or batch `files[]` (max 50). Trust `analysis_method`: `"ast"` is reliable, `"regex"` is advisory (false positives/misses possible; `validation_confidence` 0.85 vs 0.95, <0.8 = degraded). Fix suggestions may name a specific design system's components — apply the equivalent pattern, not that library |
| Screen readers | VoiceOver (⌘F5), NVDA (free), JAWS — spot-check nav order + announcements |

## Common Misses

- **Focus return on close** — dialogs/menus that trap focus but never return it to the trigger.
- **Escape handling** — overlays that close on click-out but not Escape.
- **Overlay click bubbling** — `onClick` on the backdrop fires for clicks inside the dialog unless guarded (`e.target === e.currentTarget`).
- **`tabIndex > 0`** — breaks natural order; only `0` (in order) or `-1` (programmatic) are valid.
- **`alt=""` vs missing `alt`** — missing = SR reads filename; empty = skipped (correct for decorative).
- **Label/behavior mismatch** — `<a>` that acts like a button (no href, onClick close) or "Learn more" that dismisses.
- **Live-region abuse** — announcing every render; only status-worthy changes go in `aria-live`.
- **Info trapped in `title=` attributes** — hover-only; keyboard/touch/SR users never see it. Render as visible text via `aria-describedby`.
- **Native vs custom validation interplay** — `required` + `type="email"` fires browser validation before your `onSubmit` handler; pick one path deliberately (or `noValidate` the form and own all errors).
- **Live regions must exist before content** — in React, mount the empty `<p role="alert">` and inject text on error; rendering `{error && <div role="alert">}` creates region+content together and may not announce.
- **`<dialog>`/native elements exist** — prefer `<dialog>`, `<details>`, `<button>` over rebuilding with divs; modern `<dialog>` gives focus trap + Escape + top layer for free.
- **Duplicating library-provided a11y** — a component library's Modal/Menu/ComboBox already ships `role`, focus trap, return-focus, `aria-expanded`; adding your own ARIA or overrides breaks it. Check the library's accessibility contract before adding attributes.
- **A11y props optional in types but required for output** — libraries expose names via props (`iconDescription`, `label`, `labelText`, `modalHeading`, notification `title`) that TypeScript won't flag as missing. Audit usages, not just markup.
- **`aria-hidden` on focusable content** — hiding an interactive element or its ancestor removes it from the accessibility tree while it stays keyboard-focusable (axe `aria-hidden-focus`).
- **Contrast in states** — hover/focus/disabled variants often drop below 3:1 even when default passes.
- **Zoom/reflow** — fixed pixel heights + `overflow:hidden` clipping content at 200% zoom.

## Maintenance

Authored skill — no upstream mirror. Update by editing SKILL.md and `references/` directly. Informed by WCAG 2.2 and published design-system accessibility guidance, including IBM Carbon's public accessibility rules (Apache-2.0).
