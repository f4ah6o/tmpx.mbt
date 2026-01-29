///|
/// Element builders (array-based core API)
pub fn div_parts(parts : Array[Part]) -> Node {
  element(Tag::Div, parts)
}

///|
pub fn span_parts(parts : Array[Part]) -> Node {
  element(Tag::Span, parts)
}

///|
pub fn p_parts(parts : Array[Part]) -> Node {
  element(Tag::P, parts)
}

///|
/// Void builders (array-based core API)
pub fn img_attrs(attrs : Array[Attr]) -> Node {
  void_element(Tag::Img, attrs)
}

///|
pub fn br_attrs(attrs : Array[Attr]) -> Node {
  void_element(Tag::Br, attrs)
}

///|
/// Explicit unsafe escape hatches for custom tags.
/// Custom tags may be void or non-void; callers must choose correctly.
pub fn unsafe_custom_element(name : String, parts : Array[Part]) -> Node {
  element(Tag::custom(name), parts)
}

///|
pub fn unsafe_custom_void(name : String, attrs : Array[Attr]) -> Node {
  void_element(Tag::custom(name), attrs)
}
