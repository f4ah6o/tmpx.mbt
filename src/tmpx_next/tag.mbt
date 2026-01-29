///|
/// HTML tag set (extend via Custom as needed)
pub enum Tag {
  Html
  Head
  Body
  Title
  Base
  Link
  Meta
  Style
  Script
  Noscript
  Address
  Article
  Aside
  Footer
  Header
  H1
  H2
  H3
  H4
  H5
  H6
  Hgroup
  Main
  Nav
  Section
  Search
  Blockquote
  Div
  Dl
  Dt
  Dd
  Figure
  Figcaption
  Hr
  Li
  Menu
  Ol
  P
  Pre
  Ul
  A
  Abbr
  B
  Bdi
  Bdo
  Br
  Cite
  Code
  Data
  Dfn
  Em
  I
  Kbd
  Mark
  Q
  Ruby
  Rp
  Rt
  S
  Samp
  Small
  Span
  Strong
  Sub
  Sup
  Time
  U
  Var
  Wbr
  Area
  Audio
  Img
  Map
  Picture
  Source
  Track
  Video
  Canvas
  Embed
  Iframe
  Object
  Param
  Svg
  Math
  Del
  Ins
  Table
  Caption
  Colgroup
  Col
  Tbody
  Thead
  Tfoot
  Tr
  Th
  Td
  Button
  Datalist
  Fieldset
  Form
  Input
  Label
  Legend
  Meter
  Optgroup
  Option
  Output
  Progress
  Select
  Textarea
  Details
  Dialog
  Summary
  Slot
  Template
  Acronym
  Applet
  Basefont
  Bgsound
  Big
  Blink
  Center
  Dir
  Font
  Frame
  Frameset
  Isindex
  Keygen
  Listing
  Marquee
  Menuitem
  Multicol
  Nextid
  Nobr
  Noembed
  Noframes
  Plaintext
  Spacer
  Strike
  Tt
  Xmp
  Custom(String)
} derive(Show, Eq)

///|
pub fn Tag::to_string(self : Tag) -> String {
  match self {
    Html => "html"
    Head => "head"
    Body => "body"
    Title => "title"
    Base => "base"
    Link => "link"
    Meta => "meta"
    Style => "style"
    Script => "script"
    Noscript => "noscript"
    Address => "address"
    Article => "article"
    Aside => "aside"
    Footer => "footer"
    Header => "header"
    H1 => "h1"
    H2 => "h2"
    H3 => "h3"
    H4 => "h4"
    H5 => "h5"
    H6 => "h6"
    Hgroup => "hgroup"
    Main => "main"
    Nav => "nav"
    Section => "section"
    Search => "search"
    Blockquote => "blockquote"
    Div => "div"
    Dl => "dl"
    Dt => "dt"
    Dd => "dd"
    Figure => "figure"
    Figcaption => "figcaption"
    Hr => "hr"
    Li => "li"
    Menu => "menu"
    Ol => "ol"
    P => "p"
    Pre => "pre"
    Ul => "ul"
    A => "a"
    Abbr => "abbr"
    B => "b"
    Bdi => "bdi"
    Bdo => "bdo"
    Br => "br"
    Cite => "cite"
    Code => "code"
    Data => "data"
    Dfn => "dfn"
    Em => "em"
    I => "i"
    Kbd => "kbd"
    Mark => "mark"
    Q => "q"
    Ruby => "ruby"
    Rp => "rp"
    Rt => "rt"
    S => "s"
    Samp => "samp"
    Small => "small"
    Span => "span"
    Strong => "strong"
    Sub => "sub"
    Sup => "sup"
    Time => "time"
    U => "u"
    Var => "var"
    Wbr => "wbr"
    Area => "area"
    Audio => "audio"
    Img => "img"
    Map => "map"
    Picture => "picture"
    Source => "source"
    Track => "track"
    Video => "video"
    Canvas => "canvas"
    Embed => "embed"
    Iframe => "iframe"
    Object => "object"
    Param => "param"
    Svg => "svg"
    Math => "math"
    Del => "del"
    Ins => "ins"
    Table => "table"
    Caption => "caption"
    Colgroup => "colgroup"
    Col => "col"
    Tbody => "tbody"
    Thead => "thead"
    Tfoot => "tfoot"
    Tr => "tr"
    Th => "th"
    Td => "td"
    Button => "button"
    Datalist => "datalist"
    Fieldset => "fieldset"
    Form => "form"
    Input => "input"
    Label => "label"
    Legend => "legend"
    Meter => "meter"
    Optgroup => "optgroup"
    Option => "option"
    Output => "output"
    Progress => "progress"
    Select => "select"
    Textarea => "textarea"
    Details => "details"
    Dialog => "dialog"
    Summary => "summary"
    Slot => "slot"
    Template => "template"
    Acronym => "acronym"
    Applet => "applet"
    Basefont => "basefont"
    Bgsound => "bgsound"
    Big => "big"
    Blink => "blink"
    Center => "center"
    Dir => "dir"
    Font => "font"
    Frame => "frame"
    Frameset => "frameset"
    Isindex => "isindex"
    Keygen => "keygen"
    Listing => "listing"
    Marquee => "marquee"
    Menuitem => "menuitem"
    Multicol => "multicol"
    Nextid => "nextid"
    Nobr => "nobr"
    Noembed => "noembed"
    Noframes => "noframes"
    Plaintext => "plaintext"
    Spacer => "spacer"
    Strike => "strike"
    Tt => "tt"
    Xmp => "xmp"
    Custom(name) => name
  }
}

///|
pub fn Tag::custom(name : String) -> Tag {
  Custom(name)
}

///|
pub fn Tag::is_void(self : Tag) -> Bool {
  match self {
    Area
    | Base
    | Basefont
    | Bgsound
    | Br
    | Col
    | Embed
    | Frame
    | Hr
    | Img
    | Input
    | Isindex
    | Keygen
    | Link
    | Menuitem
    | Meta
    | Nextid
    | Param
    | Source
    | Spacer
    | Track
    | Wbr => true
    _ => false
  }
}
