///|
test "mhx attrs render" {
  let node = div_parts([
    part_attr(mx_get("/tasks")),
    part_attr(mx_target("#out")),
    part_attr(mx_trigger("click")),
    part_attr(mx_swap(MxSwap::AfterBegin)),
  ])
  inspect(
    render(node),
    content="<div mx-get=\"/tasks\" mx-swap=\"afterbegin\" mx-target=\"#out\" mx-trigger=\"click\"></div>",
  )
}
