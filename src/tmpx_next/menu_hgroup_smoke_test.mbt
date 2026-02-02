///|
test "menu and hgroup render structure and escape text" {
  let node = div_parts([
    part_child(hgroup_parts([
      part_child(h1_parts([part_text("A < B") ])),
      part_child(h2_parts([part_text("Subtitle") ])),
    ])),
    part_child(menu_parts([
      part_child(li_parts([
        part_child(a_parts([
          part_attr(href("/")),
          part_text("Home"),
        ])),
      ])),
    ])),
  ])
  inspect(
    render(node),
    content=(
      "<div><hgroup><h1>A &lt; B</h1><h2>Subtitle</h2></hgroup>" +
      "<menu><li><a href=\"/\">Home</a></li></menu></div>"
    ),
  )
}
