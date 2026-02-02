///|
test "doc example: card" {
  let card = div_parts([
    part_attr(class_("card")),
    part_attr(id_("main")),
    part_child(h1_parts([part_text("Title")])),
    part_child(p_parts([part_text("Body")])),
  ])
  inspect(
    render(card),
    content="<div class=\"card\" id=\"main\"><h1>Title</h1><p>Body</p></div>",
  )
}

///|
test "doc example: form" {
  let form = form_parts([
    part_attr(attr("action", "/submit")),
    part_attr(attr("method", "post")),
    part_child(
      label_parts([part_attr(attr("for", "name")), part_text("Name:")]),
    ),
    part_child(
      input_attrs([
        attr("type", "text"),
        attr("name", "name"),
        bool_attr("required"),
      ]),
    ),
    part_child(button_parts([part_text("Send")])),
  ])
  let html = render(form)
  guard html.contains("<form") else { fail("missing form: \{html}") }
  guard html.contains("action=\"/submit\"") else {
    fail("missing action: \{html}")
  }
  guard html.contains("method=\"post\"") else {
    fail("missing method: \{html}")
  }
  guard html.contains("<label") else { fail("missing label: \{html}") }
  guard html.contains("<input") else { fail("missing input: \{html}") }
  guard html.contains("required") else { fail("missing required: \{html}") }
}

///|
test "doc example: fragment and raw" {
  let node = fragment([text("Hello "), raw("<b>World</b>")])
  inspect(render(node), content="Hello <b>World</b>")
}
