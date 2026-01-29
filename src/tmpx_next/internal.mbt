///|
fn flatten_children(children : Array[Node], child : Node) -> Unit {
  match child {
    Node::Fragment(items) =>
      for item in items {
        flatten_children(children, item)
      }
    _ => children.push(child)
  }
}

///|
fn fold_parts(parts : Array[Part]) -> (AttrSet, Array[Node]) {
  let attrs : Array[Attr] = []
  let children : Array[Node] = []
  for part in parts {
    match part {
      Part::PAttr(attr) => attrs.push(attr)
      Part::PChild(child) => flatten_children(children, child)
      Part::PText(value) => flatten_children(children, Node::Text(value))
    }
  }
  (normalize_attrs(attrs), children)
}

///|
fn element(tag : Tag, parts : Array[Part]) -> Node {
  let (attrs, children) = fold_parts(parts)
  Node::Element({ tag, attrs, children })
}

///|
fn void_element(tag : Tag, attrs : Array[Attr]) -> Node {
  Node::Void({ tag, attrs: normalize_attrs(attrs) })
}
