///|
/// mhx attribute helpers for tmpx.
/// These helpers return Attr only and do not construct Nodes.

///|
/// mx-swap styles - determines how content is swapped into the DOM
pub(all) enum MxSwap {
  /// Replace the innerHTML of the target element (default)
  InnerHTML
  /// Replace the entire target element (outerHTML)
  OuterHTML
  /// Insert before the target element
  BeforeBegin
  /// Insert at the start of target's children
  AfterBegin
  /// Insert at the end of target's children
  BeforeEnd
  /// Insert after the target element
  AfterEnd
  /// Remove the target element
  Delete
  /// Do nothing with the response
  None
} derive(Show, Eq)

///|
/// Convert MxSwap to its string representation
pub fn MxSwap::to_string(self : MxSwap) -> String {
  match self {
    InnerHTML => "innerHTML"
    OuterHTML => "outerHTML"
    BeforeBegin => "beforebegin"
    AfterBegin => "afterbegin"
    BeforeEnd => "beforeend"
    AfterEnd => "afterend"
    Delete => "delete"
    None => "none"
  }
}

///|
/// mx-get: Issue a GET request to the given URL
pub fn mx_get(url : String) -> Attr {
  attr("mx-get", url)
}

///|
/// mx-post: Issue a POST request to the given URL
pub fn mx_post(url : String) -> Attr {
  attr("mx-post", url)
}

///|
/// mx-target: Specify the target element for swapping
pub fn mx_target(selector : String) -> Attr {
  attr("mx-target", selector)
}

///|
/// mx-trigger: Specify the event that triggers the request
pub fn mx_trigger(spec : String) -> Attr {
  attr("mx-trigger", spec)
}

///|
/// mx-swap: Specify how the response content is swapped into the DOM
pub fn mx_swap(style : MxSwap) -> Attr {
  attr("mx-swap", style.to_string())
}
