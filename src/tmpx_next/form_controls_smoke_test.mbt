///|
test "form controls render select/option/textarea" {
  let node = form_parts([
    part_attr(class_("form")),
    part_child(label_parts([
      part_attr(attr("for", "flavor")),
      part_text("Flavor & notes"),
    ])),
    part_child(select_parts([
      part_attr(id_("flavor")),
      part_child(option_parts([
        part_text("Vanilla <bean>"),
      ])),
    ])),
    part_child(textarea_parts([
      part_attr(attr("name", "notes")),
      part_text("Tasty & simple"),
    ])),
  ])
  inspect(
    render(node),
    content=(
      "<form class=\"form\"><label for=\"flavor\">Flavor &amp; notes</label>" +
      "<select id=\"flavor\"><option>Vanilla &lt;bean&gt;</option></select>" +
      "<textarea name=\"notes\">Tasty &amp; simple</textarea></form>"
    ),
  )
}
