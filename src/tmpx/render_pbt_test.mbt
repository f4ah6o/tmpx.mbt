///|
fn escape_html_test(text : String) -> String {
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
fn gen_string() -> @qc.Gen[String] {
  @qc.Gen::spawn()
}

///|
fn gen_attr_name() -> @qc.Gen[String] {
  @qc.one_of_array([
    "id", "class", "data-x", "data-msg", "aria-label", "title", "href",
  ])
}

///|
fn gen_attr() -> @qc.Gen[Attr] {
  let gen_value = gen_string()
  let gen_keyval = gen_attr_name().bind(fn(name) {
    gen_value.fmap(fn(value) { attr(name, value) })
  })
  let gen_bool = gen_attr_name().fmap(fn(name) { bool_attr(name) })
  let gen_class_list = @qc.sized(fn(size) {
    let len = if size <= 0 { 0 } else { size % 5 }
    gen_string().array_with_size(len).fmap(fn(values) { class_list(values) })
  })
  @qc.frequency([(6, gen_keyval), (2, gen_bool), (2, gen_class_list)])
}

///|
fn gen_attr_array() -> @qc.Gen[Array[Attr]] {
  @qc.sized(fn(size) {
    let len = if size <= 0 { 0 } else { size % 5 }
    gen_attr().array_with_size(len)
  })
}

///|
fn gen_node_array() -> @qc.Gen[Array[Node]] {
  @qc.sized(fn(size) {
    let len = if size <= 0 { 0 } else { size % 4 }
    gen_node().resize(size / 2).array_with_size(len)
  })
}

///|
fn gen_node() -> @qc.Gen[Node] {
  @qc.sized(fn(size) {
    let gen_text = gen_string().fmap(fn(content) { text(content) })
    let gen_raw = gen_string().fmap(fn(content) { raw_html(content) })
    if size <= 0 {
      @qc.one_of([gen_text, gen_raw])
    } else {
      let gen_attrs = gen_attr_array()
      let gen_children = gen_node_array().resize(size / 2)
      let gen_div = gen_attrs.bind(fn(attrs) {
        gen_children.fmap(fn(children) { div(attrs, children) })
      })
      let gen_span = gen_attrs.bind(fn(attrs) {
        gen_children.fmap(fn(children) { span(attrs, children) })
      })
      let gen_p = gen_attrs.bind(fn(attrs) {
        gen_children.fmap(fn(children) { p(attrs, children) })
      })
      let gen_section = gen_attrs.bind(fn(attrs) {
        gen_children.fmap(fn(children) { section(attrs, children) })
      })
      let gen_img = gen_attrs.fmap(fn(attrs) { img(attrs) })
      let gen_input = gen_attrs.fmap(fn(attrs) { input_(attrs) })
      let gen_hr = gen_attrs.fmap(fn(attrs) { hr(attrs) })
      let gen_void = @qc.one_of([gen_img, gen_input, gen_hr, @qc.pure(br())])
      let gen_fragment = gen_children.fmap(fn(children) { fragment(children) })
      @qc.frequency([
        (3, gen_text),
        (2, gen_raw),
        (3, gen_div),
        (2, gen_span),
        (2, gen_p),
        (2, gen_section),
        (2, gen_void),
        (2, gen_fragment),
      ])
    }
  })
}

///|
fn render_nodes_concat(nodes : Array[Node]) -> String {
  let sb = StringBuilder::new()
  for node in nodes {
    sb.write_string(render(node))
  }
  sb.to_string()
}

///|
test "pbt render escapes text" {
  @qc.quick_check_fn(fn(content : String) {
    render(text(content)) == escape_html_test(content)
  })
}

///|
test "pbt render leaves raw html untouched" {
  @qc.quick_check_fn(fn(content : String) {
    render(raw_html(content)) == content
  })
}

///|
test "pbt render escapes attribute values" {
  @qc.quick_check_fn(fn(value : String) {
    let node = div([attr("data-x", value)], [])
    render(node) == "<div data-x=\"\{escape_html_test(value)}\"></div>"
  })
}

///|
test "pbt fragment equals render_nodes" {
  @qc.quick_check(
    @qc.forall(gen_node_array(), fn(nodes) {
      render(fragment(nodes)) == render_nodes(nodes)
    }),
  )
}

///|
test "pbt render_nodes concatenates render" {
  @qc.quick_check(
    @qc.forall(gen_node_array(), fn(nodes) {
      render_nodes(nodes) == render_nodes_concat(nodes)
    }),
  )
}
