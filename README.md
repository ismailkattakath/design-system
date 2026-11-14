# Duochrome

A two-value design system: pure black ink, pure white ground, nothing between.
Typography is Roboto across its six shipped weights, with Roboto Mono for
labels, metadata and code.

## The laws

1. **Black or white.** Ink `#000000`, ground `#FFFFFF`. No greys, no tints, no
   opacity below 1, no shadows, no coloured links. A surface may invert
   wholesale; it may never sit halfway.
2. **Roboto, as shipped.** Thin 100 / Light 300 / Regular 400 / Medium 500 /
   Bold 700 / Black 900. Never synthesised, stretched or outlined.
3. **Case is the third axis.** Uppercase carries structure (labels, eyebrows,
   nav, running heads); sentence case carries meaning (headlines, body). Never
   a paragraph in caps.

## Devices

With no colour available, state is carried by four devices only:

| Device | Used for |
| --- | --- |
| Inversion | hover, selected, primary |
| Rule weight (1 / 2 / 4 / 12px) | divide, group, alarm, punctuate |
| 45° hatch (≥3px) | disabled, empty, uncommitted |
| Case + weight | emphasis, error text, labels |

## Graphics

Charts, diagrams, loaders and placeholders are drawn in characters on a
monospace grid — a dotted ASCII box, never a vector illustration. Density
(`░ ▒ ▓ █`) replaces a colour scale; `·` is the only empty-track glyph. Bars
run on a 20-cell track where 20 cells = 100.

Icons are characters in Roboto Mono, never an icon library.

## Motion

No fades — opacity passes through every forbidden grey. Change happens by
inversion, rule growth, character stepping or clip only. 120ms UI / 240ms page,
linear or `steps()`. Inversion itself is instant: a colour transition between
ink and ground is a fade too, so hover and focus swap with no transition.

## Accent (optional)

One hue, four jobs: destructive, error, live, key data point. Signal red
`#E4002B` (oklch 0.58 0.23 27), no tints, ≥16px type, ≤1% of any surface.
Remove the red and the layout must still work.

## Usage

```html
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Roboto+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="duochrome.css">
```

```html
<button class="dc-btn dc-btn--fill">Deploy</button>
<section class="dc-invert"> … inverted surface … </section>
```

## Files

- `duochrome.css` — tokens, resets, component classes
- `CHANGELOG.md` — versions

## Known gaps

Responsive rules (everything is specified at 1440px), compact density for
data-heavy screens, a real screen-reader audit of hatch-as-disabled, validation
patterns beyond a single field, skeleton states, and data viz beyond ~20 points.
