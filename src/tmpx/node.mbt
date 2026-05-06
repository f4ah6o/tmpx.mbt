///|
pub struct ElementNode {
  tag : Tag
  attrs : AttrSet
  children : Array[Node]
} derive(Show, Eq)

///|
pub struct VoidNode {
  tag : Tag
  attrs : AttrSet
} derive(Show, Eq)

///|
pub enum Node {
  Element(ElementNode)
  Void(VoidNode)
  Text(String)
  Raw(String)
  Fragment(Array[Node])
} derive(Show, Eq)

///|
pub enum Part {
  PAttr(Attr)
  PChild(Node)
  PText(String)
} derive(Show, Eq)

///|
pub fn part_attr(attr : Attr) -> Part {
  Part::PAttr(attr)
}

///|
pub fn part_child(node : Node) -> Part {
  Part::PChild(node)
}

///|
pub fn part_text(value : String) -> Part {
  Part::PText(value)
}

///|
pub fn text(content : String) -> Node {
  Node::Text(content)
}

///|
pub fn raw(content : String) -> Node {
  Node::Raw(content)
}

///|
/// Naming alias for raw(). Use when the unsafe nature of the content should be
/// visible at the callsite. Produces the same output as raw().
pub fn raw_unsafe(content : String) -> Node {
  raw(content)
}

///|
pub fn fragment(children : Array[Node]) -> Node {
  Node::Fragment(children)
}
