///|
pub enum Node {
  Element(Tag, Array[Attr], Array[Node])
  VoidElement(Tag, Array[Attr])
  Text(String)
  Raw(String)
  Fragment(Array[Node])
} derive(Show, Eq)

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
  if tag.is_void() {
    Node::VoidElement(tag, attrs)
  } else {
    Node::Element(tag, attrs, children)
  }
}

///|
pub fn void_element(tag : Tag, attrs : Array[Attr]) -> Node {
  Node::VoidElement(tag, attrs)
}
