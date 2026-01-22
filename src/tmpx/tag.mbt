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
