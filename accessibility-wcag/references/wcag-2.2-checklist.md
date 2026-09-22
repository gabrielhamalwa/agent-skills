# WCAG 2.2 AA Audit Checklist

Check every item; report failures as `[SC] file:line`. Target conformance: **A + AA**.

Building or fixing a widget? `../apg/<widget>/pattern.md` has the canonical keyboard + ARIA contract; `../apg/example-index.md` finds examples by role/property.

## 1. Semantic structure

- [ ] `<html lang>` set; `lang` on foreign-language fragments — 3.1.1, 3.1.2
- [ ] Landmarks: one `<main>`; `<nav>`/`<header>`/`<footer>`/`<aside>` where applicable — 1.3.1
- [ ] Heading hierarchy: one `<h1>`, no skipped levels, headings not styled paragraphs — 1.3.1
- [ ] Lists are `<ul>`/`<ol>`/`<dl>`, not styled divs — 1.3.1
- [ ] Data tables use `<th scope>`; no layout tables — 1.3.1
- [ ] `<button>` for actions, `<a href>` for navigation — 4.1.2
- [ ] Custom widgets: correct `role` + states (`aria-expanded`/`selected`/`checked`/`current`) — 4.1.2
- [ ] No redundant roles; no ARIA overriding native semantics — 4.1.2
- [ ] Semantic elements (`em`/`strong`/`code`/`abbr`) for meaning — 1.3.1

## 2. Keyboard

- [ ] Every interactive element keyboard-focusable and operable — 2.1.1
- [ ] `Enter`/`Space` activate; arrows move within tablists, menus, radios, sliders — 2.1.1
- [ ] No `tabindex` > 0 (only `0` in-order or `-1` programmatic) — 2.4.3
- [ ] Tab order matches visual order; hidden content not focusable — 2.4.3
- [ ] No keyboard traps; focus can always leave any component — 2.1.2
- [ ] Skip-to-content link is first focusable element on full pages — 2.4.1
- [ ] `Esc` closes overlays (dialog, popover, dropdown, tooltip) — 2.1.1
- [ ] Pointer gestures (drag, path-based, multi-pointer) have single-pointer alternatives — 2.5.1

## 3. Focus management

- [ ] Visible focus indicator on every control; no bare `outline:none` — 2.4.7
- [ ] Focus indicator contrast ≥ 3:1 — 1.4.11
- [ ] Focused element not hidden behind sticky/fixed UI (`scroll-padding`) — 2.4.11
- [ ] Dialogs/menus: focus in on open (safe target, not destructive), back to trigger on close — 2.4.3
- [ ] `aria-modal` dialogs trap focus; background inert — 2.4.3
- [ ] SPA route change: focus to page heading or `<main>` — 2.4.3
- [ ] Dynamic content does not steal focus unless user-initiated — 3.2.1, 3.2.2
- [ ] List-item deletion: focus to next item (previous if last, else container) — 2.4.3
- [ ] Wizard/step advance: focus to new step heading — 2.4.3

## 4. Names, roles, values

- [ ] Every control has an accessible name (`label`/`alt`/`aria-label`/`aria-labelledby`/text) — 4.1.2
- [ ] Icon-only controls named (`aria-label` or visually-hidden text) — 4.1.2
- [ ] `aria-labelledby` over `aria-label` when visible text exists
- [ ] Accessible name contains the visible label text — 2.5.3
- [ ] Duplicate visible labels disambiguated ("Delete" → "Delete item: X") — 2.5.3
- [ ] State attributes reflect live state — 4.1.2
- [ ] Values/constraints exposed (`aria-valuenow`, `aria-required`, `aria-invalid`) — 4.1.2
- [ ] Dialogs: `role="dialog"` + `aria-modal="true"` + `aria-labelledby` → title — 4.1.2
- [ ] No `<a>` without `href` used as a button — 4.1.2
- [ ] `aria-hidden="true"` never on interactive elements or ancestors — 4.1.2

## 5. Forms

- [ ] Every input/select/textarea has a programmatic label; placeholders are not labels — 3.3.2, 4.1.2
- [ ] Required marked programmatically (`required`/`aria-required`), not just `*` or color — 3.3.2
- [ ] Errors: `aria-invalid` + `aria-describedby` → message saying what to fix and how — 3.3.1, 3.3.3
- [ ] Long forms: error summary on submit, focus moves to it — 3.3.1
- [ ] Related controls grouped with `<fieldset>`/`<legend>` — 1.3.1
- [ ] `autocomplete` on personal-data fields — 1.3.5
- [ ] Hint/help text wired via `aria-describedby` — 4.1.2
- [ ] Step changes announced (`aria-current="step"`) — 4.1.3
- [ ] Custom vs native validation deliberate (`required` fires before JS handlers, or `noValidate`) — 3.3.1
- [ ] Disabled controls don't hide required context — 1.3.1

## 6. Images & media

- [ ] Informative images: `alt` conveys content/function — 1.1.1
- [ ] Decorative: `alt=""` or `aria-hidden` (omitted `alt` announces the filename) — 1.1.1
- [ ] Functional images: `alt` = the action ("Search", not "magnifier") — 1.1.1
- [ ] Charts/complex images: short `alt` + adjacent data table or long description — 1.1.1
- [ ] SVG: `role="img"` + name, or `aria-hidden` + `focusable="false"` — 1.1.1
- [ ] `<canvas>`: fallback content or equivalent — 1.1.1
- [ ] Video captions, audio transcript, audio description or transcript — 1.2.2, 1.2.5, 1.2.1
- [ ] No text-as-image when real text suffices — 1.4.5

## 7. Color & contrast

- [ ] Text ≥ 4.5:1; large text (≥18pt / 14pt bold) ≥ 3:1 — 1.4.3
- [ ] UI components and meaningful graphics ≥ 3:1 — 1.4.11
- [ ] Focus indicators ≥ 3:1 — 1.4.11
- [ ] Hover/focus/active/disabled states meet contrast too — 1.4.3
- [ ] No info conveyed by color alone (add icon/text/pattern/underline) — 1.4.1
- [ ] In-text links distinguishable without hue — 1.4.1
- [ ] Placeholder ≥ 4.5:1 if it conveys meaning — 1.4.3
- [ ] Both themes checked if light and dark exist — 1.4.3

## 8. Motion & animation

- [ ] `prefers-reduced-motion` honored for non-essential animation — 2.3.3 guidance
- [ ] Nothing flashes > 3×/second — 2.3.1
- [ ] Auto-moving/updating content has pause/stop/hide — 2.2.2
- [ ] Animation not the sole carrier of information — 1.1.1

## 9. Dynamic content & live regions

- [ ] Status updates announced (`role="status"`/`aria-live="polite"`): toasts, results, confirmations — 4.1.3
- [ ] Errors use `role="alert"`/`assertive`, sparingly — 4.1.3
- [ ] Loading states announce completion (`aria-busy` during) — 4.1.3
- [ ] Live region mounted before text injected (React: keep empty `<p role="alert">` mounted) — 4.1.3
- [ ] Decorative/frequent changes not announced — 4.1.3
- [ ] No unexpected layout shift on update — 3.2.3

## 10. Pointer & touch

- [ ] Targets ≥ 24×24 CSS px — 2.5.8 (2.2)
- [ ] Dragging has single-pointer alternative — 2.5.7 (2.2)
- [ ] Actions fire on up-event or are abortable/undoable — 2.5.2
- [ ] Hover content also opens on focus, dismissible, persistent under pointer — 1.4.13
- [ ] No info trapped in `title=` attributes — 1.3.1
- [ ] No double-tap/long-press-only actions — 2.1.1

## 11. Text, zoom & reflow

- [ ] 200% zoom: nothing clipped or overlapping — 1.4.4
- [ ] Reflows at 320px without horizontal scroll (except tables/maps/code) — 1.4.10
- [ ] `em`/`rem`/`%` for text sizing — 1.4.4
- [ ] Survives user text-spacing overrides — 1.4.12
- [ ] Works in both orientations — 1.3.4
- [ ] ~1.5 line-height, no justified text — 1.4.8 guidance

## 12. Navigation & page structure

- [ ] Unique descriptive `<title>` per page/route — 2.4.2
- [ ] Consistent nav order and component identification — 3.2.3, 3.2.4
- [ ] Multiple ways to reach pages — 2.4.5
- [ ] `aria-current="page"` on current nav item — 4.1.2
- [ ] Link text meaningful standalone — 2.4.4
- [ ] `target="_blank"` disclosed — 3.2.5
- [ ] Pagination/filter changes announced — 4.1.3

## 13. Timing

- [ ] Time limits warn before expiry and allow extension — 2.2.1
- [ ] Re-auth preserves entered data — 2.2.5
- [ ] No non-extendable timed interactions — 2.2.1

## 14. Internationalization & misc

- [ ] Not dependent on sensory characteristics alone ("the green button") — 1.3.3
- [ ] Abbreviations/jargon expandable — 3.1.4
- [ ] Plain-language alternative for complex content — 3.1.5
- [ ] Cognitive-test auth (CAPTCHA) has an accessible alternative — 3.3.8 (2.2)
- [ ] Consistent help mechanism location — 3.2.6 (2.2)

## 15. Component libraries & design systems

- [ ] No duplicated library ARIA: library Modal/Menu/Combobox already ship role, focus trap, `aria-expanded` — check its a11y docs before adding attributes — 4.1.2
- [ ] A11y-activating props present on every usage (icon-button name, input label, dialog title) — optional in types, required for output — 4.1.2
- [ ] Style overrides don't remove focus rings, shrink targets, or drop contrast — 2.4.7, 2.5.8, 1.4.3
- [ ] Static components with `onClick` use the library's interactive variant or a redesign — 2.1.1
- [ ] Composed `Heading`/`Section` levels don't skip — 1.3.1
- [ ] Widgets beyond library coverage follow the generic rules + `../apg/<widget>/pattern.md`

## Static-analysis grep starters

```bash
grep -rn 'onClick=' --include='*.tsx' | grep -v '<button\|<a '   # div/span click handlers
grep -rn 'tabIndex=\{[1-9]'                                     # positive tabindex
grep -rn '<img' | grep -v 'alt='                                # missing alt
grep -rn '<a ' --include='*.tsx' | grep -v 'href'               # anchor without href
grep -rn 'outline:\s*none\|outline-none'                        # killed focus ring
grep -rn 'prefers-reduced-motion'                               # motion respect
grep -rn 'role="dialog"\|aria-modal'                            # modal semantics
grep -rn 'title="' --include='*.tsx'                            # info trapped in title attr
```

## Runtime verification (needs a live page)

Static analysis can't cover focus behavior, announcements, or state contrast. If a browser automation or computer-use tool is connected (Playwright/DevTools MCP, `cua-driver`, playwright CLI), execute this for real; otherwise mark each step "needs manual verification" in the report — do not silently skip.

1. Tab through: every control reachable, order sane, indicator visible (screenshot focused states).
2. Every overlay: `Esc` closes, `Tab` cycles inside, focus returns to trigger.
3. 200% zoom: still readable and usable.
4. 320px viewport: reflows, no horizontal scroll.
5. Emulate `prefers-reduced-motion`: animations stop.
6. Dump the accessibility tree: names/roles/states sensible. This approximates screen-reader output; a real VoiceOver/NVDA pass stays a manual item.
7. All component states: expanded, focused, hovered, disabled, error, loading, selected.
8. Run axe in-page (`npx @axe-core/cli` or the MCP's evaluate) and reconcile with static findings.
