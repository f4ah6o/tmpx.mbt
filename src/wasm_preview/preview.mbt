///|
let error_fragment : String = "<p>Invalid preview document</p>"

///|
fn string_field(obj : Map[String, Json], key : String) -> String? {
  match obj.get(key) {
    Some(Json::String(value)) => Some(value)
    _ => None
  }
}

///|
fn string_array_field(obj : Map[String, Json], key : String) -> Array[String]? {
  match obj.get(key) {
    Some(Json::Array(values)) => {
      let strings = []
      for value in values {
        match value {
          Json::String(text) => strings.push(text)
          _ => return None
        }
      }
      Some(strings)
    }
    _ => None
  }
}

///|
fn text_part(value : String) -> @tmpx.Part {
  @tmpx.part_text(value)
}

///|
fn child_part(node : @tmpx.Node) -> @tmpx.Part {
  @tmpx.part_child(node)
}

///|
fn render_list(items : Array[String], ordered : Bool) -> @tmpx.Node {
  let children = []
  for item in items {
    children.push(child_part(@tmpx.li_parts([text_part(item)])))
  }
  if ordered {
    @tmpx.ol_parts(children)
  } else {
    @tmpx.ul_parts(children)
  }
}

///|
fn render_block(json : Json) -> @tmpx.Node? {
  match json {
    Json::Object(obj) =>
      match string_field(obj, "type") {
        Some("h1") =>
          match string_field(obj, "text") {
            Some(text) => Some(@tmpx.h1_parts([text_part(text)]))
            None => None
          }
        Some("p") =>
          match string_field(obj, "text") {
            Some(text) => Some(@tmpx.p_parts([text_part(text)]))
            None => None
          }
        Some("code") =>
          match string_field(obj, "text") {
            Some(text) =>
              Some(
                @tmpx.pre_parts([
                  child_part(@tmpx.code_parts([text_part(text)])),
                ]),
              )
            None => None
          }
        Some("a") =>
          match (string_field(obj, "href"), string_field(obj, "text")) {
            (Some(href), Some(text)) =>
              Some(
                @tmpx.a_parts([
                  @tmpx.part_attr(@tmpx.href(href)),
                  text_part(text),
                ]),
              )
            _ => None
          }
        Some("ul") =>
          match string_array_field(obj, "items") {
            Some(items) => Some(render_list(items, false))
            None => None
          }
        Some("ol") =>
          match string_array_field(obj, "items") {
            Some(items) => Some(render_list(items, true))
            None => None
          }
        _ => None
      }
    _ => None
  }
}

///|
fn parse_preview(json : Json) -> (String, Array[@tmpx.Node])? {
  match json {
    Json::Object(obj) =>
      match (string_field(obj, "title"), obj.get("body")) {
        (Some(title), Some(Json::Array(blocks))) => {
          let children = []
          for block in blocks {
            match render_block(block) {
              Some(node) => children.push(node)
              None => return None
            }
          }
          Some((title, children))
        }
        _ => None
      }
    _ => None
  }
}

///|
fn render_preview(json : String, document : Bool) -> String {
  try @json.parse(json) catch {
    _ => error_fragment
  } noraise {
    value =>
      match parse_preview(value) {
        Some((title, children)) =>
          if document {
            @tmpx.doctype_html(
              @tmpx.html_document(
                [
                  @tmpx.meta_charset_utf8(),
                  @tmpx.title_parts([text_part(title)]),
                ],
                children,
              ),
            )
          } else {
            @tmpx.render(@tmpx.fragment(children))
          }
        None => error_fragment
      }
  }
}

///|
pub fn render_fragment(json : String) -> String {
  render_preview(json, false)
}

///|
pub fn render_doc(json : String) -> String {
  render_preview(json, true)
}
