///|
/// mhx attribute helpers for tmpx
/// Generates mx-* attributes compatible with f4ah6o/mhx runtime
///
/// mhx is a type-safe Hypermedia-Driven Architecture library for MoonBit/Wasm
/// These helpers allow tmpx templates to generate mx-* attributes that will be
/// processed by the mhx runtime on the client side.

// =============================================================================
// Swap Strategies
// =============================================================================

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

// =============================================================================
// Sync Strategies
// =============================================================================

///|
/// mx-sync strategies - controls concurrent request handling
pub(all) enum MxSync {
  /// Drop new requests while one is in flight (default)
  Drop
  /// Cancel current request and start new one
  Replace
  /// Queue first request after current
  QueueFirst
  /// Queue last request after current
  QueueLast
  /// Queue all requests
  QueueAll
} derive(Show, Eq)

///|
/// Convert MxSync to its string representation
pub fn MxSync::to_string(self : MxSync) -> String {
  match self {
    Drop => "drop"
    Replace => "replace"
    QueueFirst => "first"
    QueueLast => "last"
    QueueAll => "all"
  }
}

// =============================================================================
// Target Selectors
// =============================================================================

///|
/// mx-target selector types - determines which element receives the response
pub(all) enum MxSelector {
  /// The element itself (default)
  This
  /// document.body
  Body
  /// window object
  Window
  /// document object
  Document
  /// Find closest ancestor matching selector
  Closest(String)
  /// Find descendant matching selector
  Find(String)
  /// Find next sibling matching selector
  Next(String)
  /// Find previous sibling matching selector
  Previous(String)
  /// Arbitrary CSS selector
  Css(String)
} derive(Show, Eq)

///|
/// Convert MxSelector to its string representation
pub fn MxSelector::to_string(self : MxSelector) -> String {
  match self {
    This => "this"
    Body => "body"
    Window => "window"
    Document => "document"
    Closest(s) => "closest " + s
    Find(s) => "find " + s
    Next(s) => "next " + s
    Previous(s) => "previous " + s
    Css(s) => s
  }
}

// =============================================================================
// HTTP Method Attributes
// =============================================================================

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
/// mx-put: Issue a PUT request to the given URL
pub fn mx_put(url : String) -> Attr {
  attr("mx-put", url)
}

///|
/// mx-patch: Issue a PATCH request to the given URL
pub fn mx_patch(url : String) -> Attr {
  attr("mx-patch", url)
}

///|
/// mx-delete: Issue a DELETE request to the given URL
pub fn mx_delete(url : String) -> Attr {
  attr("mx-delete", url)
}

// =============================================================================
// Core Attributes
// =============================================================================

///|
/// mx-target: Specify the target element for swapping
/// Can be a CSS selector or special value like "this", "closest ...", etc.
pub fn mx_target(selector : String) -> Attr {
  attr("mx-target", selector)
}

///|
/// mx-target with MxSelector enum for type-safe targeting
pub fn mx_target_selector(selector : MxSelector) -> Attr {
  attr("mx-target", selector.to_string())
}

///|
/// mx-trigger: Specify the event that triggers the request
/// Supports event names with modifiers like "click", "keyup changed delay:500ms"
pub fn mx_trigger(spec : String) -> Attr {
  attr("mx-trigger", spec)
}

///|
/// mx-swap: Specify how the response content is swapped into the DOM
pub fn mx_swap(style : MxSwap) -> Attr {
  attr("mx-swap", style.to_string())
}

///|
/// mx-swap with extended options
/// Format: "strategy [modifier:value ...]"
/// e.g., "innerHTML swap:500ms settle:1s scroll:top"
pub fn mx_swap_extended(
  style : MxSwap,
  swap_delay~ : Int = 0,
  settle_delay~ : Int = 0,
  scroll~ : String = "",
  show~ : String = "",
  focus_scroll~ : Bool = false
) -> Attr {
  let mut value = style.to_string()
  if swap_delay > 0 {
    value = value + " swap:" + swap_delay.to_string() + "ms"
  }
  if settle_delay > 0 {
    value = value + " settle:" + settle_delay.to_string() + "ms"
  }
  if scroll != "" {
    value = value + " scroll:" + scroll
  }
  if show != "" {
    value = value + " show:" + show
  }
  if focus_scroll {
    value = value + " focus-scroll:true"
  }
  attr("mx-swap", value)
}

// =============================================================================
// Request Configuration Attributes
// =============================================================================

///|
/// mx-include: Include additional elements in the request
/// The selector specifies which elements' values to include
pub fn mx_include(selector : String) -> Attr {
  attr("mx-include", selector)
}

///|
/// mx-vals: Add additional values to the request as JSON
pub fn mx_vals(json : String) -> Attr {
  attr("mx-vals", json)
}

///|
/// mx-headers: Add additional headers to the request as JSON
pub fn mx_headers(json : String) -> Attr {
  attr("mx-headers", json)
}

///|
/// mx-params: Control which parameters are submitted
/// "*" for all, "none" for none, or comma-separated list
pub fn mx_params(params : String) -> Attr {
  attr("mx-params", params)
}

///|
/// mx-encoding: Set the encoding type for the request
pub fn mx_encoding(encoding : String) -> Attr {
  attr("mx-encoding", encoding)
}

// =============================================================================
// URL Manipulation Attributes
// =============================================================================

///|
/// mx-push-url: Push URL to browser history
pub fn mx_push_url(enabled : Bool) -> Attr {
  attr("mx-push-url", if enabled { "true" } else { "false" })
}

///|
/// mx-push-url with custom URL
pub fn mx_push_url_custom(url : String) -> Attr {
  attr("mx-push-url", url)
}

///|
/// mx-replace-url: Replace current URL in browser history
pub fn mx_replace_url(enabled : Bool) -> Attr {
  attr("mx-replace-url", if enabled { "true" } else { "false" })
}

///|
/// mx-replace-url with custom URL
pub fn mx_replace_url_custom(url : String) -> Attr {
  attr("mx-replace-url", url)
}

// =============================================================================
// Out-of-Band Swaps
// =============================================================================

///|
/// mx-swap-oob: Out-of-band swap
/// When true, this element will be swapped based on its id
pub fn mx_swap_oob(style? : MxSwap) -> Attr {
  match style {
    Some(s) => attr("mx-swap-oob", s.to_string())
    Option::None => bool_attr("mx-swap-oob")
  }
}

///|
/// mx-swap-oob with selector for targeting specific elements
pub fn mx_swap_oob_select(style : MxSwap, selector : String) -> Attr {
  attr("mx-swap-oob", style.to_string() + ":" + selector)
}

///|
/// mx-select: Select a subset of the response to swap in
pub fn mx_select(selector : String) -> Attr {
  attr("mx-select", selector)
}

///|
/// mx-select-oob: Select elements for out-of-band swaps
pub fn mx_select_oob(selector : String) -> Attr {
  attr("mx-select-oob", selector)
}

// =============================================================================
// Request Synchronization
// =============================================================================

///|
/// mx-sync: Control how requests are synchronized
pub fn mx_sync(strategy : MxSync) -> Attr {
  attr("mx-sync", strategy.to_string())
}

///|
/// mx-sync with custom element selector
/// Format: "selector:strategy"
pub fn mx_sync_with(selector : String, strategy : MxSync) -> Attr {
  attr("mx-sync", selector + ":" + strategy.to_string())
}

// =============================================================================
// Indicator and Loading States
// =============================================================================

///|
/// mx-indicator: Element to show during request
pub fn mx_indicator(selector : String) -> Attr {
  attr("mx-indicator", selector)
}

///|
/// mx-disabled-elt: Elements to disable during request
pub fn mx_disabled_elt(selector : String) -> Attr {
  attr("mx-disabled-elt", selector)
}

// =============================================================================
// Confirmation and Prompts
// =============================================================================

///|
/// mx-confirm: Show confirmation dialog before request
pub fn mx_confirm(message : String) -> Attr {
  attr("mx-confirm", message)
}

///|
/// mx-prompt: Show prompt dialog and include result in request
pub fn mx_prompt(message : String) -> Attr {
  attr("mx-prompt", message)
}

// =============================================================================
// Validation
// =============================================================================

///|
/// mx-validate: Enable validation before request
pub fn mx_validate(enabled : Bool) -> Attr {
  attr("mx-validate", if enabled { "true" } else { "false" })
}

// =============================================================================
// Inheritance Control
// =============================================================================

///|
/// mx-boost: Enable link/form boosting
pub fn mx_boost(enabled : Bool) -> Attr {
  attr("mx-boost", if enabled { "true" } else { "false" })
}

///|
/// mx-inherit: Control attribute inheritance from parent elements
pub fn mx_inherit(attrs : String) -> Attr {
  attr("mx-inherit", attrs)
}

///|
/// mx-disinherit: Prevent attribute inheritance
pub fn mx_disinherit(attrs : String) -> Attr {
  attr("mx-disinherit", attrs)
}

// =============================================================================
// Preserve Content
// =============================================================================

///|
/// mx-preserve: Preserve this element during swaps
pub fn mx_preserve() -> Attr {
  bool_attr("mx-preserve")
}

// =============================================================================
// Extensions
// =============================================================================

///|
/// mx-ext: Enable mhx extensions
pub fn mx_ext(extensions : String) -> Attr {
  attr("mx-ext", extensions)
}

// =============================================================================
// Trigger Helpers - Convenient trigger specifications
// =============================================================================

///|
/// Create a click trigger
pub fn mx_trigger_click() -> Attr {
  attr("mx-trigger", "click")
}

///|
/// Create a submit trigger (for forms)
pub fn mx_trigger_submit() -> Attr {
  attr("mx-trigger", "submit")
}

///|
/// Create a change trigger (for inputs)
pub fn mx_trigger_change() -> Attr {
  attr("mx-trigger", "change")
}

///|
/// Create a keyup trigger with optional changed modifier
pub fn mx_trigger_keyup(changed~ : Bool = false) -> Attr {
  let value = if changed { "keyup changed" } else { "keyup" }
  attr("mx-trigger", value)
}

///|
/// Create a load trigger (fires on page load)
pub fn mx_trigger_load() -> Attr {
  attr("mx-trigger", "load")
}

///|
/// Create a revealed trigger (fires when element scrolls into view)
pub fn mx_trigger_revealed() -> Attr {
  attr("mx-trigger", "revealed")
}

///|
/// Create an intersect trigger (fires on intersection observer)
pub fn mx_trigger_intersect(threshold~ : Double = 0.0) -> Attr {
  let value = if threshold > 0.0 {
    "intersect threshold:" + threshold.to_string()
  } else {
    "intersect"
  }
  attr("mx-trigger", value)
}

///|
/// Create a trigger with delay modifier
pub fn mx_trigger_with_delay(event : String, delay_ms : Int) -> Attr {
  attr("mx-trigger", event + " delay:" + delay_ms.to_string() + "ms")
}

///|
/// Create a trigger with throttle modifier
pub fn mx_trigger_with_throttle(event : String, throttle_ms : Int) -> Attr {
  attr("mx-trigger", event + " throttle:" + throttle_ms.to_string() + "ms")
}

///|
/// Create a trigger with debounce modifier
pub fn mx_trigger_with_debounce(event : String, debounce_ms : Int) -> Attr {
  attr("mx-trigger", event + " debounce:" + debounce_ms.to_string() + "ms")
}

///|
/// Create a trigger with once modifier (fires only once)
pub fn mx_trigger_once(event : String) -> Attr {
  attr("mx-trigger", event + " once")
}

///|
/// Create a trigger with changed modifier
pub fn mx_trigger_changed(event : String) -> Attr {
  attr("mx-trigger", event + " changed")
}

///|
/// Create a trigger with from modifier (listen to events from another element)
pub fn mx_trigger_from(event : String, selector : String) -> Attr {
  attr("mx-trigger", event + " from:" + selector)
}

///|
/// Create a trigger with target modifier
pub fn mx_trigger_target(event : String, selector : String) -> Attr {
  attr("mx-trigger", event + " target:" + selector)
}

///|
/// Create a trigger with consume modifier (stopPropagation)
pub fn mx_trigger_consume(event : String) -> Attr {
  attr("mx-trigger", event + " consume")
}

///|
/// Create a trigger with prevent modifier (preventDefault)
pub fn mx_trigger_prevent(event : String) -> Attr {
  attr("mx-trigger", event + " prevent")
}

///|
/// Create a trigger with queue modifier
pub fn mx_trigger_queue(event : String, mode : MxSync) -> Attr {
  attr("mx-trigger", event + " queue:" + mode.to_string())
}

///|
/// Create a trigger with filter condition
/// e.g., mx_trigger_filter("keyup", "keyCode==13") for Enter key
pub fn mx_trigger_filter(event : String, filter : String) -> Attr {
  attr("mx-trigger", event + "[" + filter + "]")
}

///|
/// Create a polling trigger
pub fn mx_trigger_every(interval_ms : Int) -> Attr {
  attr("mx-trigger", "every " + interval_ms.to_string() + "ms")
}

// =============================================================================
// Server-Sent Events (SSE)
// =============================================================================

///|
/// mx-sse-connect: Connect to SSE endpoint
pub fn mx_sse_connect(url : String) -> Attr {
  attr("mx-sse-connect", url)
}

///|
/// mx-sse-swap: Swap content when SSE message received
pub fn mx_sse_swap(event_name : String) -> Attr {
  attr("mx-sse-swap", event_name)
}

// =============================================================================
// WebSocket
// =============================================================================

///|
/// mx-ws-connect: Connect to WebSocket endpoint
pub fn mx_ws_connect(url : String) -> Attr {
  attr("mx-ws-connect", url)
}

///|
/// mx-ws-send: Send data to WebSocket on trigger
pub fn mx_ws_send() -> Attr {
  bool_attr("mx-ws-send")
}
