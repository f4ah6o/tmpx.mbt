///|
test "example: basic_page" {
  let page = doctype_html(
    with_attr(
      html_document(
        [
          meta_charset_utf8(),
          title_parts([part_text("Home")]),
          stylesheet("/site.css"),
        ],
        [
          main_parts([
            part_attr(class_("page")),
            part_child(h1_parts([part_text("tmpx")])),
            part_child(p_parts([part_text("Deterministic HTML views")])),
          ]),
        ],
      ),
      attr("lang", "en"),
    ),
  )
  inspect(
    page,
    content="<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"><title>Home</title><link href=\"/site.css\" rel=\"stylesheet\"></head><body><main class=\"page\"><h1>tmpx</h1><p>Deterministic HTML views</p></main></body></html>",
  )
}

///|
test "example: form_post" {
  let form = form_parts([
    part_attr(action("/submit")),
    part_attr(method_("post")),
    part_child(
      label_parts([part_attr(attr("for", "email")), part_text("Email")]),
    ),
    part_child(
      input_attrs([
        type_("email"),
        name_("email"),
        placeholder("you@example.com"),
        required(),
      ]),
    ),
    part_child(button_parts([part_attr(type_("submit")), part_text("Send")])),
  ])
  inspect(
    render(form),
    content="<form action=\"/submit\" method=\"post\"><label for=\"email\">Email</label><input name=\"email\" placeholder=\"you@example.com\" required type=\"email\"><button type=\"submit\">Send</button></form>",
  )
}

///|
test "example: mhx_counter" {
  let node = div_parts([
    part_attr(id_("counter")),
    part_child(
      button_parts([
        part_attr(type_("button")),
        part_attr(mx_post("/counter/increment")),
        part_attr(mx_target("#counter")),
        part_attr(mx_swap(InnerHTML)),
        part_text("Increment"),
      ]),
    ),
  ])
  inspect(
    render(node),
    content="<div id=\"counter\"><button mx-post=\"/counter/increment\" mx-swap=\"innerHTML\" mx-target=\"#counter\" type=\"button\">Increment</button></div>",
  )
}

///|
test "example: docs_page" {
  let article = wrap(
    article_parts([
      part_child(h1_parts([part_text("Guide")])),
      part_child(p_parts([part_text("Use text() for untrusted content.")])),
      part_child(pre_parts([part_child(code_parts([part_text("moon test")]))])),
    ]),
    fn(node) {
      section_parts([
        part_attr(class_("docs-shell")),
        part_child(
          nav_parts([part_attr(role("navigation")), part_text("Docs")]),
        ),
        part_child(node),
      ])
    },
  )
  inspect(
    render(article),
    content="<section class=\"docs-shell\"><nav role=\"navigation\">Docs</nav><article><h1>Guide</h1><p>Use text() for untrusted content.</p><pre><code>moon test</code></pre></article></section>",
  )
}

///|
test "example: golden_snapshot" {
  let snapshot = render(
    div_parts([
      part_attr(class_("snapshot")),
      part_child(
        ul_parts([
          part_child(li_parts([part_text("one")])),
          part_child(li_parts([part_text("two")])),
        ]),
      ),
    ]),
  )
  inspect(
    snapshot,
    content="<div class=\"snapshot\"><ul><li>one</li><li>two</li></ul></div>",
  )
}
