///|
test "inline direction semantics render and respect safety boundary" {
  let node = p_parts([
    part_child(bdi_parts([part_text("user<name>")])),
    part_child(bdo_parts([
      part_attr(attr("dir", "rtl")),
      part_text("abc"),
    ])),
    part_child(data_parts([
      part_attr(attr("value", "x<y")),
      part_text("a < b"),
    ])),
    part_child(dfn_parts([part_child(raw("<em>raw</em>"))])),
  ])
  inspect(
    render(node),
    content=(
      "<p><bdi>user&lt;name&gt;</bdi><bdo dir=\"rtl\">abc</bdo>" +
      "<data value=\"x&lt;y\">a &lt; b</data><dfn><em>raw</em></dfn></p>"
    ),
  )
}
