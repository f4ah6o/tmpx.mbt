# tmpx_next AGENTS (Design Spec)

This file is the single source of truth for the tmpx_next design. It defines
what the new package MUST implement and what is intentionally out of scope.

## 0. Goal

Rebuild tmpx as an HTML tree DSL that is:
- Short to write (no user-visible `[]`).
- Safer by type (void elements cannot accept children).
- Immutable and composable (pure updates and diff-friendly transforms).

Compatibility with existing tmpx is NOT required. tmpx_next is a new package.

## 1. Package boundary

- New package name: `tmpx_next` (import path: `f4ah6o/tmpx/tmpx_next`).
- Old package `tmpx` remains unchanged for parallel adoption.

tmpx_next core includes:
- Variadic-style DSL (see Section 3).
- Void/Element node separation.
- AttrSet normalization and deterministic render.
- Immutable update API.

Out of core (separate packages):
- html macro sugar (tmpx_next/macro).
- Stateful builders (tmpx_next/builder).
- HTML validators (tmpx_next/validate).

## 1.1 mhx helpers (mhx-only policy)

- tmpx_next provides **mhx only**; htmx helpers are intentionally omitted.
- mhx helpers are **Attr-only** (no Node construction).
- Official minimal surface: `mx_get`, `mx_post`, `mx_target`, `mx_trigger`,
  `mx_swap` + `MxSwap`.
- htmx users should call `attr("hx-...", "...")` directly as an escape hatch.
- mhx helpers emit `mx-*` attribute names (not `data-mx-*`).

## 2. Core data model (Void separation, Tag unified)

Tag is a single enum. Void-ness is expressed by node type, not by Tag type.
Tag::is_void may exist for validation/rendering, but the API does not expose
children for Void nodes.

### Types (concept)

- `type Attr = ...`
- `enum Tag = ... | Custom(String)`

- `struct ElementNode { tag : Tag, attrs : AttrSet, children : Array[Node] }`
- `struct VoidNode { tag : Tag, attrs : AttrSet }`

- `enum Node {
    Element(ElementNode),
    Void(VoidNode),
    Text(String),      // escaped
    Raw(String),       // unsafe
    Fragment(Array[Node])
  }`

## 3. DSL construction (no `[]` in user API)

### Part model

- `enum Part { PAttr(Attr), PChild(Node), PText(String) }`

### Sugar rules

- `String` => `PText` (always escaped text)
- `Attr`   => `PAttr`
- `Node`   => `PChild`
- `Raw` is explicit (never implicit from String)

### Builders (concept)

- Element builders accept parts:
  - `div_parts(parts : Array[Part]) -> Node` (returns `Node::Element`)
  - `span_parts(parts : Array[Part]) -> Node`
- Void builders accept attrs only:
  - `img_attrs(attrs : Array[Attr]) -> Node` (returns `Node::Void`)
  - `br_attrs(attrs : Array[Attr]) -> Node`

Implementation note:
If MoonBit lacks true variadic arguments, tmpx_next core exposes array-based
builders (e.g. `div_parts(parts : Array[Part])`, `img_attrs(attrs : Array[Attr])`)
and the macro package is responsible for user-facing variadic syntax. The
user-facing API MUST NOT require `[]` in normal usage.

### v1 builder batch (fixed surface)

Element builders:
- `div_parts`, `span_parts`, `main_parts`, `section_parts`, `header_parts`, `footer_parts`
- `p_parts`, `h1_parts`, `h2_parts`, `h3_parts`, `a_parts`
- `form_parts`, `button_parts`, `label_parts`, `ul_parts`, `li_parts`

Void builders:
- `img_attrs`, `br_attrs`, `hr_attrs`, `input_attrs` (void element)

### v2 builder batch (additive)

Element builders:
- `html_parts`, `head_parts`, `body_parts`, `title_parts`, `nav_parts`, `article_parts`, `aside_parts`
- `h4_parts`, `h5_parts`, `h6_parts`, `em_parts`, `strong_parts`, `code_parts`, `pre_parts`
- `figure_parts`, `figcaption_parts`, `video_parts`, `audio_parts`
- `table_parts`, `thead_parts`, `tbody_parts`, `tfoot_parts`, `tr_parts`, `th_parts`, `td_parts`
- `textarea_parts`, `select_parts`, `option_parts`

Void builders:
- `meta_attrs`, `link_attrs`, `source_attrs`

### v3 builder batch (additive)

Element builders:
- `small_parts`, `cite_parts`, `blockquote_parts`
- `dl_parts`, `dt_parts`, `dd_parts`, `ol_parts`
- `details_parts`, `summary_parts`
- `fieldset_parts`, `legend_parts`

Void builders:
- `base_attrs`, `area_attrs`, `col_attrs`, `embed_attrs`, `param_attrs`, `track_attrs`, `wbr_attrs`

### v4 builder batch (additive)

Element builders:
- `kbd_parts`, `mark_parts`, `sup_parts`, `sub_parts`
- `caption_parts`, `colgroup_parts`

### Example (macro-level syntax)

```
let view = div(
  class_("container"),
  id_("main"),
  h1("Title"),
  p("Content"),
  img(src("/logo.png"), alt("Logo"))
)
```

## 4. Normalization rules (compile at build time)

Normalization happens at construction time; internal representation is always
normalized.

### 4.1 Text
- `PText("x")` -> `Node::Text("x")` (escaped on render)

### 4.2 Children
- `PChild(Node)` -> appended to `children`
- `Fragment([...])` inside children is flattened recursively
  - Top-level `Node::Fragment` remains a public type for grouping

### 4.3 AttrSet normalization

AttrSet is the canonical, normalized `Array[Attr]`.
Maps may be used internally for normalization but must not be exposed.

Rules:
- `class`:
  - Empty strings removed
  - Duplicates removed (keep first occurrence)
  - All class values are merged into a single attribute
- `id`:
  - Single attribute only
  - Last occurrence wins
- For other attributes:
  - Single attribute only
  - Last occurrence wins
  - Bool vs KeyVal conflicts follow last-wins

Attribute order is deterministic and fixed:
1) `class` (if present)
2) `id` (if present)
3) the rest sorted by attribute name ascending (lexicographic)

This order is part of the render contract.

## 5. Unsafe custom tags (explicit escape hatch)

- `unsafe_custom_element(name : String, parts : Array[Part]) -> Node`
- `unsafe_custom_void(name : String, attrs : Array[Attr]) -> Node`

These are intentionally labeled unsafe to keep the default API safe.

Prefer tag-specific builders; use attr(name, value) for unknown attributes;
use unsafe_custom_* only for unknown/experimental tags.

## 6. Immutable update API

All updates are pure functions; no mutation is visible to users.

### Common updates (Node -> Node)
- `with_attr(node, attr) -> node'`
- `map_attrs(node, f) -> node'`
- `add_class(node, name) -> node'`
- `set_id(node, value) -> node'`

For `Text/Raw/Fragment`, these are no-ops by default.

### Element-only updates
- `append_children(elem, parts...) -> elem'`
- `prepend_children(elem, parts...) -> elem'`
- `map_children(elem, f) -> elem'`

### Composition
- `wrap(node, tag, attrs...) -> Node`
  - Wraps any node with a new element node.

All updates must return normalized structures.

## 7. Rendering semantics

- Text is escaped by default.
- Raw is inserted verbatim (unsafe by design).
- Void nodes render as `<tag ...>` (no self-closing slash).
- Element nodes render with explicit closing tags.
- Output must be deterministic and reflect AttrSet order.

## 8. Tests

- Snapshot tests grouped by category (small, focused outputs).
- Property-based tests for escaping and AttrSet normalization invariants.
- No reliance on previous tmpx snapshot outputs (new package, new contract).

## 9. Non-goals

- Full HTML validation.
- Compile-time tag/attribute constraints beyond void separation.
- Automatic migration from tmpx.
