///|
test "normalize_attrs merges class and orders attrs" {
  let attrs = [
    attr("data-z", "1"),
    class_("a"),
    attr("id", "first"),
    class_list(["b", "a", "", "c"]),
    attr("data-a", "old"),
    attr("data-a", "new"),
    id_("last"),
  ]
  let normalized = normalize_attrs(attrs)
  guard normalized
    is [
      Attr::ClassList(classes),
      Attr::KeyVal("id", "last"),
      Attr::KeyVal("data-a", "new"),
      Attr::KeyVal("data-z", "1"),
    ] else {
    fail("unexpected normalized attrs: \{normalized}")
  }
  guard classes == ["a", "b", "c"] else {
    fail("unexpected class list: \{classes}")
  }
}

///|
test "element flattens fragment children" {
  let node = div_parts([
    part_text("a"),
    part_child(fragment([text("b"), fragment([text("c")])])),
  ])
  guard node is Node::Element(elem) else { fail("expected element") }
  guard elem.children == [text("a"), text("b"), text("c")] else {
    fail("unexpected children: \{elem.children}")
  }
}

///|
test "render escapes text and respects attr order" {
  let node = div_parts([
    part_attr(attr("data-b", "1")),
    part_attr(class_("a")),
    part_attr(attr("id", "x")),
    part_attr(attr("data-a", "2")),
    part_text("<hi>"),
    part_child(raw("<b>ok</b>")),
  ])
  inspect(
    render(node),
    content="<div class=\"a\" id=\"x\" data-a=\"2\" data-b=\"1\">&lt;hi&gt;<b>ok</b></div>",
  )
}
