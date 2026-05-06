///|
fn meta_name(name : String, content : String) -> Node {
  meta_attrs([attr("name", name), attr("content", content)])
}

///|
fn meta_property(name : String, content : String) -> Node {
  meta_attrs([attr("property", name), attr("content", content)])
}

///|
fn push_child_parts(parts : Array[Part], nodes : Array[Node]) -> Array[Part] {
  for n in nodes {
    parts.push(part_child(n))
  }
  parts
}

///|
pub fn html_document(head : Array[Node], body : Array[Node]) -> Node {
  html_parts([
    part_child(head_parts(push_child_parts([], head))),
    part_child(body_parts(push_child_parts([], body))),
  ])
}

///|
pub fn doctype_html(node : Node) -> String {
  "<!doctype html>" + render(node)
}

///|
pub fn meta_charset_utf8() -> Node {
  meta_attrs([attr("charset", "utf-8")])
}

///|
pub fn meta_viewport() -> Node {
  meta_name("viewport", "width=device-width, initial-scale=1")
}

///|
pub fn stylesheet(path : String) -> Node {
  link_attrs([attr("rel", "stylesheet"), href(path)])
}

///|
pub fn canonical(path : String) -> Node {
  link_attrs([attr("rel", "canonical"), href(path)])
}

///|
pub fn module_script(path : String) -> Node {
  unsafe_custom_element("script", [
    part_attr(src(path)),
    part_attr(type_("module")),
  ])
}

///|
pub fn og_title(value : String) -> Node {
  meta_property("og:title", value)
}

///|
pub fn og_description(value : String) -> Node {
  meta_property("og:description", value)
}

///|
pub fn og_image(value : String) -> Node {
  meta_property("og:image", value)
}

///|
pub fn twitter_card(value : String) -> Node {
  meta_name("twitter:card", value)
}
