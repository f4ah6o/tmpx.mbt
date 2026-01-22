///|
pub fn html_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Html.element(attrs, children)
}

///|
pub fn head(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Head.element(attrs, children)
}

///|
pub fn body(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Body.element(attrs, children)
}

///|
pub fn title(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Title.element(attrs, children)
}

///|
pub fn meta(attrs : Array[Attr]) -> Node {
  Tag::Meta.void_element(attrs)
}

///|
pub fn link(attrs : Array[Attr]) -> Node {
  Tag::Link.void_element(attrs)
}

///|
pub fn style_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Style.element(attrs, children)
}

///|
pub fn script(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Script.element(attrs, children)
}

///|
pub fn div(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Div.element(attrs, children)
}

///|
pub fn span(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Span.element(attrs, children)
}

///|
pub fn section(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Section.element(attrs, children)
}

///|
pub fn header_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Header.element(attrs, children)
}

///|
pub fn main_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Main.element(attrs, children)
}

///|
pub fn aside(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Aside.element(attrs, children)
}

///|
pub fn footer(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Footer.element(attrs, children)
}

///|
pub fn nav(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Nav.element(attrs, children)
}

///|
pub fn article(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Article.element(attrs, children)
}

///|
pub fn h1(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H1.element(attrs, children)
}

///|
pub fn h2(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H2.element(attrs, children)
}

///|
pub fn h3(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H3.element(attrs, children)
}

///|
pub fn h4(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H4.element(attrs, children)
}

///|
pub fn h5(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H5.element(attrs, children)
}

///|
pub fn h6(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H6.element(attrs, children)
}

///|
pub fn p(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::P.element(attrs, children)
}

///|
pub fn small(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Small.element(attrs, children)
}

///|
pub fn strong(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Strong.element(attrs, children)
}

///|
pub fn em(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Em.element(attrs, children)
}

///|
pub fn ul(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ul.element(attrs, children)
}

///|
pub fn ol(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ol.element(attrs, children)
}

///|
pub fn li(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Li.element(attrs, children)
}

///|
pub fn a(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::A.element(attrs, children)
}

///|
pub fn button(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Button.element(attrs, children)
}

///|
pub fn form(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Form.element(attrs, children)
}

///|
pub fn label(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Label.element(attrs, children)
}

///|
pub fn input_(attrs : Array[Attr]) -> Node {
  Tag::Input.void_element(attrs)
}

///|
pub fn textarea(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Textarea.element(attrs, children)
}

///|
pub fn select(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Select.element(attrs, children)
}

///|
pub fn option(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Option.element(attrs, children)
}

///|
pub fn img(attrs : Array[Attr]) -> Node {
  Tag::Img.void_element(attrs)
}

///|
pub fn pre(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Pre.element(attrs, children)
}

///|
pub fn code(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Code.element(attrs, children)
}

///|
pub fn hr(attrs : Array[Attr]) -> Node {
  Tag::Hr.void_element(attrs)
}

///|
pub fn br() -> Node {
  Tag::Br.void_element([])
}
