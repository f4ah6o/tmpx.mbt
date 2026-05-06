# Keep papyr-specific rendering APIs outside tmpx core

Created: 2026-05-05

Model: gh-migrate

## Summary

Keep papyr-specific rendering APIs outside tmpx core

## Original Issue

- [GitHub #9](https://github.com/f4ah6o/tmpx.mbt/issues/9)


## Description

# Keep papyr-specific rendering APIs outside tmpx core

## Summary

Define the package boundary between generic tmpx helpers and papyr-specific document rendering helpers.

This follows the proposal in #1. tmpx should provide generic HTML and document-level primitives, while papyr-specific rendering APIs should live in papyr.mbt or an adapter package.

## Motivation

tmpx can become a strong foundation for papyr.mbt without absorbing papyr-specific concepts into tmpx core.

A clean separation keeps tmpx broadly useful for:

- SSR
- generated UI
- Markdown rendering
- documentation pages
- mhx-enabled views
- other MoonBit web applications

At the same time, papyr.mbt can build on tmpx for higher-level document site concerns.

## Proposed boundary

### tmpx.mbt owns generic HTML primitives

Examples:

```text
html_document
stylesheet
canonical
og_title
og_description
og_image
meta_viewport
render
```

### papyr.mbt or adapter package owns document-site concepts

Examples:

```text
doc_page
doc_nav
doc_toc
breadcrumb
related_docs
previous_next_links
doc_relation_links
```

## Suggested package shape

```text
tmpx.mbt
  src/tmpx/
    core HTML DSL
    render
    attrs
    mhx attr helpers

papyr.mbt
  src/papyr_view/
    document layout
    nav rendering
    toc rendering
    doc relation rendering
    page chrome
```

## Design constraints

- Do not add papyr-specific APIs to tmpx core.
- Keep tmpx useful as a standalone package.
- Allow papyr.mbt to use tmpx as its rendering target.
- Keep generic document helpers in tmpx if they apply outside papyr.

## Non-goals

- Moving papyr into tmpx
- Creating a full documentation framework in tmpx
- Adding routing, content loading, or relation graph logic to tmpx
