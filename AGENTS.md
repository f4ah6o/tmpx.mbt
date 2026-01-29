# tmpx.mbt AGENTS

This file is the single source of truth for how to reason about, change, and extend
this repository. It captures current behavior and intended design directions so a
new contributor can operate without reading every file.

## Scope and goal

tmpx.mbt is a typed, functional HTML template DSL for MoonBit. The core goal is:
- Type-safe tag/attribute construction that avoids stringly-typed HTML where
  possible.
- Simple, predictable rendering that is safe by default (HTML escaping for text
  and attribute values).
- A small, ergonomic surface for building HTML trees, with optional integration
  for htmx/mhx attributes.

The main design question going forward is how to balance type safety with
conciseness, especially avoiding empty `[]` for attributes/children.

## Current public API (conceptual)

The public API is the set of functions/types exported from the tmpx package
(see `src/tmpx/pkg.generated.mbti` for the authoritative list). The core pieces
are:

### Types
- `Tag` enum: canonical list of supported HTML tags (plus `Custom(String)` for
  extension). See `src/tmpx/tag.mbt`.
- `Attr` enum: attribute representation.
  - `KeyVal(String, String)` for standard attributes.
  - `Bool(String)` for boolean attributes (e.g. `disabled`).
  - `ClassList(Array[String])` for class list with empty strings filtered.
- `Node` enum: HTML tree nodes.
  - `Element(Tag, Array[Attr], Array[Node])`
  - `VoidElement(Tag, Array[Attr])`
  - `Text(String)` (escaped)
  - `Raw(String)` (no escaping)
  - `Fragment(Array[Node])`

### Builders
Builders exist for tags and attributes, mostly as free functions in:
- `src/tmpx/tags.mbt` (e.g. `div(attrs, children)`, `img(attrs)`, `br()`)
- `src/tmpx/attr.mbt` (e.g. `class_`, `id_`, `href`, `data_attr`, `aria`)
- `src/tmpx/htmx.mbt` and `src/tmpx/mhx.mbt` for hx/mx attribute helpers

Naming conventions:
- Trailing underscore for keywords or ambiguous names:
  - `html_`, `style_`, `header_`, `main_`, `input_`, `var_`, `object_`
- Void tags generally take only attributes; some have a zero-arg form (e.g. `br()`).

### Rendering
Rendering is intentionally simple and deterministic:
- `render(node : Node) -> String` renders a single node.
- `render_nodes(nodes : Array[Node]) -> String` concatenates rendering of each node.
- `Text` content is escaped by `escape_html`.
- Attribute values are escaped.
- `Raw` content is inserted without escaping.
- `Tag::is_void` determines whether children are ignored; `Tag::element` forces
  a void tag to become `VoidElement` even if children were provided.

Files:
- `src/tmpx/render.mbt`: implementation
- `src/tmpx/render_test.mbt`: snapshot tests
- `src/tmpx/render_pbt_test.mbt`: property-based tests for escaping

## Supported tags

`Tag` and `tags.mbt` include a large set of HTML elements, including table
(`table`, `thead`, `tbody`, `tfoot`, `tr`, `th`, `td`) and many legacy/obsolete
ones (`applet`, `marquee`, `frameset`, etc.). See:
- `src/tmpx/tag.mbt`: enum and string mapping
- `src/tmpx/tags.mbt`: builders for each tag
- `README.mbt.md`: categorized list

Legacy tags are included for compatibility; they should not be treated as
recommended usage.

## Attribute helpers

Attribute helpers live in `src/tmpx/attr.mbt` and cover common HTML attributes,
plus generic helpers:
- `attr(name, value)` for any attribute
- `bool_attr(name)` for boolean attributes
- `data_attr(name, value)` for `data-*`
- `aria(name, value)` for `aria-*`

htmx/mhx integration is done by returning `Attr` helpers (e.g. `hx_get`, `mx_get`).

## Type safety vs conciseness (design focus)

Current API is type-safe enough to prevent tag name typos and separate attrs from
children, but it is verbose due to repeated `[]` in common cases.

Known limitations:
- Attributes are not type-checked by tag (e.g. `href` on `div` is allowed).
- Void elements ignore children instead of rejecting them.
- Frequent `[]` for attrs/children leads to noisy call sites.

### Design principles for improvements

When evolving the API, prioritize:
1) Backwards compatibility where possible (additive changes are preferred).
2) Consistency across all tags (avoid special cases like `br()` only).
3) Concise call sites for common cases without losing clarity.
4) Minimal magic; prefer explicit functions or optional parameters over clever
   implicit behavior.

### Possible improvements (not yet implemented)

These are candidate directions; choose one and apply consistently:

A) Child-first wrappers with optional attrs (additive)
- Provide a parallel set of functions (or `_`-suffixed variants) that default
  attributes to `[]`:
  - `div_(children : Array[Node], attrs? : Array[Attr] = [])`
  - `img_(attrs? : Array[Attr] = [])`
- Keeps the original `div(attrs, children)` for compatibility.

B) Compact module/package
- Add a `compact` package that re-exports a concise API (child-first) while
  leaving the core API unchanged.

C) Runtime checks for void children
- Reject children on void tags (by `fail`) instead of silently discarding them.
  This improves safety but is a behavioral change.

When implementing, use the smallest changes needed and update snapshot tests.

## Tests and expected style

- Snapshot tests are preferred for rendering outputs.
- Property-based tests (`moonbitlang/quickcheck`) verify escaping rules.
- Add tests for new tags in small, category-focused snapshots.

Commands:
- `moon check`
- `moon test`
- `moon info` (updates `pkg.generated.mbti`)

## File map

Core:
- `src/tmpx/tag.mbt`        Tag enum, string mapping, void detection
- `src/tmpx/tags.mbt`       Tag builder functions
- `src/tmpx/node.mbt`       Node enum and tag helpers
- `src/tmpx/attr.mbt`       Attribute helpers
- `src/tmpx/render.mbt`     Rendering implementation
- `src/tmpx/htmx.mbt`       htmx attributes
- `src/tmpx/mhx.mbt`        mhx attributes

Tests:
- `src/tmpx/render_test.mbt`
- `src/tmpx/render_pbt_test.mbt`

Docs:
- `README.mbt.md`

## How to extend tags

When adding a new tag:
1) Add the `Tag` variant in `src/tmpx/tag.mbt`.
2) Add string mapping in `Tag::to_string`.
3) Update `Tag::is_void` if it is a void tag.
4) Add a builder in `src/tmpx/tags.mbt`.
5) Add a small snapshot test covering it.
6) Run `moon info` to update `pkg.generated.mbti`.
7) Update README tag list if applicable.

## Non-goals

- Full HTML validation or tag/attribute constraint checking at compile time.
- DOM-level semantics (this is a rendering DSL, not a browser model).

