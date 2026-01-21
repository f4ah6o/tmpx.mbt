///|
/// htmx swap styles
pub(all) enum HxSwap {
  InnerHTML
  OuterHTML
  BeforeBegin
  AfterBegin
  BeforeEnd
  AfterEnd
  Delete
  None
  Morph
} derive(Show, Eq)

///|
pub fn HxSwap::to_string(self : HxSwap) -> String {
  match self {
    InnerHTML => "innerHTML"
    OuterHTML => "outerHTML"
    BeforeBegin => "beforebegin"
    AfterBegin => "afterbegin"
    BeforeEnd => "beforeend"
    AfterEnd => "afterend"
    Delete => "delete"
    None => "none"
    Morph => "morph"
  }
}

///|
pub fn hx_get(url : String) -> Attr {
  attr("hx-get", url)
}

///|
pub fn hx_post(url : String) -> Attr {
  attr("hx-post", url)
}

///|
pub fn hx_put(url : String) -> Attr {
  attr("hx-put", url)
}

///|
pub fn hx_delete(url : String) -> Attr {
  attr("hx-delete", url)
}

///|
pub fn hx_target(selector : String) -> Attr {
  attr("hx-target", selector)
}

///|
pub fn hx_trigger(spec : String) -> Attr {
  attr("hx-trigger", spec)
}

///|
pub fn hx_swap(style : HxSwap) -> Attr {
  attr("hx-swap", style.to_string())
}

///|
pub fn hx_include(selector : String) -> Attr {
  attr("hx-include", selector)
}

///|
pub fn hx_vals(json : String) -> Attr {
  attr("hx-vals", json)
}

///|
pub fn hx_push_url(enabled : Bool) -> Attr {
  if enabled {
    attr("hx-push-url", "true")
  } else {
    attr("hx-push-url", "false")
  }
}

///|
pub fn hx_swap_oob(style? : HxSwap) -> Attr {
  match style {
    Some(s) => attr("hx-swap-oob", s.to_string())
    None => bool_attr("hx-swap-oob")
  }
}
