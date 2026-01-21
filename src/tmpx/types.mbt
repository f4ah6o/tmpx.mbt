///|
/// HTML tag set (extend via Custom as needed)
pub enum Tag {
  Html
  Head
  Body
  Title
  Meta
  Link
  Style
  Script
  Div
  Span
  Section
  Header
  Main
  Aside
  Footer
  Nav
  Article
  H1
  H2
  H3
  H4
  H5
  H6
  P
  Small
  Strong
  Em
  Ul
  Ol
  Li
  A
  Button
  Form
  Label
  Input
  Textarea
  Select
  Option
  Img
  Pre
  Code
  Hr
  Br
  Custom(String)
} derive(Show, Eq)

///|
pub fn Tag::to_string(self : Tag) -> String {
  match self {
    Html => "html"
    Head => "head"
    Body => "body"
    Title => "title"
    Meta => "meta"
    Link => "link"
    Style => "style"
    Script => "script"
    Div => "div"
    Span => "span"
    Section => "section"
    Header => "header"
    Main => "main"
    Aside => "aside"
    Footer => "footer"
    Nav => "nav"
    Article => "article"
    H1 => "h1"
    H2 => "h2"
    H3 => "h3"
    H4 => "h4"
    H5 => "h5"
    H6 => "h6"
    P => "p"
    Small => "small"
    Strong => "strong"
    Em => "em"
    Ul => "ul"
    Ol => "ol"
    Li => "li"
    A => "a"
    Button => "button"
    Form => "form"
    Label => "label"
    Input => "input"
    Textarea => "textarea"
    Select => "select"
    Option => "option"
    Img => "img"
    Pre => "pre"
    Code => "code"
    Hr => "hr"
    Br => "br"
    Custom(name) => name
  }
}

///|
pub fn Tag::is_void(self : Tag) -> Bool {
  match self {
    Meta | Link | Input | Img | Hr | Br => true
    _ => false
  }
}

///|
pub enum Node {
  Element(Tag, Array[Attr], Array[Node])
  VoidElement(Tag, Array[Attr])
  Text(String)
  Raw(String)
  Fragment(Array[Node])
} derive(Show, Eq)

///|
pub enum Attr {
  KeyVal(String, String)
  Bool(String)
  ClassList(Array[String])
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

///|
pub fn attr(name : String, value : String) -> Attr {
  Attr::KeyVal(name, value)
}

///|
pub fn bool_attr(name : String) -> Attr {
  Attr::Bool(name)
}

///|
pub fn class_(value : String) -> Attr {
  Attr::KeyVal("class", value)
}

///|
pub fn class_list(values : Array[String]) -> Attr {
  Attr::ClassList(values)
}

///|
pub fn id_(value : String) -> Attr {
  Attr::KeyVal("id", value)
}

///|
pub fn href(value : String) -> Attr {
  Attr::KeyVal("href", value)
}

///|
pub fn src(value : String) -> Attr {
  Attr::KeyVal("src", value)
}

///|
pub fn rel(value : String) -> Attr {
  Attr::KeyVal("rel", value)
}

///|
pub fn type_(value : String) -> Attr {
  Attr::KeyVal("type", value)
}

///|
pub fn name_(value : String) -> Attr {
  Attr::KeyVal("name", value)
}

///|
pub fn value_(value : String) -> Attr {
  Attr::KeyVal("value", value)
}

///|
pub fn placeholder(value : String) -> Attr {
  Attr::KeyVal("placeholder", value)
}

///|
pub fn method_(value : String) -> Attr {
  Attr::KeyVal("method", value)
}

///|
pub fn action(value : String) -> Attr {
  Attr::KeyVal("action", value)
}

///|
pub fn for_(value : String) -> Attr {
  Attr::KeyVal("for", value)
}

///|
pub fn charset(value : String) -> Attr {
  Attr::KeyVal("charset", value)
}

///|
pub fn content(value : String) -> Attr {
  Attr::KeyVal("content", value)
}

///|
pub fn disabled() -> Attr {
  Attr::Bool("disabled")
}

///|
pub fn selected() -> Attr {
  Attr::Bool("selected")
}

///|
pub fn data_attr(name : String, value : String) -> Attr {
  Attr::KeyVal("data-" + name, value)
}

///|
pub fn aria(name : String, value : String) -> Attr {
  Attr::KeyVal("aria-" + name, value)
}

///|
pub fn lang_attr(value : String) -> Attr {
  Attr::KeyVal("lang", value)
}
