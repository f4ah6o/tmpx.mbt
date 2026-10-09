# Add focused examples for common tmpx use cases

Created: 2026-05-05

Model: gh-migrate

## Summary

Add focused examples for common tmpx use cases

## Original Issue

- [GitHub #7](https://github.com/f4ah6o/tmpx.mbt/issues/7)


## Description

# Add focused examples for common tmpx use cases

## Summary

Add small examples that demonstrate tmpx usage in realistic scenarios.

This follows the proposal in #1. The examples should make tmpx's value easier to understand without requiring users to infer intended usage from tests or implementation details.

## Motivation

README already shows basic element construction and rendering. Additional examples would help communicate tmpx's practical role as a deterministic HTML view layer.

Examples are especially useful for:

- new users learning the API
- consumers evaluating tmpx for SSR
- generated UI workflows
- documentation rendering
- mhx integration
- golden snapshot testing

## Proposed examples

```text
examples/
  basic_page/
  form_post/
  mhx_counter/
  docs_page/
  golden_snapshot/
```

## Example scope

### `basic_page`

Shows a minimal HTML page with layout and content.

### `form_post`

Shows form construction with labels, inputs, button, boolean attrs, and deterministic rendering.

### `mhx_counter`

Shows how tmpx emits `mx-*` attributes without owning the mhx runtime.

### `docs_page`

Shows a documentation page layout with title, nav, article body, and code block.

This should remain generic and should not depend on papyr-specific APIs.

### `golden_snapshot`

Shows how deterministic rendering can be used for snapshot / golden tests.

## Design constraints

- Keep examples small.
- Prefer stable output.
- Avoid app-specific configuration.
- Avoid depending on papyr.mbt.
- Do not introduce runtime behavior into tmpx examples except as static attributes.

## Non-goals

- Full demo application
- Router
- Asset bundler setup
- Browser-side runtime implementation
