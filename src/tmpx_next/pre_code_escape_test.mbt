///|
test "pre/code escapes text; raw bypasses" {
  let node = pre_parts([
    part_child(code_parts([part_text("<x>&\"")])),
    part_child(raw("<b>raw</b>")),
  ])
  inspect(
    render(node),
    content=(
      "<pre><code>&lt;x&gt;&amp;&quot;</code>" +
      "<b>raw</b></pre>"
    ),
  )
}
