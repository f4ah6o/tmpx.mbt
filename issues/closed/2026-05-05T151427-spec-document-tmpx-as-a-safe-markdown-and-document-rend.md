# Document tmpx as a safe Markdown and document rendering target

Created: 2026-05-05

Model: gh-migrate

## Summary

Document tmpx as a safe Markdown and document rendering target

## Original Issue

- [GitHub #8](https://github.com/f4ah6o/tmpx.mbt/issues/8)


## Description

# Document tmpx as a safe Markdown and document rendering target

## Summary

Document tmpx as a suitable rendering target for Markdown ASTs and document-oriented content pipelines.

This follows the proposal in #1. tmpx's default escaping, explicit Raw boundary, deterministic output, and broad HTML builder coverage make it a good target for documentation rendering.

## Motivation

A Markdown or document renderer often needs to map parsed structure into HTML while keeping untrusted text safe by default.

tmpx fits this use case because:

- text nodes escape by default
- raw HTML is explicit
- rendered output is deterministic
- builders cover common document tags
- output can be snapshot-tested
- the tree can compose with layouts and navigation

## Proposed README section

```markdown
## Use case: Markdown / document rendering

tmpx is suitable as a safe rendering target for Markdown or documentation ASTs.
A renderer can map trusted structural nodes to tmpx elements while keeping user text escaped by default.

Raw HTML should only be inserted through explicit Raw nodes and only for trusted content.
```

## Suggested example mapping

```text
Markdown heading -> h1_parts / h2_parts / ...
Markdown paragraph -> p_parts
Markdown emphasis -> em_parts
Markdown strong -> strong_parts
Markdown inline code -> code_parts
Markdown code block -> pre_parts + code_parts
Markdown link -> a_parts + href
Markdown image -> img_attrs + src + alt
Markdown list -> ul_parts / ol_parts / li_parts
Markdown table -> table_parts / thead_parts / tbody_parts / tr_parts / th_parts / td_parts
```

## Suggested tests / docs checks

- README includes the document rendering use case.
- Example uses `text` or `part_text` for user content.
- Example avoids `raw()` for untrusted Markdown content.
- Example output is deterministic.

## Non-goals

- Implementing a Markdown parser in tmpx core
- HTML sanitization
- Full document site framework
- papyr-specific rendering APIs
