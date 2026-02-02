///|
test "head smoke renders document structure" {
  let node = html_parts([
    part_child(head_parts([
      part_child(title_parts([part_text("Doc")])),
      part_child(meta_attrs([
        attr("name", "viewport"),
        attr("content", "width=device-width"),
      ])),
      part_child(link_attrs([
        attr("rel", "stylesheet"),
        href("/site.css"),
      ])),
    ])),
    part_child(body_parts([part_text("Hi")])),
  ])
  inspect(
    render(node),
    content=(
      "<html><head><title>Doc</title>" +
      "<meta content=\"width=device-width\" name=\"viewport\">" +
      "<link href=\"/site.css\" rel=\"stylesheet\"></head>" +
      "<body>Hi</body></html>"
    ),
  )
}
