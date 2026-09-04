# Fluent MedOps report generator

A Fluent MedOps–branded variant of the markdown→PDF engine, built the same way as the
root A CTO generator (Docker + [`md-to-pdf`](https://github.com/simonhaenisch/md-to-pdf) +
Chromium). Branding is baked into the image; point it at any markdown file and it renders
the Fluent MedOps way.

Brand source: **Fluent MedOps Design System** (SharePoint → Marketing → `Fluent MedOps Brand Kit`).
- **Color** — Chart Navy `#0B1F2A`, Signal Teal `#1F8A8A` (only accent), Throughput Lime `#C9E265`
  (gains / fills only, never text), warm Paper `#FAF7F2` / Paper Deep `#F1ECE3`, hairline `#D8D2C7`.
- **Type** — Source Serif 4 (display), Archivo (body/UI), IBM Plex Mono (eyebrows/figures), loaded
  from Google Fonts and embedded in the PDF.
- **Rules honored** — flat fills (no gradients), no shadows, no colored left-border strips (a 3px
  teal *top* rule marks columns/callouts), sentence case, no emoji, type-only wordmark.

## Build

```bash
docker build -t fluent-medops-report-generator ./fluent-medops
```

Base layers (node:20-slim + Chromium + md-to-pdf) are shared with the root A CTO image, so a
first build after that one is fast.

## Render

Mount the directory that holds your markdown; pass the basename and an output basename.

```bash
# Linux / macOS
docker run --rm -v "$(pwd):/data" fluent-medops-report-generator input.md output.pdf

# Windows (Git Bash) — use the //c/ mount form
docker run --rm -v "//c/path/to/docs:/data" fluent-medops-report-generator input.md output.pdf
```

The input directory is mounted read/write at `/data`; the PDF is written back beside the source.

## Authoring notes

- Fonts load over the network at render time (the `stylesheet` array pulls Google Fonts, and
  md-to-pdf waits on `document.fonts.ready`), so the container needs internet during a render.
  Self-hosting the three font families is the one known gap — swap in `@font-face` binaries for
  fully offline/print-deterministic output.
- The running header/footer templates can't load web fonts (a Puppeteer limitation), so the header
  wordmark falls back to a serif stack — that's expected; the document body carries the real faces.
- Author structured pieces (masthead, callouts, tables, question lists) as HTML in the markdown so
  the brand classes in `templates/fluent-medops.css` apply; prose can stay plain markdown.

## Files

| File | Purpose |
| --- | --- |
| `Dockerfile` | Same base as the A CTO engine; copies the config, templates, entrypoint. |
| `entrypoint.sh` | Derives the doc title from the first `# H1` (else filename) and runs md-to-pdf. |
| `pdf-config.js` | Page/margins, Fluent MedOps header & footer templates, Google-Fonts + brand stylesheet. |
| `templates/fluent-medops.css` | The brand stylesheet — palette, type, cards, tables, callouts, questions. |
