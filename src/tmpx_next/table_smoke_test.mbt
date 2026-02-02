///|
test "table smoke renders basic table" {
  let node = table_parts([
    part_attr(class_("tbl")),
    part_child(thead_parts([
      part_child(tr_parts([
        part_child(th_parts([part_text("Name")])),
        part_child(th_parts([part_text("Age")])),
      ])),
    ])),
    part_child(tbody_parts([
      part_child(tr_parts([
        part_child(td_parts([part_text("Ada")])),
        part_child(td_parts([part_text("36")])),
      ])),
    ])),
  ])
  inspect(
    render(node),
    content=(
      "<table class=\"tbl\"><thead><tr><th>Name</th><th>Age</th></tr></thead>" +
      "<tbody><tr><td>Ada</td><td>36</td></tr></tbody></table>"
    ),
  )
}
