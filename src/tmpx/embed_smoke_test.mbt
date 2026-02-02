///|
test "embed smoke renders picture/source/img/iframe" {
  let node = div_parts([
    part_child(
      picture_parts([
        part_child(
          source_attrs([attr("type", "image/avif"), attr("srcset", "/a.avif")]),
        ),
        part_child(img_attrs([src("/a.png"), alt("A < B")])),
      ]),
    ),
    part_child(
      iframe_parts([
        part_attr(attr("src", "/embed")),
        part_attr(attr("title", "A < B")),
      ]),
    ),
  ])
  inspect(
    render(node),
    content="<div><picture><source srcset=\"/a.avif\" type=\"image/avif\">" +
      "<img alt=\"A &lt; B\" src=\"/a.png\"></picture>" +
      "<iframe src=\"/embed\" title=\"A &lt; B\"></iframe></div>",
  )
}
