# Duochrome design-sync notes

## What this repo is (and why the sync is off-script)

Duochrome is a **CSS-only design system** — a single hand-authored
`duochrome.css` of `dc-*` classes applied to native HTML. There is **no npm
package, no `package.json`, no `dist/`, no React**. The design-sync converter
(`package-build.mjs`) bundles a compiled JS `dist/` into `_ds_bundle.js`; with no
JS to bundle it cannot run here (`[NO_DIST]` / `[ZERO_MATCH]`). So the upload is
**hand-produced** into `ds-bundle/`, matching the upload contract by hand:

- `styles.css` → `@import`s `fonts/fonts.css` then `_ds_bundle.css`. This import
  closure is the entire look a rendered design receives.
- `_ds_bundle.css` = **verbatim** `duochrome.css` (the source of truth — never
  rewritten).
- `_ds_bundle.js` = honestly empty (`window.Duochrome={}`, `components:[]`). No
  importable components exist; cards register from each `.html`'s `@dsCard` line.
- `components/<Group>/<Name>/` → `<Name>.html` (self-contained preview card:
  real `dc-*` markup + `../../../styles.css`, no React/`_vendor`), `<Name>.prompt.md`
  (usage ref), `<Name>.d.ts` (documents the class API — not a React props type).
- `fonts/` → self-hosted Roboto + Roboto Mono **variable** woff2 + `fonts.css`.
- `_ds_sync.json` → off-script content-hash anchor (`shape:"css-manual"`).

## Component taxonomy (13, hand-chosen from duochrome.css)

Foundations: Typescale, Inversion, StateDevices · Actions: Button · Forms: Field
· Data: Table, Chip · Surfaces: Card, ListRow, Modal, Toast, EmptyState,
SectionHeader. Groups map to the `@dsCard group="…"` value on each card.

## How to reproduce the build (scratchpad scripts drove it)

1. Fonts: fetch Google Fonts css2 with a Chrome UA (→ woff2), dedupe to one
   variable file per family, write `fonts/fonts.css` with `font-weight` ranges.
2. `cp duochrome.css ds-bundle/_ds_bundle.css`; write `styles.css` + empty
   `_ds_bundle.js` (with the `/* @ds-bundle: {…} */` header).
3. Generate the 13 component dirs (`.html`/`.prompt.md`/`.d.ts`).
4. Render + eyeball every `.html`. **No playwright/chromium here** — used the
   installed **Google Chrome.app** headless: `--headless=old` (NOT `=new`, which
   hangs), local `file://` URLs with the **`ds-bundle/` prefix** (two renders
   failed to `ERR_FILE_NOT_FOUND` from a dropped prefix), poll for the PNG then
   `kill -9` (Chrome hangs on teardown after writing the screenshot).
5. Generate `README.md` (= `.design-sync/conventions.md` header + component
   index) and `_ds_sync.json`.

## Known render warns

None — all 13 cards render fully styled and graded `good`.

## Re-sync risks (what a future run must watch)

- **No converter / no automated verify.** Everything here is hand-produced. A
  re-sync must NOT expect `package-build.mjs`/`resync.mjs` to work — re-run the
  scratchpad-style generators (or equivalent) and re-render the cards.
- **`_ds_sync.json` is off-script** (`shape:"css-manual"`). `resync.mjs` won't
  read it. It exists so a human/agent can diff content hashes (esp.
  `duochrome.css`) to see what changed. If `duochrome.css` changes, re-copy it to
  `_ds_bundle.css`, re-render affected cards, regenerate README + anchor.
- **Fonts are pinned Google Fonts variable woff2** fetched at build time. Roboto
  v51+ ships one variable file per family; if Google changes the endpoint the
  fetch script may need adjusting. The `@font-face` uses weight *ranges*
  (`100 900`, `400 700`), so the CSS's specific weights all resolve from it.
- **Accent `#E4002B`** is documented as optional and is NOT in `_ds_bundle.css`
  (matches the DS's own README — it's an opt-in accent layer). If the DS ever
  ships accent CSS, add it and update the conventions header.
- **Card chrome CSS** (padding/flex in each `.html`'s `<style>`) is layout
  scaffolding only, never DS look — keep it that way so cards prove `styles.css`.
- **Preview cards use no `_vendor/React`** by design (CSS system). Don't add the
  React vendor unless a card genuinely needs to render a JS component (none do).
