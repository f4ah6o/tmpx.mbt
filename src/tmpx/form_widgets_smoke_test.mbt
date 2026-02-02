///|
test "form widgets render datalist/output/progress/meter" {
  let node = form_parts([
    part_attr(class_("form")),
    part_attr(id_("f1")),
    part_attr(attr("action", "/submit?x=1&y=2")),
    part_child(label_parts([
      part_attr(attr("for", "flavor")),
      part_text("Flavor <pick>"),
    ])),
    part_child(datalist_parts([
      part_child(option_parts([
        part_text("Vanilla"),
      ])),
      part_child(option_parts([
        part_text("Chocolate & mint"),
      ])),
    ])),
    part_child(output_parts([
      part_attr(attr("name", "result")),
      part_text("Value < 10"),
    ])),
    part_child(progress_parts([
      part_attr(attr("value", "3")),
      part_attr(attr("max", "10")),
    ])),
    part_child(meter_parts([
      part_attr(attr("value", "0.7")),
    ])),
  ])
  inspect(
    render(node),
    content=(
      "<form class=\"form\" id=\"f1\" action=\"/submit?x=1&amp;y=2\">" +
      "<label for=\"flavor\">Flavor &lt;pick&gt;</label>" +
      "<datalist><option>Vanilla</option><option>Chocolate &amp; mint</option></datalist>" +
      "<output name=\"result\">Value &lt; 10</output>" +
      "<progress max=\"10\" value=\"3\"></progress>" +
      "<meter value=\"0.7\"></meter></form>"
    ),
  )
}
