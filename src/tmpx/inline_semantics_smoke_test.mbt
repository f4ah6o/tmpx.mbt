///|
test "inline semantics render and respect safety boundary" {
  let node = p_parts([
    part_child(kbd_parts([part_text("Ctrl+<C>")])),
    part_child(mark_parts([part_child(raw("<em>hot</em>"))])),
    part_child(sup_parts([part_text("x<2>")])),
    part_child(sub_parts([part_text("y&1")])),
  ])
  inspect(
    render(node),
    content="<p><kbd>Ctrl+&lt;C&gt;</kbd><mark><em>hot</em></mark>" +
      "<sup>x&lt;2&gt;</sup><sub>y&amp;1</sub></p>",
  )
}
