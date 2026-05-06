# tmpx.mbt
<!-- bdg:begin -->
[![moonbit](https://img.shields.io/badge/moonbit-f4ah6o/tmpx-informational)](https://mooncakes.io/docs/f4ah6o/tmpx)
<!-- bdg:end -->

Typed, functional, deterministic HTML view DSL for MoonBit.

## Features

- **Type-safe tag/attribute construction** - avoid stringly-typed HTML where possible
- **Functional composition** - build views from pure, immutable functions
- **Immutable node transforms** - update attrs, children, and wrappers without rebuilding trees
- **Deterministic rendering** - normalized attributes with fixed order
- **Void safety by API shape** - void elements cannot accept children
- **Document helpers** - generate `<html>`, metadata, links, and module scripts with small helpers
- **mhx-only helpers** - explicit attribute helpers for mx-* integration

## Installation

Add to your `moon.pkg`:

```moon
import {
  "f4ah6o/tmpx/tmpx" as @tmpx
}
```

## Status: Beta (breaking changes from legacy tmpx)

Beta means the API is usable and tested, but builder coverage may still expand; breaking
changes are unlikely but possible before 1.0.

**Contract (frozen in beta):**
- Supported surface = published builder batches (see `src/tmpx/AGENTS.md`)
- Determinism: AttrSet normalization + fixed attribute order + void rendering as `<tag ...>`
- Safety boundary: Text escapes by default; Raw is explicit unsafe
- mhx-only helpers; macro sugar is deferred

**Adoption notes:**
- Start with v1 builders + common v2 tags; request new builder batches as needed.
- Deferred areas: `svg`, `math`, `canvas`, and general `script` / `style` builders.
- Thin document helpers such as `module_script("/app.js")` are available without widening tmpx into a general script DSL.
- Have feedback? See `src/tmpx/FEEDBACK.md`.

## Basic Usage

### Creating Elements

```mbt
// A div with class/id and content
let card = div_parts([
  part_attr(class_("card")),
  part_attr(id_("main")),
  part_child(h1_parts([part_text("Title")])),
  part_child(p_parts([part_text("Body")]))
])

// Render to HTML string
let html = render(card)
// <div class="card" id="main"><h1>Title</h1><p>Body</p></div>
```

### Form Example

```mbt
let form = form_parts([
  part_attr(attr("action", "/submit")),
  part_attr(attr("method", "post")),
  part_child(label_parts([
    part_attr(attr("for", "name")),
    part_text("Name:")
  ])),
  part_child(input_attrs([
    attr("type", "text"),
    attr("name", "name"),
    bool_attr("required")
  ])),
  part_child(button_parts([part_text("Send")]))
])
let html = render(form)
```

### Text / Raw / Fragment

```mbt
let node = fragment([
  text("Hello "),
  raw("<b>World</b>")
])
render(node)
// Hello <b>World</b>
```

## Safety Boundary

`text()` and `part_text()` always escape HTML. Attribute values are escaped on render.

`raw()` is for trusted HTML only. Do not pass user-generated content to `raw()`.
Use `text()` / `part_text()` for untrusted content.

If you want the danger to be visible at the callsite, tmpx also exposes:

```mbt
raw_trusted_html("<b>trusted</b>")
raw_unsafe("<b>unsafe</b>")
```

## Attribute Helpers

```mbt
class_("container")
class_list(["a", "b"])
id_("main")
href("/page")
src("/image.png")
alt("Logo")
role("navigation")
aria("label", "Main navigation")
data("doc-id", "intro")
type_("email")
name_("email")
value_("hello")
action("/submit")
method_("post")
placeholder("you@example.com")
required()
disabled()
checked()
selected()
attr("data-id", "123")
bool_attr("required")
```

For any other attribute, use `attr(name, value)`.

## Immutable Node Updates

tmpx can update already-built trees without mutating the original value:

```mbt
let page = div_parts([part_text("Body")])
let framed = wrap(
  set_id(add_class(page, "card elevated"), "main"),
  fn(node) { section_parts([part_attr(class_("frame")), part_child(node)]) },
)
```

Available helpers:

- `with_attr`, `map_attrs`
- `add_class`, `set_id`
- `append_child`, `prepend_child`, `map_children`
- `wrap`

## mhx Integration (mx-*)

```mbt
mx_get("/api/data")
mx_post("/api/create")
mx_target("#pane")
mx_trigger("click")
mx_swap(InnerHTML)
```

tmpx owns static HTML tree construction and deterministic rendering.
mhx owns client-side hypermedia execution.

tmpx only exposes `mx-*` attribute helpers. It does not configure or execute the mhx runtime,
and it remains usable without mhx.

## Generic Document Helpers

```mbt
let document = doctype_html(
  with_attr(
    html_document(
      [
        meta_charset_utf8(),
        meta_viewport(),
        title_parts([part_text("Docs")]),
        canonical("https://example.com/docs"),
        stylesheet("/site.css"),
        module_script("/app.js"),
      ],
      [main_parts([part_text("Hello")])],
    ),
    attr("lang", "en"),
  ),
)
```

Additional metadata helpers:

- `og_title`
- `og_description`
- `og_image`
- `twitter_card`

These helpers stay generic. They do not add papyr-specific page, nav, or relation APIs to tmpx core.

## Supported Tags

Supported tags are defined by the published builder batches (v1–v8) in `src/tmpx/AGENTS.md`.
Use `unsafe_custom_*` only for experimental/custom elements.

## Rendering

```mbt
render(node) -> String
```

## Use cases

### Markdown / document rendering

tmpx is a safe rendering target for Markdown or documentation ASTs.
A renderer can map trusted structural nodes to tmpx elements while keeping user text escaped by default.
Only insert raw HTML through explicit `Raw` helpers, and only for trusted content.

Typical mappings:

- heading -> `h1_parts` / `h2_parts`
- paragraph -> `p_parts`
- emphasis / strong -> `em_parts` / `strong_parts`
- inline code / code block -> `code_parts` / `pre_parts`
- link / image -> `a_parts + href` / `img_attrs + src + alt`
- lists / tables -> `ul_parts`, `ol_parts`, `table_parts`, ...

### Focused example shapes

- `basic_page` - document shell + layout
- `form_post` - forms, common attrs, deterministic output
- `mhx_counter` - static `mx-*` attributes without runtime ownership
- `docs_page` - nav + article + code block layout
- `golden_snapshot` - stable HTML for snapshot or golden tests

### papyr boundary

tmpx owns generic HTML primitives and document helpers such as `html_document`,
`stylesheet`, `canonical`, and OGP metadata helpers.

papyr-specific concepts such as document navigation, table of contents, breadcrumbs,
and relation links should live in papyr.mbt or an adapter package built on top of tmpx.

## Migration notes

See `src/tmpx/MIGRATION.md` for migration strategy and behavior differences.

## License

Apache-2.0
