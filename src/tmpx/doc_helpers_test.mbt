///|
test "document helpers build deterministic html documents" {
  let document = with_attr(
    html_document(
      [
        meta_charset_utf8(),
        meta_viewport(),
        title_parts([part_text("Docs")]),
        canonical("https://example.com/docs"),
        og_title("Docs"),
        og_description("Deterministic docs"),
        og_image("https://example.com/og.png"),
        twitter_card("summary_large_image"),
        stylesheet("/site.css"),
        module_script("/app.js"),
      ],
      [main_parts([part_text("Hello")])],
    ),
    attr("lang", "en"),
  )
  inspect(
    doctype_html(document),
    content="<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta content=\"width=device-width, initial-scale=1\" name=\"viewport\"><title>Docs</title><link href=\"https://example.com/docs\" rel=\"canonical\"><meta content=\"Docs\" property=\"og:title\"><meta content=\"Deterministic docs\" property=\"og:description\"><meta content=\"https://example.com/og.png\" property=\"og:image\"><meta content=\"summary_large_image\" name=\"twitter:card\"><link href=\"/site.css\" rel=\"stylesheet\"><script src=\"/app.js\" type=\"module\"></script></head><body><main>Hello</main></body></html>",
  )
}
