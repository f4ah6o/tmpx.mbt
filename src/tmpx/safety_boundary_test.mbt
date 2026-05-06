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
test "raw_unsafe is a naming alias for raw" {
  let a = raw("<b>test</b>")
  let b = raw_unsafe("<b>test</b>")
  inspect(render(a), content=render(b))
}

///|
test "raw and raw_unsafe produce identical output" {
  let node = fragment([
    text("<safe>"),
    raw("<b>raw</b>"),
    raw_unsafe("<u>unsafe</u>"),
  ])
  inspect(render(node), content="&lt;safe&gt;<b>raw</b><u>unsafe</u>")
}

///|
test "part_text and fragments preserve the same safety boundary" {
  let node = div_parts([
    part_child(fragment([text("<a>"), raw("<span>ok</span>")])),
    part_text("&done"),
  ])
  inspect(render(node), content="<div>&lt;a&gt;<span>ok</span>&amp;done</div>")
}
