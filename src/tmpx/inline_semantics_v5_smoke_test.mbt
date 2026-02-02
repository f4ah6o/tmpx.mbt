///|
test "inline semantics v5 render and respect safety boundary" {
  let node = p_parts([
    part_child(abbr_parts([part_text("HTML <spec>")])),
    part_child(time_parts([part_text("2024-02-03")])),
    part_child(q_parts([part_child(raw("<b>raw</b>"))])),
    part_child(s_parts([part_text("old <text>")])),
    part_child(u_parts([part_text("under & over")])),
    part_child(del_parts([part_text("gone")])),
    part_child(ins_parts([part_text("new")])),
  ])
  inspect(
    render(node),
    content="<p><abbr>HTML &lt;spec&gt;</abbr><time>2024-02-03</time>" +
      "<q><b>raw</b></q><s>old &lt;text&gt;</s><u>under &amp; over</u>" +
      "<del>gone</del><ins>new</ins></p>",
  )
}
