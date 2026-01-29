///|
pub enum Attr {
  KeyVal(String, String)
  Bool(String)
  ClassList(Array[String])
} derive(Show, Eq)

///|
pub type AttrSet = Array[Attr]

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
pub fn alt(value : String) -> Attr {
  Attr::KeyVal("alt", value)
}

///|
/// Normalize attribute list into AttrSet.
/// - class merged, deduped, empty removed (first occurrence wins)
/// - id last-wins and is single
/// - other attributes last-wins and single
/// - order: class, id, then name ascending
pub fn normalize_attrs(attrs : Array[Attr]) -> AttrSet {
  fn split_whitespace(value : String) -> Array[String] {
    let tokens : Array[String] = []
    let sb = StringBuilder::new()
    for c in value {
      if c.is_whitespace() {
        if !sb.is_empty() {
          tokens.push(sb.to_string())
          sb.reset()
        }
      } else {
        sb.write_char(c)
      }
    }
    if !sb.is_empty() {
      tokens.push(sb.to_string())
    }
    tokens
  }

  fn add_class_tokens(
    value : String,
    class_values : Array[String],
    class_seen : Map[String, Bool],
  ) -> Unit {
    for token in split_whitespace(value) {
      if token != "" && !class_seen.contains(token) {
        class_seen[token] = true
        class_values.push(token)
      }
    }
  }

  let class_values : Array[String] = []
  let class_seen : Map[String, Bool] = {}
  let mut id_attr : Attr? = None
  let others : Map[String, Attr] = {}
  for attr in attrs {
    match attr {
      Attr::ClassList(values) =>
        for value in values {
          add_class_tokens(value, class_values, class_seen)
        }
      Attr::KeyVal(name, value) =>
        if name == "class" {
          add_class_tokens(value, class_values, class_seen)
        } else if name == "id" {
          id_attr = Some(attr)
        } else {
          others[name] = attr
        }
      Attr::Bool(name) =>
        if name == "class" {
          ()
        } else if name == "id" {
          id_attr = Some(attr)
        } else {
          others[name] = attr
        }
    }
  }
  let normalized : Array[Attr] = []
  if !class_values.is_empty() {
    normalized.push(Attr::ClassList(class_values))
  }
  match id_attr {
    Some(attr) => normalized.push(attr)
    None => ()
  }
  let names : Array[String] = []
  for name in others.keys() {
    names.push(name)
  }
  names.sort()
  for name in names {
    normalized.push(others[name])
  }
  normalized
}
