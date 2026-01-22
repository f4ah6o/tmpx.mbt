///|
test "render escapes text and attributes" {
  let node = div(
    [
      id_("main"),
      class_list(["a", "", "b"]),
      attr("data-msg", "Hello <World> & \"Moon\""),
    ],
    [text("Hi <Moon> & \"Stars\"")],
  )
  inspect(
    render(node),
    content="<div id=\"main\" class=\"a b\" data-msg=\"Hello &lt;World&gt; &amp; &quot;Moon&quot;\">Hi &lt;Moon&gt; &amp; &quot;Stars&quot;</div>",
  )
}

///|
test "render handles void and fragment" {
  let nodes = [
    fragment([
      img([src("/img.png"), attr("alt", "preview")]),
      br(),
      hr([class_("sep")]),
    ]),
    raw_html("<span>raw</span>"),
  ]
  inspect(
    render_nodes(nodes),
    content="<img src=\"/img.png\" alt=\"preview\"><br><hr class=\"sep\"><span>raw</span>",
  )
}
