# Add immutable Node update APIs

Created: 2026-05-05

Model: gh-migrate

## Summary

Add immutable Node update APIs

## Original Issue

- [GitHub #2](https://github.com/f4ah6o/tmpx.mbt/issues/2)


## Description

# Add immutable Node update APIs

## Summary

Add immutable post-construction transformation helpers for `Node` trees.

This is one of the core improvements proposed in #1. It turns tmpx from a construction-only HTML DSL into a composable View tree transformation layer.

## Motivation

Current tmpx usage is centered on constructing HTML trees and rendering them deterministically. For layout composition, generated UIs, documentation pages, and mhx-enabled views, it is useful to transform an already-created `Node` without rebuilding the entire tree manually.

This is especially useful for:

- wrapping page content with layouts
- injecting navigation or breadcrumbs
- adding classes / ids from higher-level components
- generated UI post-processing
- snapshot-friendly view transformations

## Proposed API

Add helpers such as:

```moonbit
with_attr(node: Node, attr: Attr) -> Node
map_attrs(node: Node, f: (Array[Attr]) -> Array[Attr]) -> Node
add_class(node: Node, class_name: String) -> Node
set_id(node: Node, id: String) -> Node

append_child(node: Node, child: Node) -> Node
prepend_child(node: Node, child: Node) -> Node
map_children(node: Node, f: (Array[Node]) -> Array[Node]) -> Node

wrap(node: Node, wrapper: (Node) -> Node) -> Node
```

## Behavior notes

- All APIs should be immutable.
- Attribute updates should reuse existing AttrSet normalization rules.
- Void nodes must not gain children.
- `Text`, `Raw`, and `Fragment` behavior should be explicit and tested.
- Output must remain deterministic.

## Suggested tests

- adding a class preserves existing classes and dedupes via normalization
- setting id follows existing last-wins semantics
- appending children works for element nodes
- appending children to void nodes is rejected or becomes a no-op by explicit design
- mapping attrs preserves deterministic render order
- wrapping a node produces stable output

## Non-goals

- Mutable builders
- Full HTML validation
- Diffing or virtual DOM behavior
- Runtime DOM patching
