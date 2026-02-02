# tmpx.mbt
<!-- bdg:begin -->
![moonbit](https://img.shields.io/badge/moonbit-f4ah6o/tmpx-informational)
<!-- bdg:end -->

Typed, functional HTML template DSL for MoonBit.

## Features

- **Type-safe tag/attribute construction** - avoid stringly-typed HTML where possible
- **Functional composition** - build views from pure, immutable functions
- **Deterministic rendering** - normalized attributes with fixed order
- **Void safety by API shape** - void elements cannot accept children
- **mhx-only helpers** - explicit attribute helpers for mx-* integration

## Installation

Add to your `moon.pkg`:

```moon
import "test" {
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
- Deferred areas: `svg`, `math`, `canvas`, `script`, `style`.
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

## Attribute Helpers

```mbt
class_("container")
class_list(["a", "b"])
id_("main")
href("/page")
src("/image.png")
alt("Logo")
attr("data-id", "123")
bool_attr("required")
```

For any other attribute, use `attr(name, value)`.

## mhx Integration (mx-*)

```mbt
mx_get("/api/data")
mx_post("/api/create")
mx_target("#pane")
mx_trigger("click")
mx_swap(InnerHTML)
```

## Supported Tags

Supported tags are defined by the published builder batches (v1–v8) in `src/tmpx/AGENTS.md`.
Use `unsafe_custom_*` only for experimental/custom elements.

## Rendering

```mbt
render(node) -> String
```

## Migration notes

See `src/tmpx/MIGRATION.md` for migration strategy and behavior differences.

## License

Apache-2.0
