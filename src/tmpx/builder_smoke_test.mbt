///|
test "builder smoke renders div + p + img" {
  let node = div_parts([
    part_child(p_parts([part_text("Hello")])),
    part_child(img_attrs([src("/logo.png")]))
  ])
  inspect(
    render(node),
    content="<div><p>Hello</p><img src=\"/logo.png\"></div>",
  )
}
