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
fn render_node_into(node : Node, sb : StringBuilder) -> Unit {
  match node {
    Node::Text(content) => sb.write_string(escape_html(content))
    Node::Raw(content) => sb.write_string(content)
    Node::Fragment(children) =>
      for child in children {
        render_node_into(child, sb)
      }
    Node::Element(element) => {
      sb.write_char('<')
      sb.write_string(element.tag.to_string())
      render_attrs(sb, element.attrs)
      sb.write_char('>')
      for child in element.children {
        render_node_into(child, sb)
      }
      sb.write_string("</")
      sb.write_string(element.tag.to_string())
      sb.write_char('>')
    }
    Node::Void(element) => {
      sb.write_char('<')
      sb.write_string(element.tag.to_string())
      render_attrs(sb, element.attrs)
      sb.write_char('>')
    }
  }
}

///|
pub fn render(node : Node) -> String {
  let sb = StringBuilder::new()
  render_node_into(node, sb)
  sb.to_string()
}

///|
pub fn render_nodes(nodes : Array[Node]) -> String {
  let sb = StringBuilder::new()
  for node in nodes {
    render_node_into(node, sb)
  }
  sb.to_string()
}
