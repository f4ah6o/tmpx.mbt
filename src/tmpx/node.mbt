///|
pub enum Node {
  Element(Tag, Array[Attr], Array[Node])
  VoidElement(Tag, Array[Attr])
  Text(String)
  Raw(String)
  Fragment(Array[Node])
} derive(Show, Eq)

///|
fn Tag::element(
  self : Tag,
  attrs : Array[Attr],
  children : Array[Node],
) -> Node {
  if self.is_void() {
    Node::VoidElement(self, attrs)
  } else {
    Node::Element(self, attrs, children)
  }
}

///|
fn Tag::void_element(self : Tag, attrs : Array[Attr]) -> Node {
  Node::VoidElement(self, attrs)
}

///|
pub fn text(content : String) -> Node {
  Node::Text(content)
}

///|
pub fn raw_html(content : String) -> Node {
  Node::Raw(content)
}

///|
pub fn fragment(children : Array[Node]) -> Node {
  Node::Fragment(children)
}

///|
pub fn element(tag : Tag, attrs : Array[Attr], children : Array[Node]) -> Node {
  tag.element(attrs, children)
}

///|
pub fn void_element(tag : Tag, attrs : Array[Attr]) -> Node {
  tag.void_element(attrs)
}
