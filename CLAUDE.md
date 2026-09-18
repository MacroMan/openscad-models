# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo overview

Personal collection of OpenSCAD models (3D-printable and CAD utility parts) by David Wakelin. Licensed under CC BY-SA 4.0.

## Printer

Creality K2. Specs: see `~/.claude/skills/openscad-bosl2/references/printers.md`.

## Setup

```
git submodule update --init
```

Library submodules (do not edit directly — vendored):
- `BOSL2` — primary library used for new models (anchors, attachments, rounding, etc.)
- `MCAD`, `NopSCADlib`, `dotSCAD`, `threads-scad` — legacy/occasional-use libraries pulled in by specific models

## Building / previewing

No build step — `.scad` files are opened directly in OpenSCAD, or rendered/checked via the `openscad-bosl2` skill's tools (`openscad-check`, `openscad-render`, `openscad-show`, `openscad-pack-3mf`). Use those tools rather than invoking the raw `openscad` CLI when the skill is available.

## Structure

- `models/` — individual parts, either a single `.scad` file or a subdirectory (with its own README/images) for parts with multiple files
- `modules/` — reusable component modules meant to be `include`d by models (e.g. connector/component shapes)
- `scripts/` — shared helpers, not standalone models:
  - `print-resolution.scad` — sets `$fa`/`$fs` for print-quality rendering
  - `transformations.scad` — translation/rotation helper functions (`translateX/Y/Z`, `rotateX/Y/Z`)
  - `common.scad` — shared globals, `include`d by all models (see Conventions below)
- `images/` — reference renders used in the top-level README

## Conventions

- New models should follow the `openscad-bosl2` skill's house style (BOSL2 primitives, explicit anchors, Customizer parameters, `epsilon`/`layer_height`/`$fn` hidden baselines) — see that skill for the full spec.
- Diameter parameters in existing models (e.g. hose adapters) refer to *inside* diameter unless stated otherwise.
- Every model includes `scripts/common.scad` unless a model has a specific reason not to. It defines:
  - `$fa` — auto-adjusts for preview vs. render (`$preview ? 12 : 1`)
  - `$fs`
  - `$slop`
  - `fn` — for manual curve-building (arrays/loops), not OpenSCAD's built-in `$fn`
  - `_epsilon` — the z-fighting offset for `difference()` cutters
  - Use `_epsilon` (not a locally-defined `epsilon`) for this purpose everywhere.
  - Don't redefine any of these values in a model — only override when the model genuinely needs a different value, and say why.
