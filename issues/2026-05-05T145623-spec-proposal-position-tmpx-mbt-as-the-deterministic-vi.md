# Proposal: Position tmpx.mbt as the deterministic View contract layer for MoonBit web apps

Created: 2026-05-05

Model: gh-migrate

## Summary

Proposal: Position tmpx.mbt as the deterministic View contract layer for MoonBit web apps

## Original Issue

- [GitHub #1](https://github.com/f4ah6o/tmpx.mbt/issues/1)


## Description

# Proposal: Position tmpx.mbt as the deterministic View contract layer for MoonBit web apps

## Summary

tmpx.mbt already provides a typed, functional, deterministic HTML DSL with explicit unsafe boundaries and mhx attribute helpers.

This proposal raises tmpx from a template helper library to a stable View contract layer for MoonBit web applications, documentation sites, and generated UIs.

## Motivation

tmpx has several properties that make it valuable beyond ordinary string templating:

- typed tag / attribute construction
- void element safety by API shape
- deterministic rendering
- default text escaping
- explicit Raw unsafe boundary
- AttrSet normalization
- mhx-only attribute integration

These are especially useful for:

- golden file tests
- static documentation generation
- Markdown / document rendering
- generated UI regression testing
- papyr.mbt page rendering
- mhx.mbt hypermedia integration

## Proposed improvements

### 1. Implement immutable update APIs

Add post-construction transformation helpers:

- `with_attr`
- `map_attrs`
- `add_class`
- `set_id`
- `append_child`
- `prepend_child`
- `map_children`
- `wrap`

This enables layout composition, page wrapping, navigation injection, and generated UI transforms without rebuilding the whole tree manually.

### 2. Add document/layout helpers

Add thin helpers for common document-level HTML:

- `html_document`
- `doctype_html`
- `meta_charset_utf8`
- `meta_viewport`
- `stylesheet`
- `module_script`
- `canonical`
- `og_title`
- `og_description`
- `og_image`
- `twitter_card`

These should remain generic and not depend on papyr-specific concepts.

### 3. Clarify Raw safety boundary

Document that `raw()` is only for trusted HTML.

Potential API refinement:

- keep `raw()` as-is, or
- add `raw_trusted_html()` / `raw_unsafe()` aliases to make the boundary more visible.

### 4. Expand attribute helpers

Add common helpers:

- `role`
- `aria`
- `data`
- `type_`
- `name_`
- `value_`
- `method`
- `action`
- `placeholder`
- `required`
- `disabled`
- `checked`
- `selected`

The goal is not full HTML validation, but better ergonomics for common UI construction.

### 5. Document the tmpx / mhx boundary

Clarify:

- tmpx owns static HTML tree construction
- mhx owns client-side hypermedia behavior
- tmpx only provides `mx-*` Attr helpers
- tmpx does not construct or execute mhx runtime behavior

### 6. Add examples

Suggested examples:

- `examples/basic_page`
- `examples/form_post`
- `examples/mhx_counter`
- `examples/docs_page`
- `examples/golden_snapshot`

The docs page example can demonstrate how papyr.mbt could use tmpx as its rendering target.

## Non-goals

- Full HTML validation
- Replacing mhx.mbt
- Adding htmx-specific helpers
- Adding papyr-specific APIs to tmpx core
- Allowing implicit raw HTML from String

## Expected outcome

tmpx becomes the stable MoonBit View layer for:

- SSR
- documentation rendering
- generated UI
- mhx-enabled hypermedia views
- deterministic snapshot-tested HTML output
