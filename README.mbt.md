# tmpx.mbt

Typed, functional HTML template DSL for MoonBit.

## Goals
- type-safe tag/attribute construction
- functional composition
- htmx-friendly helpers

## Status
別のリポジトリのアプリでJust-in-time styleの機能開発を行っています。

## Example

```mbt check
test "render sample" {
  let view = @tmpx_core.div([
    @tmpx_core.class_("card"),
    @tmpx_core.hx_get("/partials/ticket/1"),
    @tmpx_core.hx_target("#pane-center"),
  ], [
    @tmpx_core.h2([], [@tmpx_core.text("Ticket #1")]),
    @tmpx_core.p([], [@tmpx_core.text("Hello")]),
  ])
  inspect(
    @tmpx_core.render(view),
    content="<div class=\"card\" hx-get=\"/partials/ticket/1\" hx-target=\"#pane-center\"><h2>Ticket #1</h2><p>Hello</p></div>",
  )
}
```
