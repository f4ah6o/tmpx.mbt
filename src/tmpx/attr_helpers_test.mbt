///|
test "attribute helpers cover common names" {
  let node = nav_parts([
    part_attr(role("navigation")),
    part_attr(aria("label", "Main navigation")),
    part_attr(data("doc-id", "intro")),
  ])
  inspect(
    render(node),
    content="<nav aria-label=\"Main navigation\" data-doc-id=\"intro\" role=\"navigation\"></nav>",
  )
}

///|
test "form and boolean attribute helpers stay deterministic" {
  let node = input_attrs([
    type_("email"),
    name_("email"),
    value_("user@example.com"),
    placeholder("name <required>"),
    required(),
    disabled(),
    checked(),
    selected(),
  ])
  inspect(
    render(node),
    content="<input checked disabled name=\"email\" placeholder=\"name &lt;required&gt;\" required selected type=\"email\" value=\"user@example.com\">",
  )
}

///|
test "action and method helpers compose with builders" {
  let node = form_parts([
    part_attr(action("/submit")),
    part_attr(method_("post")),
    part_text("Send"),
  ])
  inspect(
    render(node),
    content="<form action=\"/submit\" method=\"post\">Send</form>",
  )
}
