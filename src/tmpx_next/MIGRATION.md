# tmpx -> tmpx_next Migration Strategy

This document describes how to migrate code from tmpx to tmpx_next, and how we
plan to manage compatibility during the transition. tmpx_next is intentionally
breaking and lives in a separate package.

## 1. Purpose and incompatibilities (summary)

### Why tmpx_next exists
- Remove user-visible `[]` from the DSL (shorter call sites).
- Make void elements safe by API shape (no silent child discard).
- Make AttrSet normalization deterministic (render order is fixed).
- Provide an immutable, composable update surface (pure transformations).
- Make unsafe HTML insertion explicit (clear safety boundary).

### Core incompatibilities
- **Package name**: new import path `f4ah6o/tmpx/tmpx_next`.
- **Construction API**: tmpx_next core uses array-based builders now
  (`div_parts`, `img_attrs`). Macro-based variadic syntax will be added later.
- **Void safety**: `element(...)` is not public; void tags can only be created
  through void builders or explicit unsafe custom APIs.
- **AttrSet normalization**: class/id/attribute ordering is deterministic and
  may change rendered output compared to tmpx.
- **Unsafe boundary**: `raw_html` becomes `raw` (explicit unsafe).

## 2. Migration steps (recommended order)

1) Add tmpx_next import in parallel to tmpx.
2) Convert small, isolated views first (lower blast radius).
3) Replace old constructors with tmpx_next builders.
4) Regenerate snapshots for tmpx_next (do not reuse tmpx snapshots).
5) Incrementally replace remaining views.

## 3. Mechanical conversion rules (80% coverage)

### Imports

```
// before
import "test" {
  "f4ah6o/tmpx/tmpx" as @tmpx
}

// after
import "test" {
  "f4ah6o/tmpx/tmpx_next" as @tmpx_next
}
```

### Elements

tmpx:
```
@tmpx.div(attrs, children)
```

(tmpx_next core, array-based builders):
```
@tmpx_next.div_parts([
  @tmpx_next.part_attr(...),
  @tmpx_next.part_child(...),
  @tmpx_next.part_text("...")
])
```

When macro DSL is available, this becomes the short form:
```
@tmpx_next.div(
  @tmpx_next.class_("card"),
  @tmpx_next.h1("Title"),
  @tmpx_next.p("Body")
)
```

### Void elements

tmpx:
```
@tmpx.img(attrs)
@tmpx.br()
```

(tmpx_next core):
```
@tmpx_next.img_attrs(attrs)
@tmpx_next.br_attrs([])
```

Note: void builders accept **attrs only** and do not accept children.

### Text / Raw / Fragment

```
@tmpx.text("x")   -> @tmpx_next.text("x")
@tmpx.raw_html("<x>") -> @tmpx_next.raw("<x>")
@tmpx.fragment(nodes) -> @tmpx_next.fragment(nodes)
```

### Tag/Attr helpers

Most attribute helpers are the same name. A few differences to watch:
- `raw_html` -> `raw`
- `part_*` helpers are required in the current core API.

### Custom tags (escape hatch)

tmpx custom:
```
@tmpx.element(@tmpx.Tag::custom("foo"), attrs, children)
```

tmpx_next custom:
```
@tmpx_next.unsafe_custom_element("foo", parts)
@tmpx_next.unsafe_custom_void("foo", attrs)
```

These are intentionally labeled unsafe to keep the default API safe.

## 4. Semantic differences that may change output

### Attr normalization

tmpx_next normalizes attributes with the following rules:
- `class`: merged, empty removed, deduped (first occurrence wins).
- `id`: last occurrence wins.
- other attributes: last occurrence wins.
- order is fixed: `class`, then `id`, then name ascending.

Example (tmpx):
```
class_("a"), attr("class", "b a"), attr("id", "x"), attr("id", "y")
```

tmpx_next output:
```
class="a b" id="y"
```

This will affect snapshots. Expect diffs and update accordingly.

### Fragment flattening

When parts are folded, fragment children are flattened recursively. If you
relied on fragment boundaries for structure, you must preserve them by
returning `Node::Fragment` at the top level (not inside children).

## 5. Migration support (script ideas)

We can automate ~80% with a simple script:
- Replace imports: `tmpx` -> `tmpx_next`.
- Replace `raw_html(` with `raw(`.
- Replace `div(`, `span(`, etc. with `div_parts(`, `span_parts(`.
- Wrap `attrs` with `part_attr`, `children` with `part_child`.
- Convert `text("...")` in children to `part_text("...")` if possible.

Manual steps remain for:
- Custom tags.
- Places where attributes/children are computed across branches.
- Code that passes a prebuilt array of `Node` or `Attr` into a builder.

## 6. Test strategy

- tmpx snapshots remain unchanged.
- tmpx_next gets fresh snapshots under `src/tmpx_next/*_test.mbt`.
- Do not attempt to reuse tmpx snapshot outputs due to deterministic attr order.

Recommended tmpx_next tests:
- Attr normalization invariants.
- Fragment flattening.
- Render order and escaping.

## 7. Adoption guardrails

We only flip defaults (e.g., docs recommending tmpx_next) when:
- Core builder set is available (top 10-15 tags).
- Migration guide is stable.
- Basic snapshot suite is green in CI.

## 8. Recommended initial builder set (high impact)

Layout: `div`, `span`, `main`, `section`, `header`, `footer`
Text: `p`, `h1`, `h2`, `h3`, `a`
Forms: `form`, `input`, `button`, `label`
Lists: `ul`, `ol`, `li`
Void: `img`, `br`, `hr`, `meta`, `link`

