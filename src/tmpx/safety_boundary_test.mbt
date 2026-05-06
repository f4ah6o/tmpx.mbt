///|
test "text and attribute values escape by default" {
  let node = div_parts([
    part_attr(attr("title", "\"quoted\" <unsafe>")),
    part_text("<script>alert('x')</script>"),
  ])
  inspect(
    render(node),
    content="<div title=\"&quot;quoted&quot; &lt;unsafe&gt;\">&lt;script&gt;alert(&#39;x&#39;)&lt;/script&gt;</div>",
  )
}

///|
test "raw aliases remain explicit unsafe escape hatches" {
  let node = fragment([
    text("<safe>"),
    raw("<b>raw</b>"),
    raw_trusted_html("<i>trusted</i>"),
    raw_unsafe("<u>unsafe</u>"),
  ])
  inspect(
    render(node),
    content="&lt;safe&gt;<b>raw</b><i>trusted</i><u>unsafe</u>",
  )
}

///|
test "part_text and fragments preserve the same safety boundary" {
  let node = div_parts([
    part_child(fragment([text("<a>"), raw("<span>ok</span>")])),
    part_text("&done"),
  ])
  inspect(render(node), content="<div>&lt;a&gt;<span>ok</span>&amp;done</div>")
}
