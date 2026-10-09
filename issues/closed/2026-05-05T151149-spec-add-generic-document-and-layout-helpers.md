# Add generic document and layout helpers

Created: 2026-05-05

Model: gh-migrate

## Summary

Add generic document and layout helpers

## Original Issue

- [GitHub #3](https://github.com/f4ah6o/tmpx.mbt/issues/3)


## Description

# Add generic document and layout helpers

## Summary

Add thin, generic helpers for common document-level HTML structures.

This is one of the improvements proposed in #1. The goal is to make tmpx more useful as a foundation for SSR, documentation sites, generated pages, and MoonBit web apps without introducing app-specific concepts.

## Motivation

Many tmpx users will need the same document-level patterns:

- HTML document shell
- doctype rendering
- charset / viewport meta tags
- stylesheet links
- canonical URLs
- OGP / Twitter Card metadata

These are generic enough to belong near tmpx, while still avoiding papyr-specific or application-specific abstractions.

## Proposed helpers

```moonbit
doctype_html(node: Node) -> String
html_document(head: Array[Node], body: Array[Node]) -> Node

meta_charset_utf8() -> Node
meta_viewport() -> Node
stylesheet(href: String) -> Node
canonical(href: String) -> Node

og_title(value: String) -> Node
og_description(value: String) -> Node
og_image(value: String) -> Node
twitter_card(value: String) -> Node
```

## Design constraints

- Keep helpers generic.
- Do not introduce papyr-specific concepts.
- Do not introduce full SEO framework behavior.
- Prefer simple helper functions that return `Node`.
- Preserve deterministic rendering.
- Use existing tag builders where possible.

## Suggested tests

- `html_document` renders stable `<html><head>...` and `<body>...` structure
- `doctype_html` prepends `<!doctype html>` deterministically
- meta/link helpers render expected attributes
- OGP helpers render expected `property` / `content` attributes
- helpers compose with existing `render`

## Non-goals

- Full SEO framework
- Site config management
- papyr-specific page model
- Routing
- Asset bundling
