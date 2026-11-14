# Changelog

## 1.1.0 — 2026-11-14

Folds back the refinements proven on ismail.kattakath.com. Additive: every 1.0.0
token and class still exists.

- `.dc-btn--fill` — the filled button, opposite of its surface (ground-filled on
  `.dc-invert`). `.dc-btn--primary` stays as an alias.
- Buttons: `display: inline-block`, no underline, `:focus-visible` matches `:hover`,
  44px minimum height on coarse pointers; `--text` padding 12px 4px.
- Chips 13px with 6px 10px padding; `.dc-meta` 13px with tabular numerals.
- `.dc-num` is now the bare numeral primitive (mono, bold, tabular). The 1.0.0
  table sizing (14px, right-aligned) moved to `.dc-table .dc-num`.
- Tables: body `th` in sans, `thead th` as a mono label, `caption` style,
  `.dc-table-wrap` (framed, scrollable, mono "scroll" cue under 620px).
- `.dc-section-head` wraps with a 12px gap.
- `"Roboto Fallback"`: a metric-matched Arial face (no font file) in `--font-sans`.
- Spacing tokens `--s5`, `--s10`, `--s12`, `--s20` (the rule is `--sN = N x 4px`).
- `.dc-sr-only`, a `prefers-reduced-motion` reset, `img, svg { max-width: 100% }`.
- Links invert on `:focus-visible` as well as `:hover`.
- No colour transitions, by design: an animated inversion passes through greys.

## 1.0.0 — 2026-08-04

Initial release.

- Two-value palette, Roboto weight ladder, case-as-third-axis rules
- 4px base unit, 12-column grid, 64px page margin
- State vocabulary: inversion, rule weight, hatch, case + weight
- Components: buttons, fields, chips, cards, list rows, tables, modal, toast,
  empty state, code block, section headers
- Dot-matrix (ASCII box) graphics convention: density ramp, 20-cell bar track
- Character glyph set (24 glyphs) in place of an icon library
- Motion spec (no fades) and print spec (hatch spacing, inverted-type minimums)
- Optional signal-red accent layer, `#E4002B`
