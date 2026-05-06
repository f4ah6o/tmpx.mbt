///|
fn copy_attrs(attrs : Array[Attr]) -> Array[Attr] {
  let copied : Array[Attr] = []
  for attr in attrs {
    copied.push(attr)
  }
  copied
}

///|
fn copy_nodes(nodes : Array[Node]) -> Array[Node] {
  let copied : Array[Node] = []
  for node in nodes {
    copied.push(node)
  }
  copied
}

///|
fn prepend_node(nodes : Array[Node], child : Node) -> Array[Node] {
  let updated : Array[Node] = []
  flatten_children(updated, child)
  for node in nodes {
    updated.push(node)
  }
  updated
}

///|
fn append_node(nodes : Array[Node], child : Node) -> Array[Node] {
  let updated = copy_nodes(nodes)
  flatten_children(updated, child)
  updated
}

///|
pub fn map_attrs(node : Node, f : (Array[Attr]) -> Array[Attr]) -> Node {
  match node {
    Node::Element(element) =>
      Node::Element({
        tag: element.tag,
        attrs: normalize_attrs(f(copy_attrs(element.attrs))),
        children: copy_nodes(element.children),
      })
    Node::Void(element) =>
      Node::Void({
        tag: element.tag,
        attrs: normalize_attrs(f(copy_attrs(element.attrs))),
      })
    _ => node
  }
}

///|
pub fn with_attr(node : Node, attr : Attr) -> Node {
  map_attrs(node, fn(attrs) {
    attrs.push(attr)
    attrs
  })
}

///|
pub fn add_class(node : Node, class_name : String) -> Node {
  with_attr(node, class_(class_name))
}

///|
pub fn set_id(node : Node, value : String) -> Node {
  with_attr(node, id_(value))
}

///|
pub fn append_child(node : Node, child : Node) -> Node {
  match node {
    Node::Element(element) =>
      Node::Element({
        tag: element.tag,
        attrs: copy_attrs(element.attrs),
        children: append_node(element.children, child),
      })
    Node::Fragment(children) => Node::Fragment(append_node(children, child))
    _ => node
  }
}

///|
pub fn prepend_child(node : Node, child : Node) -> Node {
  match node {
    Node::Element(element) =>
      Node::Element({
        tag: element.tag,
        attrs: copy_attrs(element.attrs),
        children: prepend_node(element.children, child),
      })
    Node::Fragment(children) => Node::Fragment(prepend_node(children, child))
    _ => node
  }
}

///|
pub fn map_children(node : Node, f : (Array[Node]) -> Array[Node]) -> Node {
  match node {
    Node::Element(element) => {
      let children : Array[Node] = []
      for child in f(copy_nodes(element.children)) {
        flatten_children(children, child)
      }
      Node::Element({
        tag: element.tag,
        attrs: copy_attrs(element.attrs),
        children,
      })
    }
    Node::Fragment(children) => Node::Fragment(f(copy_nodes(children)))
    _ => node
  }
}

///|
pub fn wrap(node : Node, wrapper : (Node) -> Node) -> Node {
  wrapper(node)
}
