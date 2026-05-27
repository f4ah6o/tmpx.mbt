///|
test "sample output" {
  inspect(
    render_fragment(
      (
        #|{"title":"Demo","body":[{"type":"h1","text":"Hello"},{"type":"p","text":"World"},{"type":"code","text":"let x = 1"}]}
      ),
    ),
    content="<h1>Hello</h1><p>World</p><pre><code>let x = 1</code></pre>",
  )
}

///|
test "text and href escaping" {
  inspect(
    render_fragment(
      (
        #|{"title":"Escaping","body":[{"type":"p","text":"<b>&\"'"},{"type":"a","href":"/?q=<x>&name=\"a\"","text":"link & <safe>"}]}
      ),
    ),
    content=(
      #|<p>&lt;b&gt;&amp;&quot;&#39;</p><a href="/?q=&lt;x&gt;&amp;name=&quot;a&quot;">link &amp; &lt;safe&gt;</a>
    ),
  )
}

///|
test "document title is escaped" {
  inspect(
    render_doc(
      "{\"title\":\"<Preview & \\\"safe\\\">\",\"body\":[{\"type\":\"p\",\"text\":\"Body\"}]}",
    ),
    content=(
      #|<!doctype html><html><head><meta charset="utf-8"><title>&lt;Preview &amp; &quot;safe&quot;&gt;</title></head><body><p>Body</p></body></html>
    ),
  )
}

///|
test "lists are deterministic" {
  inspect(
    render_fragment(
      (
        #|{"title":"Lists","body":[{"type":"ul","items":["a","b"]},{"type":"ol","items":["1","2"]}]}
      ),
    ),
    content="<ul><li>a</li><li>b</li></ul><ol><li>1</li><li>2</li></ol>",
  )
}

///|
test "empty body renders empty fragment" {
  inspect(render_fragment("{\"title\":\"Empty\",\"body\":[]}"), content="")
}

///|
test "invalid json returns safe error fragment" {
  inspect(render_fragment("{"), content="<p>Invalid preview document</p>")
}

///|
test "unknown shape returns safe error fragment" {
  inspect(
    render_fragment(
      "{\"title\":\"Bad\",\"body\":[{\"type\":\"script\",\"text\":\"alert(1)\"}]}",
    ),
    content="<p>Invalid preview document</p>",
  )
}
