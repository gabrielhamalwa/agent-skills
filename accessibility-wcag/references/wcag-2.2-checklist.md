# WCAG 2.2 AA Audit Checklist

Code-level checks grouped by audit area. Each item maps to a WCAG success criterion (SC). Target conformance: **A + AA**.

## 1. Semantic structure

- [ ] `<html lang="…">` set; `lang` on foreign-language fragments (3.1.1, 3.1.2)
- [ ] Landmarks: one `<main>`, `<nav>` for nav, `<header>`/`<footer>`, `<aside>` — or equivalent `role` (1.3.1)
- [ ] Heading hierarchy: one `<h1>`, no skipped levels, headings aren't styled paragraphs (1.3.1)
- [ ] Lists use `<ul>/<ol>/<dl>`; related items aren't bare divs (1.3.1)
- [ ] Tables: `<th scope>` headers; data tables only — no layout tables (1.3.1)
- [ ] `<button>` for actions, `<a href>` for navigation — never the reverse (4.1.2)
- [ ] Custom widgets carry correct `role` + required states (`aria-expanded`, `aria-selected`, `aria-checked`, `aria-current`) (4.1.2)
- [ ] No redundant roles (`<button role="button">`) and no ARIA overriding native semantics (4.1.2)
- [ ] `<em>/<strong>/<code>/<abbr title>` for meaning; `<i>/<b>` for presentation only (1.3.1)

## 2. Keyboard

- [ ] Every interactive element focusable and operable by keyboard: links, buttons, inputs, menus, tabs, dialogs, sliders, custom widgets (2.1.1)
- [ ] `Enter`/`Space` activate buttons; arrows move within tab lists, menus, radio groups, sliders (2.1.1)
- [ ] No `tabindex` > 0 — only `0` (natural order) or `-1` (programmatic) (2.4.3)
- [ ] Tab order matches visual/reading order; no focus into hidden or offscreen content (2.4.3)
- [ ] No keyboard traps — Esc exits modals/menus; focus can always leave any component (2.1.2)
- [ ] Skip-to-content link as first focusable element on full pages (2.4.1)
- [ ] `Esc` closes overlays (dialog, popover, dropdown, tooltip) (2.1.1 + platform convention)
- [ ] No keyboard-only gestures required (path-based drawing, multi-pointer) without alternative (2.5.1)

## 3. Focus management

- [ ] Visible focus indicator on every interactive element; `:focus-visible` styled; never bare `outline: none` (2.4.7)
- [ ] Focus indicator contrast ≥ 3:1 against adjacent colors (1.4.11)
- [ ] Focus not obscured by sticky headers/footers/cookie banners — fix with `scroll-padding-top`/`scroll-margin-top` sized to the sticky element (2.4.11 AA, 2.4.12 enhanced)
- [ ] Dialogs/menus move focus in on open (to a safe target, not destructive actions) and return focus to the trigger on close (2.4.3)
- [ ] Focus trap inside `aria-modal` dialogs; background content inert (2.4.3)
- [ ] Focus after route change/spa navigation goes to page heading or main (SPA convention)
- [ ] Dynamic content appearing (validation, toasts) doesn't steal focus unless user-initiated (3.2.1, 3.2.2)
- [ ] Item deleted from a list: focus moves to the next item (previous if it was last, else the list container), never dumped to `<body>` (2.4.3)
- [ ] Step/wizard advance: focus moves to the new step heading or first focusable element (2.4.3)

## 4. Names, roles, values

- [ ] Every interactive element has an accessible name: `<label>`/`aria-label`/`aria-labelledby`/`alt`/text content (4.1.2)
- [ ] Icon-only buttons/links have `aria-label` or visually-hidden text (4.1.2)
- [ ] `aria-labelledby` preferred over `aria-label` when visible text exists (keeps name synced)
- [ ] Accessible name starts with the visible label text (2.5.3 — voice control)
- [ ] `role` matches behavior; state attributes reflect actual state and update live (4.1.2)
- [ ] Inputs expose programmatic value/constraint info (`aria-valuenow`, `aria-required`, `aria-invalid`) (4.1.2)
- [ ] Dialogs: `role="dialog"` + `aria-modal="true"` + `aria-labelledby` pointing at title (4.1.2)
- [ ] `<a>` without `href` isn't focusable or used as a button — pick the right element (4.1.2)
- [ ] `aria-hidden="true"` never applied to interactive elements or their ancestors (4.1.2; axe `aria-hidden-focus`)
- [ ] Identical visible labels disambiguated in the accessible name: two "Delete" buttons → `aria-label="Delete item: Project Alpha"` (2.5.3)

## 5. Forms

- [ ] Every input/select/textarea has a programmatic label (`<label for>` or `aria-labelledby`) — placeholders don't count (3.3.2, 4.1.2)
- [ ] Required fields indicated programmatically (`required`/`aria-required`), not just `*` or color (3.3.2)
- [ ] Errors: `aria-invalid="true"` on the field + `aria-describedby` linking the message; error text says what's wrong and how to fix (3.3.1, 3.3.3)
- [ ] Error summary on submit for long forms; focus moves to it (3.3.1)
- [ ] Related controls grouped in `<fieldset>` + `<legend>` (radio groups, checkboxes, address blocks) (1.3.1)
- [ ] `autocomplete` tokens on fields collecting personal data (name, email, address, tel, cc-*) (1.3.5)
- [ ] No `input[type]` forcing formats users can't enter; input purpose not assumed from placeholder (3.3.2)
- [ ] Disabled controls don't hide required context; consider `aria-disabled` + explanation instead (1.3.1)
- [ ] Help/hint text wired via `aria-describedby` (4.1.2)
- [ ] Multi-step flows announce step changes (`aria-current="step"`) (4.1.3)
- [ ] Custom validation vs native: `required` + `type="email"`/`type="url"` fires browser validation before JS handlers — pick one path deliberately (`noValidate` if owning all errors) (3.3.1)

## 6. Images & media

- [ ] Informative images: meaningful `alt` conveying purpose, not filename (1.1.1)
- [ ] Decorative images/icons: `alt=""` or `aria-hidden="true"` — never omit `alt` (omission makes screen readers announce the filename) (1.1.1)
- [ ] Functional images (icon buttons/links): `alt` describes the action ("Search", not "magnifier") (1.1.1)
- [ ] Complex images (charts): short `alt` + adjacent long description or data table (1.1.1)
- [ ] SVG: `role="img"` + `aria-label` (or `<title>` child) if meaningful; `aria-hidden="true"` + `focusable="false"` if decorative (1.1.1)
- [ ] `<canvas>`: fallback content or equivalent data table (1.1.1)
- [ ] Video: captions (1.2.2 AA), audio description or transcript (1.2.5 AA); audio: transcript (1.2.1)
- [ ] No text rendered inside images when real text suffices (1.4.5)

## 7. Color & contrast

- [ ] Body text ≥ 4.5:1; large text (≥18pt or 14pt bold) ≥ 3:1 (1.4.3)
- [ ] UI components & meaningful graphics ≥ 3:1 (button borders, icon indicators, chart segments) (1.4.11)
- [ ] Focus indicators ≥ 3:1 (1.4.11)
- [ ] Hover/focus/active/disabled states also meet contrast (state colors are easy to miss) (1.4.3)
- [ ] Information never conveyed by color alone — add icon, text, pattern, or underline (1.4.1)
- [ ] Links in body text distinguishable by more than hue (underline is the reliable fix) (1.4.1)
- [ ] Placeholder text contrast checked — it's often too faint (still needs 4.5:1 if it conveys meaning) (1.4.3)
- [ ] Verify in both light and dark themes/modes if both exist (1.4.3)

## 8. Motion & animation

- [ ] `prefers-reduced-motion` honored: disable/reduce parallax, autoplaying video, non-essential transitions (2.3.3 AAA-ish; treat as AA practice)
- [ ] Nothing flashes more than 3×/second (2.3.1 — seizure risk, hard failure)
- [ ] Auto-playing/auto-updating content (carousels, tickers) has pause/stop/hide controls (2.2.2)
- [ ] No content blinking or animating indefinitely that distracts from reading (2.2.2)
- [ ] Animations don't convey exclusive information (e.g. only a shimmer indicates loading) (1.1.1)

## 9. Dynamic content & live regions

- [ ] Status updates that matter announced via `role="status"`/`aria-live="polite"` — toasts, search results, save confirmations (4.1.3)
- [ ] Errors/alerts use `role="alert"` or `aria-live="assertive"` sparingly (4.1.3)
- [ ] Loading states: announce completion, not just "loading" (`aria-busy` during, status on finish) (4.1.3)
- [ ] Live regions exist in DOM before content injected — mount the empty region first, inject text on update (React: keep `<p role="alert">{msg}</p>` mounted, don't render it conditionally with the message) (4.1.3)
- [ ] Don't announce decorative/cosmetic changes (progress bars that update constantly) (4.1.3)
- [ ] Content changes don't shift layout unexpectedly (CLS also a usability issue) (3.2.3)

## 10. Pointer & touch

- [ ] Touch targets ≥ 24×24 CSS px (2.5.8 AA — WCAG 2.2 new; 44×44 is Apple/WCAG-AAA practice)
- [ ] Dragging has a single-pointer alternative (sliders keyboard-editable, drag-sort has buttons) (2.5.7 AA — 2.2 new)
- [ ] Actions fire on up-event or have abort/undo (no accidental triggers on touch-down) (2.5.2)
- [ ] Hover-only content (tooltips, menus) also opens on focus and stays open under pointer (1.4.13)
- [ ] No information trapped in `title=` attributes — hover-only for mouse users; render hints as persistent text via `aria-describedby` (1.3.1)
- [ ] No double-tap/long-press-only interactions without alternatives (2.1.1)

## 11. Text, zoom & reflow

- [ ] 200% text zoom works: no clipped/overlapping content, no fixed-height `overflow:hidden` text (1.4.4)
- [ ] Reflows at 320px width (256px height for landscape) without horizontal scrolling — except tables, maps, code (1.4.10)
- [ ] `em`/`rem`/`%` for text sizing — `px` blocks user font-size settings in some stacks (1.4.4)
- [ ] Text-spacing override survives: users increasing line-height/letter-spacing/word-spacing don't lose content (1.4.12)
- [ ] Works in both orientations; no landscape/portrait lock unless essential (1.3.4)
- [ ] Line length/height reasonable: ~1.5 line-height, no justified walls of text (1.4.8 AAA guidance)

## 12. Navigation & page structure

- [ ] Unique descriptive `<title>` per page/route (2.4.2)
- [ ] Consistent nav order across pages; consistent component identification (3.2.3, 3.2.4)
- [ ] Breadcrumbs/multiple ways to reach pages (2.4.5)
- [ ] `aria-current="page"` on current nav item (4.1.2)
- [ ] Meaningful link text — "Read the report" not "click here" (2.4.4)
- [ ] New-window links/warnings indicated (`target="_blank"` disclosed) (3.2.5)
- [ ] Pagination/filters keep state and announce changes (4.1.3)

## 13. Timing

- [ ] Time limits warn before expiry and allow extension (2.2.1)
- [ ] Session timeouts preserve entered data on re-auth (2.2.5 AAA practice)
- [ ] No time-limited interactions that can't be extended (2.2.1)

## 14. Internationalization & misc

- [ ] Content not dependent on sensory characteristics alone ("the green button on the right") (1.3.3)
- [ ] Abbreviations/jargon expandable (`<abbr>` or inline explanation) (3.1.4 guidance)
- [ ] Reading level appropriate or plain-language summary provided (3.1.5 guidance)
- [ ] If auth involves cognitive tests (CAPTCHA, puzzles), an alternative exists (3.3.8 AA — 2.2 new)
- [ ] Consistent help mechanisms across pages (3.2.6 A — 2.2 new)

## 15. Component libraries & design systems

Auditing code built on a component library (MUI, Radix, shadcn, Chakra, Carbon, Bootstrap, an internal design system) needs two extra passes: don't fight what the library provides, and hunt for the props that activate accessibility.

- [ ] **Don't duplicate built-in behavior.** Library `Modal`/`Dialog` already ships `role="dialog"`, `aria-modal`, focus trap, return-focus; `Menu`/`ComboBox`/`Select` ship keyboard handling, `aria-expanded`, `aria-activedescendant`; notifications ship `role="alert"`/`status`. Adding your own versions duplicates or fights them and breaks assistive tech. Check the library's accessibility docs before adding ARIA to a library component (4.1.2)
- [ ] **A11y-activating props are optional in types but mandatory for output.** Nothing errors when they're missing, so audit usages: icon-only buttons need a name prop (`iconDescription`, `label`, `aria-label`), inputs need `label`/`labelText`, modals need `title`/`modalHeading`, notifications need `title` (4.1.2)
- [ ] **Overrides can silently break a11y.** Custom `className`/`style` on library components can remove focus rings, shrink targets under 24px, or break contrast. Check every style override against §3, §7, §10 (2.4.7, 1.4.3, 2.5.8)
- [ ] **Interactive variants of static components.** A `Tag`/`Badge`/`Card` with an `onClick` or action needs the library's action/name prop or a redesign; clickable-but-inert variants are a common trap (4.1.2, 2.1.1)
- [ ] **Heading composition.** Library `Heading`/`Section` level props must still produce a non-skipped hierarchy when nested and composed (1.3.1)
- [ ] If the library cannot express a pattern, build the custom widget to the generic rules above; the library's a11y coverage ends where its components end

## Static-analysis grep starters

```bash
# suspicious interactive patterns
grep -rn 'onClick=' --include='*.tsx' | grep -v '<button\|<a '   # div/span click handlers
grep -rn 'tabIndex=\{[1-9]'                                     # positive tabindex
grep -rn '<img' | grep -v 'alt='                                # missing alt
grep -rn '<a ' --include='*.tsx' | grep -v 'href'               # anchor without href
grep -rn 'outline:\s*none\|outline-none'                        # killed focus ring
grep -rn 'aria-label\|aria-labelledby' -c                       # named controls coverage
grep -rn 'prefers-reduced-motion'                               # motion respect
grep -rn 'role="dialog"\|aria-modal'                            # modal semantics
```

## Manual test script (5 min per page)

1. Unplug/ignore the mouse. Tab through the page: can you reach everything? Is order sane? Can you see where focus is?
2. Open every overlay (modal, menu, tooltip, dropdown): does Escape close it? Does Tab stay inside? Does focus return on close?
3. Zoom to 200% (⌘+ / browser zoom): is everything still readable and usable?
4. Narrow to 320px: does text reflow without horizontal scroll?
5. DevTools → emulate `prefers-reduced-motion: reduce`: do animations stop?
6. Turn on VoiceOver (⌘F5) or NVDA: listen to nav landmarks, a form, a button group. Are names sensible? Is state announced?
7. Squint test: can you tell links from text? Errors from normal fields? Current nav item?
8. Component states: exercise every state (collapsed/expanded, open/closed, focused, hovered, disabled, error, loading, selected). Regressions hide in non-default states.
