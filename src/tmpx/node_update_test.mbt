///|
test "attribute updates preserve normalization and original node" {
  let node = div_parts([
    part_attr(class_("base")),
    part_attr(attr("data-z", "1")),
    part_text("body"),
  ])
  let updated = set_id(
    add_class(with_attr(node, attr("data-a", "2")), "base elevated"),
    "hero",
  )
  inspect(render(node), content="<div class=\"base\" data-z=\"1\">body</div>")
  inspect(
    render(updated),
    content="<div class=\"base elevated\" id=\"hero\" data-a=\"2\" data-z=\"1\">body</div>",
  )
}

///|
test "map_attrs preserves deterministic attribute order" {
  let node = div_parts([part_attr(attr("data-z", "1")), part_text("x")])
  let updated = map_attrs(node, fn(attrs) {
    attrs.push(attr("data-a", "2"))
    attrs.push(attr("data-m", "3"))
    attrs
  })
  inspect(
    render(updated),
    content="<div data-a=\"2\" data-m=\"3\" data-z=\"1\">x</div>",
  )
}

///|
test "child updates compose for elements and fragments" {
  let list = ul_parts([part_child(li_parts([part_text("b")]))])
  let wrapped = wrap(
    map_children(
      prepend_child(
        append_child(
          list,
          fragment([li_parts([part_text("c")]), li_parts([part_text("d")])]),
        ),
        li_parts([part_text("a")]),
      ),
      fn(children) { [children[0], children[2], children[1], children[3]] },
    ),
    fn(node) { div_parts([part_attr(class_("frame")), part_child(node)]) },
  )
  inspect(
    render(wrapped),
    content="<div class=\"frame\"><ul><li>a</li><li>c</li><li>b</li><li>d</li></ul></div>",
  )

  let fragment_node = fragment([text("b")])
  let reordered = map_children(
    prepend_child(append_child(fragment_node, fragment([text("c")])), text("a")),
    fn(children) { [children[0], children[2], children[1]] },
  )
  inspect(render(reordered), content="acb")
}

///|
test "unsupported child and attr updates are explicit no-op" {
  let img = img_attrs([src("/logo.png"), alt("Logo")])
  let text_node = text("hello")
  assert_eq(append_child(img, text("ignored")), img)
  assert_eq(with_attr(text_node, class_("x")), text_node)
}
