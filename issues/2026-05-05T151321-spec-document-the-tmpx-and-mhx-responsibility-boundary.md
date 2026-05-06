# Document the tmpx and mhx responsibility boundary

Created: 2026-05-05

Model: gh-migrate

## Summary

Document the tmpx and mhx responsibility boundary

## Original Issue

- [GitHub #6](https://github.com/f4ah6o/tmpx.mbt/issues/6)


## Description

# Document the tmpx and mhx responsibility boundary

## Summary

Document the intended responsibility boundary between tmpx.mbt and mhx.mbt.

This follows the proposal in #1. tmpx should remain focused on static HTML tree construction and deterministic rendering, while mhx owns client-side hypermedia behavior.

## Motivation

tmpx currently provides `mx-*` attribute helpers. This is useful, but the boundary should be explicit so tmpx does not gradually become a client runtime or duplicate mhx behavior.

A clear boundary helps users understand how to compose both libraries:

- tmpx builds the HTML tree
- tmpx renders deterministic HTML
- tmpx exposes small `mx-*` attribute helpers
- mhx executes client-side hypermedia behavior

## Proposed README wording

```markdown
tmpx.mbt owns static HTML tree construction and deterministic rendering.
mhx.mbt owns client-side hypermedia execution.

tmpx only exposes `mx-*` attribute helpers. It does not construct, configure, or execute the mhx runtime.
```

## Design constraints

- Keep mhx helpers Attr-only.
- Do not add runtime behavior to tmpx.
- Do not add htmx-specific helpers.
- Keep `attr("hx-...", "...")` as the escape hatch for htmx users.
- Keep tmpx usable without mhx.

## Suggested tests / docs checks

- README has a dedicated mhx integration section.
- mhx helper examples use only Attr construction.
- docs clarify that tmpx does not execute client behavior.
- docs clarify that tmpx can be used independently of mhx.

## Non-goals

- Implementing mhx runtime behavior
- Adding browser-side DOM patching to tmpx
- Adding htmx helper surface
- Making mhx a hard dependency for basic tmpx usage
