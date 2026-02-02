///|
test "details/summary renders structure and escapes" {
  let node = details_parts([
    part_child(summary_parts([part_text("More <info>")])),
    part_child(p_parts([part_text("Body & more")])),
  ])
  inspect(
    render(node),
    content="<details><summary>More &lt;info&gt;</summary><p>Body &amp; more</p></details>",
  )
}
