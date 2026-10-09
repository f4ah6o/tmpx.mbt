# Expand common attribute helper coverage

Created: 2026-05-05

Model: gh-migrate

## Summary

Expand common attribute helper coverage

## Original Issue

- [GitHub #5](https://github.com/f4ah6o/tmpx.mbt/issues/5)


## Description

# Expand common attribute helper coverage

## Summary

Add common attribute helpers to improve ergonomics while keeping tmpx simple and explicit.

This follows the proposal in #1. The goal is not to fully model HTML validation, but to reduce repetitive `attr("...", "...")` calls for common attributes.

## Motivation

Current helpers cover the most basic cases such as class, id, href, src, alt, generic key-value attributes, and boolean attributes.

For real UI construction, documentation pages, forms, accessibility annotations, and generated views, several attributes appear frequently enough to deserve stable helpers.

## Proposed helpers

```moonbit
role(value: String) -> Attr
aria(name: String, value: String) -> Attr
data(name: String, value: String) -> Attr

type_(value: String) -> Attr
name_(value: String) -> Attr
value_(value: String) -> Attr
method(value: String) -> Attr
action(value: String) -> Attr
placeholder(value: String) -> Attr

required() -> Attr
disabled() -> Attr
checked() -> Attr
selected() -> Attr
```

## Examples

```moonbit
button_parts([
  part_attr(type_("submit")),
  part_attr(class_("primary")),
  part_text("Save")
])

nav_parts([
  part_attr(role("navigation")),
  part_attr(aria("label", "Main navigation"))
])

div_parts([
  part_attr(data("doc-id", "intro"))
])
```

## Design constraints

- Helpers should return `Attr` only.
- Keep names predictable and short.
- Avoid full HTML validation.
- Preserve existing `attr(name, value)` escape hatch.
- Boolean helpers should use existing `bool_attr` semantics.

## Suggested tests

- helpers render expected attribute names
- `aria("label", "x")` renders `aria-label="x"`
- `data("doc-id", "x")` renders `data-doc-id="x"`
- boolean helpers render without values
- deterministic attribute ordering still applies

## Non-goals

- Full typed attribute grammar
- Element-specific attribute validation
- Replacing `attr(name, value)`
