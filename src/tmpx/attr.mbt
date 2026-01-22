///|
pub enum Attr {
  KeyVal(String, String)
  Bool(String)
  ClassList(Array[String])
} derive(Show, Eq)

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
