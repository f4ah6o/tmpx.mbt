///|
pub fn html_(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Html, attrs, children)
}

///|
pub fn head(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Head, attrs, children)
}

///|
pub fn body(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Body, attrs, children)
}

///|
pub fn title(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Title, attrs, children)
}

///|
pub fn meta(attrs : Array[Attr]) -> Node {
  void_element(Tag::Meta, attrs)
}

///|
pub fn link(attrs : Array[Attr]) -> Node {
  void_element(Tag::Link, attrs)
}

///|
pub fn style_(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Style, attrs, children)
}

///|
pub fn script(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Script, attrs, children)
}

///|
pub fn div(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Div, attrs, children)
}

///|
pub fn span(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Span, attrs, children)
}

///|
pub fn section(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Section, attrs, children)
}

///|
pub fn header_(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Header, attrs, children)
}

///|
pub fn main_(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Main, attrs, children)
}

///|
pub fn aside(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Aside, attrs, children)
}

///|
pub fn footer(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Footer, attrs, children)
}

///|
pub fn nav(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Nav, attrs, children)
}

///|
pub fn article(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Article, attrs, children)
}

///|
pub fn h1(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H1, attrs, children)
}

///|
pub fn h2(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H2, attrs, children)
}

///|
pub fn h3(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H3, attrs, children)
}

///|
pub fn h4(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H4, attrs, children)
}

///|
pub fn h5(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H5, attrs, children)
}

///|
pub fn h6(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::H6, attrs, children)
}

///|
pub fn p(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::P, attrs, children)
}

///|
pub fn small(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Small, attrs, children)
}

///|
pub fn strong(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Strong, attrs, children)
}

///|
pub fn em(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Em, attrs, children)
}

///|
pub fn ul(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Ul, attrs, children)
}

///|
pub fn ol(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Ol, attrs, children)
}

///|
pub fn li(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Li, attrs, children)
}

///|
pub fn a(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::A, attrs, children)
}

///|
pub fn button(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Button, attrs, children)
}

///|
pub fn form(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Form, attrs, children)
}

///|
pub fn label(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Label, attrs, children)
}

///|
pub fn input_(attrs : Array[Attr]) -> Node {
  void_element(Tag::Input, attrs)
}

///|
pub fn textarea(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Textarea, attrs, children)
}

///|
pub fn select(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Select, attrs, children)
}

///|
pub fn option(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Option, attrs, children)
}

///|
pub fn img(attrs : Array[Attr]) -> Node {
  void_element(Tag::Img, attrs)
}

///|
pub fn pre(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Pre, attrs, children)
}

///|
pub fn code(attrs : Array[Attr], children : Array[Node]) -> Node {
  element(Tag::Code, attrs, children)
}

///|
pub fn hr(attrs : Array[Attr]) -> Node {
  void_element(Tag::Hr, attrs)
}

///|
pub fn br() -> Node {
  void_element(Tag::Br, [])
}
