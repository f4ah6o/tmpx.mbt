///|
test "inline code semantics render and respect safety boundary" {
  let node = p_parts([
    part_child(i_parts([part_text("italic") ])),
    part_child(b_parts([part_text("bold") ])),
    part_child(samp_parts([part_child(raw("<em>raw</em>"))])),
    part_child(var_parts([part_text("x < y") ])),
    part_child(ruby_parts([
      part_text("漢"),
      part_child(rp_parts([part_text("(")])),
      part_child(rt_parts([part_text("a < b") ])),
      part_child(rp_parts([part_text(")") ])),
    ])),
  ])
  inspect(
    render(node),
    content=(
      "<p><i>italic</i><b>bold</b><samp><em>raw</em></samp><var>x &lt; y</var>" +
      "<ruby>漢<rp>(</rp><rt>a &lt; b</rt><rp>)</rp></ruby></p>"
    ),
  )
}
