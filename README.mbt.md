# tmpx.mbt
<!-- bdg:begin -->
![moonbit](https://img.shields.io/badge/moonbit-f4ah6o/tmpx-informational)
<!-- bdg:end -->

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

## tmpx_next (Experimental, breaking changes)

tmpx_next is a next-generation DSL that breaks compatibility on purpose. It aims
for a shorter API (no user-facing `[]`), void-safety by type, and immutable
update operations. It lives in a separate package so you can adopt it gradually.

```moon
import "test" {
  "f4ah6o/tmpx/tmpx_next" as @tmpx_next
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

### Document & Metadata
- `html_`, `head`, `body`, `title`, `base`, `link`, `meta`, `style_`, `script`, `noscript`

### Sectioning & Headings
- `address`, `article`, `aside`, `footer`, `header_`, `h1`-`h6`, `hgroup`, `main_`, `nav`, `section`, `search`

### Text Content
- `blockquote`, `div`, `dl`, `dt`, `dd`, `figure`, `figcaption`, `hr`, `li`, `menu`, `ol`, `p`, `pre`, `ul`

### Inline Text Semantics
- `a`, `abbr`, `b`, `bdi`, `bdo`, `br`, `cite`, `code`, `data`, `dfn`, `em`, `i`, `kbd`, `mark`, `q`, `ruby`, `rp`, `rt`, `s`, `samp`, `small`, `span`, `strong`, `sub`, `sup`, `time`, `u`, `var_`, `wbr`

### Media & Embedded
- `img`, `picture`, `source`, `track`, `audio`, `video`, `map`, `area`, `canvas`, `iframe`, `embed`, `object_`, `param`, `svg`, `math`

### Edits
- `del`, `ins`

### Tables
- `table`, `caption`, `colgroup`, `col`, `thead`, `tbody`, `tfoot`, `tr`, `th`, `td`

### Forms
- `form`, `input_`, `textarea`, `select`, `option`, `optgroup`, `datalist`, `fieldset`, `legend`, `label`, `button`, `output`, `progress`, `meter`

### Interactive & Web Components
- `details`, `summary`, `dialog`, `slot`, `template`

### Legacy (obsolete/deprecated)
- `acronym`, `applet`, `basefont`, `bgsound`, `big`, `blink`, `center`, `dir`, `font`, `frame`, `frameset`, `isindex`, `keygen`, `listing`, `marquee`, `menuitem`, `multicol`, `nextid`, `nobr`, `noembed`, `noframes`, `plaintext`, `spacer`, `strike`, `tt`, `xmp`

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


