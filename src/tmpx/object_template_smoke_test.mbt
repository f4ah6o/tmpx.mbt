///|
test "object and template render with attrs and safety boundary" {
  let node = div_parts([
    part_child(
      object_parts([
        part_attr(class_("obj")),
        part_attr(id_("o1")),
        part_attr(attr("data", "/a?x=1&y=2")),
        part_child(
          param_attrs([attr("name", "movie"), attr("value", "/movie.mp4")]),
        ),
      ]),
    ),
    part_child(
      template_parts([
        part_child(slot_parts([part_attr(attr("name", "s1"))])),
        part_text("a < b"),
        part_child(raw("<em>raw</em>")),
      ]),
    ),
  ])
  inspect(
    render(node),
    content="<div><object class=\"obj\" id=\"o1\" data=\"/a?x=1&amp;y=2\">" +
      "<param name=\"movie\" value=\"/movie.mp4\"></object>" +
      "<template><slot name=\"s1\"></slot>a &lt; b<em>raw</em></template></div>",
  )
}
