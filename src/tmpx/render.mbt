///|
fn escape_html(text : String) -> String {
  let sb = StringBuilder::new(size_hint=text.length())
  for c in text {
    match c {
      '&' => sb.write_string("&amp;")
      '<' => sb.write_string("&lt;")
      '>' => sb.write_string("&gt;")
      '"' => sb.write_string("&quot;")
      '\'' => sb.write_string("&#39;")
      _ => sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
fn render_kv_attr(sb : StringBuilder, name : String, value : String) -> Unit {
  sb.write_char(' ')
  sb.write_string(name)
  sb.write_string("=\"")
  sb.write_string(escape_html(value))
  sb.write_char('"')
}

///|
fn Attr::render_into(self : Attr, sb : StringBuilder) -> Unit {
  match self {
    Attr::KeyVal(name, value) => render_kv_attr(sb, name, value)
    Attr::Bool(name) => {
      sb.write_char(' ')
      sb.write_string(name)
    }
    Attr::ClassList(values) => {
      let class_value = values.filter(fn(v) { v != "" }).join(" ")
      if class_value != "" {
        render_kv_attr(sb, "class", class_value)
      }
    }
  }
}

///|
fn render_attrs(sb : StringBuilder, attrs : ArrayView[Attr]) -> Unit {
  for attr in attrs {
    attr.render_into(sb)
  }
}

///|
fn Node::render_into(self : Node, sb : StringBuilder) -> Unit {
  match self {
    Node::Text(content) => sb.write_string(escape_html(content))
    Node::Raw(content) => sb.write_string(content)
    Node::Fragment(children) =>
      for child in children {
        child.render_into(sb)
      }
    Node::Element(tag, attrs, children) => {
      sb.write_char('<')
      sb.write_string(tag.to_string())
      render_attrs(sb, attrs)
      sb.write_char('>')
      for child in children {
        child.render_into(sb)
      }
      sb.write_string("</")
      sb.write_string(tag.to_string())
      sb.write_char('>')
    }
    Node::VoidElement(tag, attrs) => {
      sb.write_char('<')
      sb.write_string(tag.to_string())
      render_attrs(sb, attrs)
      sb.write_char('>')
    }
  }
}

///|
pub fn render(node : Node) -> String {
  let sb = StringBuilder::new()
  node.render_into(sb)
  sb.to_string()
}

///|
pub fn render_nodes(nodes : Array[Node]) -> String {
  let sb = StringBuilder::new()
  for node in nodes {
    node.render_into(sb)
  }
  sb.to_string()
}
