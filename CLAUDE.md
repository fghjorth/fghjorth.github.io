# fghjorth.github.io

Personal academic website for Frederik Hjorth, built with [Quarto](https://quarto.org)
and published to GitHub Pages by a GitHub Action.

## How to publish

**Edit a `.qmd` file, commit, push to `master`. That's it.**

The Action renders the site and deploys it — usually live in one to two minutes.
You never run a build yourself and you never commit generated files. If you only
need a small text change (a paper moving from R&R to accepted, a new link), you
can edit the `.qmd` directly in the GitHub web editor from any machine, with
nothing installed.

Pages is configured with **Source: GitHub Actions** (not "deploy from a branch").
If that ever gets switched back to a branch, deploys will silently stop working.

## Layout

| Path | URL |
|---|---|
| `index.qmd` | `/` |
| `publications/index.qmd` | `/publications/` |
| `workingpapers/index.qmd` | `/workingpapers/` |
| `teaching/index.qmd` | `/teaching/` |
| `data/index.qmd` | `/data/` |
| `contact/index.qmd` | `/contact/` |

Each page is a **directory with an `index.qmd`**, not a flat `publications.qmd`.
That is deliberate: Quarto would render a flat file to `/publications.html`, which
would break URLs that appear on the CV and in other people's citations.

## Writing an entry

Publications, working papers, and courses use a two-column grid: a short label in
the left gutter, content on the right. Pandoc wraps loose text in `<p>`, so each
part needs its own fenced div — a bare `[APSR]{.gutter}` span would break the grid.

```markdown
::: {.entry}
::: {.gutter}
APSR [Forthcoming]{.status}
:::
::: {.entry-body}
### Paper title

::: {.meta}
With A. Coauthor · *Journal Name*
:::

![](/img/figure.png)

::: {.abstract}
Abstract text.
:::

::: {.links}
[Published version](https://…) · [Ungated version](/papers/x.pdf)
:::
:::
:::
```

Use `.cite` instead of `.entry` for short one-line citations (see the older
articles in `publications/index.qmd`), and `.deflist-row` with `.key` / `.val` for
the contact page.

The gutter shows **journal abbreviation** for publications and **years** for
courses. It does not show publication years, because most entries don't record
one — if you add years, switch the gutter over.

## Design

`custom.scss` holds the whole design system. Colours are CSS custom properties on
`:root`, redefined under `@media (prefers-color-scheme: dark)` — style through the
tokens, never hardcode a colour in a component rule.

- **Accent** is UCPH red `#901a1e` (`--ku-red` in the university's own stylesheet).
  It sits at ~8:1 on the light ground but only ~2:1 on the dark one, so dark mode
  uses a lightened `#d06a6e` at ~5:1. If you change the accent, check both.
- **Type** is Cormorant Garamond 600 for display, Lora for everything else. The
  site is deliberately all-serif — there is no sans anywhere. Fonts load from
  Google Fonts via `include-in-header` in `_quarto.yml`.

## Do not remove

The `resources:` globs in `_quarto.yml` are load-bearing. Quarto only copies files
that a document references or that are listed there — and the twelve conference
decks at the repo root are referenced by nothing. Without `"*.pdf"` they vanish
from the built site, breaking URLs handed out at talks.

## Local preview (optional)

Only needed for design work; ordinary edits don't require it.

```bash
quarto preview
```

**On this machine (Intel Mac, macOS 12):** Quarto's bundled dart-sass will not
run — it requires macOS 14. A standalone sass is installed at `~/.local/dart-sass`
and Quarto itself at `~/.local/quarto`. Use:

```bash
export QUARTO_DART_SASS=~/.local/dart-sass/sass
~/.local/quarto/bin/quarto preview
```

CI is unaffected — it renders on Ubuntu with the stock toolchain.

## Conference slides

New decks go in the separate **`fghjorth/slides`** repo, which has no build step:
push a PDF and it is live immediately at `fghjorth.github.io/slides/<name>.pdf`.
Keeping them out of this repo means a broken site build can never block a slide
upload before a talk.

The twelve older decks stay at this repo's root so their existing URLs keep working.

## History

This site was a Hugo build whose markdown source was never committed and was
eventually lost, after which pages were hand-edited as raw HTML for four years.
That produced dead links, stale navigation on orphaned pages, and a sitemap frozen
in 2022. Committing the source and letting CI render it is what prevents a repeat —
the built site is now a pure function of this repo.
