# tmpx -> tmpx Migration Strategy

This document describes how to migrate code from tmpx to tmpx, and how we
plan to manage compatibility during the transition. tmpx is intentionally
breaking and lives in a separate package.

## 1. Purpose and incompatibilities (summary)

### Why tmpx exists
- Remove user-visible `[]` from the DSL (shorter call sites).
- Make void elements safe by API shape (no silent child discard).
- Make AttrSet normalization deterministic (render order is fixed).
- Provide an immutable, composable update surface (pure transformations).
- Make unsafe HTML insertion explicit (clear safety boundary).

### Core incompatibilities
- **Package name**: new import path `f4ah6o/tmpx/tmpx`.
- **Construction API**: array-based builders per tag (`div_parts([parts...])`,
  `img_attrs([attrs...])`) using `Array[Part]` and `Array[Attr]`. A variadic macro
  DSL will be added later.
- **Void safety**: `element(...)`/`void_element(...)` are internal; void tags can
  only be created through void builders or explicit unsafe custom APIs.
- **AttrSet normalization**: class/id/attribute ordering is deterministic and
  may change rendered output compared to tmpx.
- **Unsafe boundary**: `raw_html` becomes `raw` (explicit unsafe).

## 2. Migration steps (recommended order)

1) Add tmpx import in parallel to tmpx.
2) Convert small, isolated views first (lower blast radius).
3) Replace old constructors with tmpx builders.
4) Regenerate snapshots for tmpx (do not reuse tmpx snapshots).
5) Incrementally replace remaining views.

## 2.5 Success criteria (migration done)

**Success Criteria (Migration Done)**
- `moon test` is green at repo root.
- After `moon info`, generated files (including `pkg.generated.mbti`) are up to date with no diff.
- README / `src/tmpx/AGENTS.md` / `src/tmpx/MIGRATION.md` agree, and supported surface is defined by builder batches.
- No `tmpx` references remain anywhere in the repo (imports/paths/docs/test names).
- Old `src/tmpx` is fully removed; recovery is possible via tags/history.

## 3. Mechanical conversion rules (80% coverage)

### Imports

```
// before
import "test" {
  "f4ah6o/tmpx/tmpx" as @tmpx
}

// after
import "test" {
  "f4ah6o/tmpx/tmpx" as @tmpx
}
```

### Elements

tmpx:
```
@tmpx.div(attrs, children)
```

(tmpx core, array-based builders):
```
@tmpx.div_parts([
  @tmpx.part_attr(...),
  @tmpx.part_child(...),
  @tmpx.part_text("...")
])
```

When macro DSL is available, this becomes the short form:
```
@tmpx.div(
  @tmpx.class_("card"),
  @tmpx.h1("Title"),
  @tmpx.p("Body")
)
```

### Void elements

tmpx:
```
@tmpx.img(attrs)
@tmpx.br([])
```

(tmpx core):
```
@tmpx.img_attrs(attrs)
@tmpx.br_attrs([])
```

Note: void builders accept **attrs only** and do not accept children.

### Text / Raw / Fragment

```
@tmpx.text("x")          -> @tmpx.text("x")
@tmpx.raw_html("<x>")    -> @tmpx.raw("<x>")
@tmpx.fragment(nodes)    -> @tmpx.fragment(nodes)
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

tmpx custom:
```
@tmpx.unsafe_custom_element("foo", parts)
@tmpx.unsafe_custom_void("foo", attrs)
```

Policy for `unsafe_custom_*`:
- Use only for non-standard tags (Web Components) or a temporary escape hatch.
- Prefer adding a real builder once a tag is needed broadly.
- Keep `unsafe_custom_*` in application code; avoid in libraries.

## 4. mhx-only policy (Attr-only)

- tmpx provides **mhx only**; htmx helpers are intentionally omitted.
- mhx helpers remain **Attr-only** (no Node construction).
- htmx users should call `attr("hx-...", "...")` directly as an escape hatch.
- mhx helpers emit `mx-*` attribute names (not `data-mx-*`).
- Official minimal mhx helper set: `mx_get`, `mx_post`, `mx_target`,
  `mx_trigger`, `mx_swap` + `MxSwap`.

## 5. Semantic differences that may change output

### Attr normalization

tmpx normalizes attributes with the following rules:
- `class`: merged, empty removed, deduped (first occurrence wins).
- `id`: last occurrence wins.
- other attributes: last occurrence wins.
- order is fixed: `class`, then `id`, then name ascending.

This will affect snapshots. Expect diffs and update accordingly.

### Fragment flattening

When parts are folded, fragment children are flattened recursively. If you
relied on fragment boundaries for structure, you must preserve them by
returning `Node::Fragment` at the top level (not inside children).

### Void safety

tmpx allows `element(Tag::Img, attrs, children)` and silently discards
children. tmpx disallows this by API shape; use void builders or
`unsafe_custom_void` when needed.

## 6. Concrete diff examples (before/after)

### Example 1: attribute order + id last-wins

tmpx:
```
@tmpx.div([
  @tmpx.attr("data-z", "9"),
  @tmpx.id_("a"),
  @tmpx.class_("x y"),
  @tmpx.attr("data-a", "1"),
  @tmpx.id_("b")
], [])
```

tmpx render:
```
<div data-z="9" id="a" class="x y" data-a="1" id="b"></div>
```

tmpx:
```
@tmpx.div_parts([
  @tmpx.part_attr(@tmpx.attr("data-z", "9")),
  @tmpx.part_attr(@tmpx.id_("a")),
  @tmpx.part_attr(@tmpx.class_("x y")),
  @tmpx.part_attr(@tmpx.attr("data-a", "1")),
  @tmpx.part_attr(@tmpx.id_("b"))
])
```

tmpx render:
```
<div class="x y" id="b" data-a="1" data-z="9"></div>
```

### Example 2: class merging and dedup

tmpx:
```
@tmpx.div([
  @tmpx.class_("a  b"),
  @tmpx.class_list(["b", "", "c"])
], [])
```

tmpx render:
```
<div class="a  b" class="b c"></div>
```

tmpx:
```
@tmpx.div_parts([
  @tmpx.part_attr(@tmpx.class_("a  b")),
  @tmpx.part_attr(@tmpx.class_list(["b", "", "c"]))
])
```

tmpx render:
```
<div class="a b c"></div>
```

### Example 3: void children are rejected

tmpx (children silently discarded):
```
@tmpx.element(
  @tmpx.Tag::Img,
  [@tmpx.src("/img.png")],
  [@tmpx.text("oops")]
)
```

(tmpx has no public `element(...)`; you must use a void builder):
```
@tmpx.img_attrs([@tmpx.src("/img.png")])
```

### Example 4: fragment flattening changes tree shape

tmpx tree shape:
```
<div>
  Fragment([Text("a"), Text("b")])
</div>
```

tmpx tree shape after folding parts:
```
<div>
  Text("a")
  Text("b")
</div>
```

Render output is the same (`<div>ab</div>`), but downstream transforms that
inspect children will observe a different tree shape.

## 7. Migration support (script ideas)

We can automate ~80% with a simple script:
- Replace imports: `tmpx` -> `tmpx`.
- Replace `raw_html(` with `raw(`.
- Replace `foo(attrs, children)` with `foo_parts([part_attr(...), part_child(...)])`.
- Wrap `attrs` with `part_attr`, `children` with `part_child`.
- Convert `text("...")` in children to `part_text("...")` if possible.

Manual steps remain for:
- Custom tags.
- Places where attributes/children are computed across branches.
- Code that passes a prebuilt array of `Node` or `Attr` into a builder.

## 8. Test strategy (practical steps)

### Legacy Snapshot Policy

- Legacy tmpx snapshots are not preserved during migration.
- tmpx's determinism (Attr normalization, void rendering, escape boundary)
  is the source of truth; old snapshots are discarded or regenerated as needed.
- Post-migration regression safety relies on tmpx smoke/contract tests.

### Practical steps

- Add tmpx snapshots under `*_test.mbt` (in this package).
- For shared inputs, compare `@tmpx.render(...)` vs `@tmpx.render(...)` to
  identify expected diffs.
- Update snapshots in this order:
  1) Attr normalization/order diffs
  2) Void safety and custom tag usage
  3) Fragment flattening and tree-shape changes

Recommended tmpx tests:
- Attr normalization invariants.
- Fragment flattening.
- Render order and escaping.

## 9. Adoption guardrails

We only flip defaults (e.g., docs recommending tmpx) when:
- Core builder set is available (top 10-15 tags).
- Migration guide is stable.
- Basic snapshot suite is green in CI.

## 10. Builder batches (current)

For the guaranteed builder set, see `AGENTS.md`.

Tag support policy: builders define the supported surface. The Tag enum may
include legacy/obsolete tags for compatibility, but they are not tested or
guaranteed and may be removed in a future major revision. Use `unsafe_custom_*`
only when absolutely necessary.

Beta status: tmpx is usable and tested; builder coverage may expand and
breaking changes are unlikely but possible before 1.0. Start with v1 builders
plus common v2 tags, and treat `svg`, `math`, `canvas`, `script`, `style` as
deferred. For gaps, request the next builder batch.

### v1 batch (fixed surface)
Layout: `div_parts`, `span_parts`, `main_parts`, `section_parts`, `header_parts`, `footer_parts`
Text: `p_parts`, `h1_parts`, `h2_parts`, `h3_parts`, `a_parts`
Forms: `form_parts`, `input_attrs`, `button_parts`, `label_parts`
Lists: `ul_parts`, `li_parts`
Void: `img_attrs`, `br_attrs`, `hr_attrs`

### v2 batch (additive)
Document: `html_parts`, `head_parts`, `body_parts`, `title_parts`, `nav_parts`, `article_parts`, `aside_parts`
Text: `h4_parts`, `h5_parts`, `h6_parts`, `em_parts`, `strong_parts`, `code_parts`, `pre_parts`
Media: `figure_parts`, `figcaption_parts`, `video_parts`, `audio_parts`
Tables: `table_parts`, `thead_parts`, `tbody_parts`, `tfoot_parts`, `tr_parts`, `th_parts`, `td_parts`
Forms: `textarea_parts`, `select_parts`, `option_parts`
Void: `meta_attrs`, `link_attrs`, `source_attrs`

### v3 batch (additive)
Inline/misc: `small_parts`, `cite_parts`, `blockquote_parts`, `dl_parts`, `dt_parts`, `dd_parts`, `ol_parts`
Details: `details_parts`, `summary_parts`
Forms: `fieldset_parts`, `legend_parts`
Void: `base_attrs`, `area_attrs`, `col_attrs`, `embed_attrs`, `param_attrs`, `track_attrs`, `wbr_attrs`

### v4 batch (additive)
Inline: `kbd_parts`, `mark_parts`, `sup_parts`, `sub_parts`
Tables: `caption_parts`, `colgroup_parts`

### v5 batch (additive)
Forms: `datalist_parts`, `optgroup_parts`, `output_parts`, `progress_parts`, `meter_parts`
Inline: `abbr_parts`, `time_parts`, `q_parts`, `s_parts`, `u_parts`, `del_parts`, `ins_parts`

### v6 batch (additive)
Media: `picture_parts`, `iframe_parts`
Inline: `i_parts`, `b_parts`, `samp_parts`, `var_parts`, `ruby_parts`, `rt_parts`, `rp_parts`

### v7 batch (additive)
Semantic: `dialog_parts`, `address_parts`, `search_parts`, `map_parts`
Inline: `bdi_parts`, `bdo_parts`, `data_parts`, `dfn_parts`

### v8 batch (additive)
Components: `template_parts`, `slot_parts`, `object_parts`
Semantic: `menu_parts`, `hgroup_parts`, `noscript_parts`
