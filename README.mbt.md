# tmpx.mbt

Typed, functional HTML template DSL for MoonBit.

## Features

- **Type-safe tag/attribute construction** - Compile-time safety for HTML structure
- **Functional composition** - Build views using immutable, composable functions
- **htmx-friendly helpers** - First-class support for htmx attributes
- **Automatic HTML escaping** - Secure by default with XSS protection
- **Void element handling** - Correct rendering of self-closing tags

## Installation

Add to your `moon.pkg`:

```moon
import "test" {
  "f4ah6o/tmpx/tmpx" as @tmpx_core
}
```

## Basic Usage

### Creating Elements

HTML elements are created using functional-style builders:

```mbt
// A div with class and content
let card = @tmpx_core.div(
  [@tmpx_core.class_("card"), @tmpx_core.id_("my-card")],
  [@tmpx_core.h1([], [@tmpx_core.text("Hello")])]
)

// Render to HTML string
let html = @tmpx_core.render(card)
// <div class="card" id="my-card"><h1>Hello</h1></div>
```

### Text and Content

```mbt
// Escaped text (safe for user input)
@tmpx_core.text("Hello <World>")
// -> Hello &lt;World&gt;

// Raw HTML (use with caution)
@tmpx_core.raw_html("<strong>Unescaped</strong>")
// -> <strong>Unescaped</strong>

// Fragment (group multiple nodes)
@tmpx_core.fragment([
  @tmpx_core.p([], [@tmpx_core.text("First")]),
  @tmpx_core.p([], [@tmpx_core.text("Second")]),
])
```

### Common Attributes

```mbt
@tmpx_core.class_("container")        // class="container"
@tmpx_core.class_list(["a", "b"])     // class="a b"
@tmpx_core.id_("main")                // id="main"
@tmpx_core.href("/page")              // href="/page"
@tmpx_core.src("/image.png")          // src="/image.png"
@tmpx_core.type_("text")              // type="text"
@tmpx_core.name_("field")             // name="field"
@tmpx_core.value_("val")              // value="val"
@tmpx_core.placeholder("Enter...")    // placeholder="Enter..."
@tmpx_core.method_("post")            // method="post"
@tmpx_core.action("/submit")          // action="/submit"
@tmpx_core.for_("input-id")           // for="input-id"
@tmpx_core.data_attr("id", "123")     // data-id="123"
@tmpx_core.aria("label", "Close")     // aria-label="Close"
@tmpx_core.lang_attr("en")            // lang="en"
```

### Boolean Attributes

```mbt
@tmpx_core.disabled()    // disabled
@tmpx_core.selected()    // selected
```

### Form Elements

```mbt
let form = @tmpx_core.form(
  [@tmpx_core.action("/submit"), @tmpx_core.method_("post")],
  [
    @tmpx_core.label([@tmpx_core.for_("name")], [@tmpx_core.text("Name:")]),
    @tmpx_core.input_([@tmpx_core.type_("text"), @tmpx_core.name_("name")]),
    @tmpx_core.button([], [@tmpx_core.text("Submit")]),
  ]
)
```

## Available HTML Tags

### Document Structure
- `html_`, `head`, `body`, `title`

### Metadata
- `meta`, `link`, `style_`, `script`

### Sections
- `div`, `span`, `section`, `header_`, `main_`, `aside`, `footer`, `nav`, `article`

### Headings
- `h1`, `h2`, `h3`, `h4`, `h5`, `h6`

### Text
- `p`, `small`, `strong`, `em`, `pre`, `code`

### Lists
- `ul`, `ol`, `li`

### Interactive
- `a`, `button`, `form`, `label`, `input_`, `textarea`, `select`, `option`

### Media/Other
- `img`, `hr`, `br`

## htmx Integration

### HTTP Methods

```mbt
@tmpx_core.hx_get("/api/data")
@tmpx_core.hx_post("/api/create")
@tmpx_core.hx_put("/api/update")
@tmpx_core.hx_delete("/api/delete")
```

### htmx Configuration

```mbt
@tmpx_core.hx_target("#output")           // Target element selector
@tmpx_core.hx_trigger("click")            // Trigger event
@tmpx_core.hx_swap(@tmpx_core.InnerHTML)  // Swap strategy
@tmpx_core.hx_include("#form")            // Include additional values
@tmpx_core.hx_push_url(true)              // Push URL to browser history
```

### Swap Strategies

```mbt
@tmpx_core.InnerHTML    // Replace inner HTML (default)
@tmpx_core.OuterHTML    // Replace element entirely
@tmpx_core.BeforeBegin  // Insert before element
@tmpx_core.AfterBegin   // Insert as first child
@tmpx_core.BeforeEnd    // Insert as last child
@tmpx_core.AfterEnd     // Insert after element
@tmpx_core.Delete       // Delete element
@tmpx_core.None         // No swap
@tmpx_core.Morph        // Morph content (htmx extension)
```

### Complete htmx Example

```mbt
let view = @tmpx_core.div([
  @tmpx_core.class_("card"),
  @tmpx_core.hx_get("/partials/ticket/1"),
  @tmpx_core.hx_target("#pane-center"),
  @tmpx_core.hx_swap(@tmpx_core.InnerHTML),
], [
  @tmpx_core.h2([], [@tmpx_core.text("Ticket #1")]),
  @tmpx_core.p([], [@tmpx_core.text("Loading...")]),
])

// Renders:
// <div class="card" hx-get="/partials/ticket/1" hx-target="#pane-center" hx-swap="innerHTML">
//   <h2>Ticket #1</h2>
//   <p>Loading...</p>
// </div>
```

## Rendering

```mbt
// Render a single node
@tmpx_core.render(node) -> String

// Render multiple nodes
@tmpx_core.render_nodes(nodes) -> String
```

## License

Apache-2.0
