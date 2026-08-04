# Building with Duochrome

Duochrome is a **CSS-class design system**, not a React component library. There
are no importable components — you style your own native elements (`<button>`,
`<input>`, `<table>`, `<div>`…) by applying `dc-*` classes. The look ships
entirely in `styles.css`. `window.Duochrome` is intentionally empty.

## Setup — one stylesheet, no provider

Load `styles.css` once at the app root. It `@import`s the self-hosted Roboto +
Roboto Mono fonts and the real component CSS; nothing else is required — no
provider, no theme object, no wrapper.

```jsx
import "./styles.css"; // fonts + all dc-* classes
export default function App() {
  return <button className="dc-btn dc-btn--primary">Deploy</button>;
}
```

If text renders in a system sans instead of Roboto, `styles.css` (or its font
`@import`) didn't load — fix that first; every law below assumes Roboto.

## The three laws (do not break these)

1. **Black or white only.** Ink `#000`, ground `#fff`. Never introduce a grey,
   tint, sub-1 opacity, shadow, gradient, rounded corner, or coloured link — the
   CSS already forces `border-radius:0` and `box-shadow:none` globally. State is
   carried by the four devices below, never by colour.
2. **Roboto as shipped**, weights 100/300/400/500/700/900; Roboto Mono for
   labels, metadata, code. Never synthesise or stretch.
3. **Case is the third axis.** UPPERCASE carries structure (labels, eyebrows,
   nav) — use `dc-label`/`dc-meta`. Sentence case carries meaning (headlines,
   body). Never set a paragraph in caps. (`dc-*` label/button classes uppercase
   themselves in CSS — write sentence case in your markup.)

## The four state devices (these replace colour)

| Device | How | Use for |
|---|---|---|
| **Inversion** — `dc-invert` | flips a whole surface to ink ground / white ink; nested `dc-btn`/`dc-chip` re-key automatically | hover, selected, primary, loud panels |
| **Rule weight** — `var(--rule-hair 1px / --rule-base 2px / --rule-loud 4px / --rule-bar 12px)` | grow a border, never tint it | divide / group / alarm+error / one deliberate bar |
| **45° hatch** — `background: var(--hatch)` (or `--hatch-inv`) | native `[disabled]` already paints it | disabled, empty, uncommitted |
| **Case + weight** | mono uppercase + Bold | emphasis, error text, labels |

## Class vocabulary (real names — all defined in `_ds_bundle.css`)

- **Type**: `dc-display` `dc-h1` `dc-h2` `dc-h3` `dc-lead` `dc-body` `dc-small` `dc-label` `dc-meta`
- **Button** (`<button>`/`<a>`): `dc-btn` + `dc-btn--primary` | `dc-btn--text` + `dc-btn--sm` | `dc-btn--lg`; set native `disabled` for the hatch
- **Fields**: `dc-field` wrapper · `dc-input` `dc-select` `dc-textarea` · `dc-input--error` + `dc-error` message
- **Chips**: `dc-chip` · `dc-chip--on`
- **Surfaces**: `dc-card` (+ `dc-card--hover`) · `dc-row` · `dc-modal` · `dc-toast` · `dc-empty` · `dc-section-head`
- **Table**: `dc-table` · `dc-num` (right-aligned mono figures)
- **Foundation**: `dc-invert`
- **Optional accent**: signal red `#E4002B` only for destructive / error / live / a single key data point — ≥16px, ≤1% of a surface. The layout must still work with the red removed.

## Where the truth lives

`styles.css` → `_ds_bundle.css` is the entire, real stylesheet — read it before
inventing anything. Each component's `components/<group>/<Name>/<Name>.prompt.md`
has a copy-ready usage snippet. When you need a class that isn't listed above,
compose the primitives (rules, hatch, inversion, mono labels) rather than adding
a colour or a new visual style.

## One idiomatic snippet

```jsx
import "./styles.css";

function DeployRow() {
  return (
    <a className="dc-row" href="#" style={{ gridTemplateColumns: "1fr auto auto" }}>
      <span>checkout-api</span>
      <span className="dc-chip dc-chip--on">prod</span>   {/* inverted = active */}
      <span className="dc-num">142 ms</span>              {/* mono, right-aligned */}
    </a>
  );
}
```
