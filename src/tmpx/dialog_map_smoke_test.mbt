///|
test "dialog and map render with attrs and escaping" {
  let node = div_parts([
    part_child(
      dialog_parts([
        part_attr(class_("modal")),
        part_attr(id_("dlg")),
        part_attr(bool_attr("open")),
        part_text("Hello <world>"),
      ]),
    ),
    part_child(
      img_attrs([src("/img.png"), alt("Map <img>"), attr("usemap", "#m")]),
    ),
    part_child(
      map_parts([
        part_attr(attr("name", "m")),
        part_child(
          area_attrs([
            attr("shape", "rect"),
            attr("coords", "0,0,10,10"),
            attr("href", "/a?x=1&y=2"),
          ]),
        ),
      ]),
    ),
  ])
  inspect(
    render(node),
    content="<div><dialog class=\"modal\" id=\"dlg\" open>Hello &lt;world&gt;</dialog>" +
      "<img alt=\"Map &lt;img&gt;\" src=\"/img.png\" usemap=\"#m\">" +
      "<map name=\"m\"><area coords=\"0,0,10,10\" href=\"/a?x=1&amp;y=2\" shape=\"rect\"></map></div>",
  )
}
