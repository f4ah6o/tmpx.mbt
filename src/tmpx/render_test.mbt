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

///|
test "render table elements" {
  let node = table([], [
    caption([], [text("Scores")]),
    colgroup([], [col([attr("span", "2")])]),
    thead([], [tr([], [th([], [text("Name")]), th([], [text("Score")])])]),
    tbody([], [tr([], [td([], [text("Ada")]), td([], [text("42")])])]),
    tfoot([], [tr([], [td([attr("colspan", "2")], [text("Total")])])]),
  ])
  inspect(
    render(node),
    content="<table><caption>Scores</caption><colgroup><col span=\"2\"></colgroup><thead><tr><th>Name</th><th>Score</th></tr></thead><tbody><tr><td>Ada</td><td>42</td></tr></tbody><tfoot><tr><td colspan=\"2\">Total</td></tr></tfoot></table>",
  )
}

///|
test "render metadata and sectioning elements" {
  let nodes = [
    base([href("/base"), attr("target", "_blank")]),
    noscript([], [text("noscript")]),
    address([], [text("addr")]),
    hgroup([], [h1([], [text("Title")]), p([], [text("Subtitle")])]),
    search(
      [],
      [
        form(
          [attr("role", "search")],
          [input_([type_("search"), name_("q")])],
        ),
      ],
    ),
    blockquote([], [text("quote")]),
    dl([], [dt([], [text("Term")]), dd([], [text("Def")])]),
    figure(
      [],
      [img([src("/fig.png"), attr("alt", "fig")]), figcaption([], [text("cap")])],
    ),
    menu([], [li([], [text("one")])]),
  ]
  let expected = [
    "<base href=\"/base\" target=\"_blank\">",
    "<noscript>noscript</noscript>",
    "<address>addr</address>",
    "<hgroup><h1>Title</h1><p>Subtitle</p></hgroup>",
    "<search><form role=\"search\"><input type=\"search\" name=\"q\"></form></search>",
    "<blockquote>quote</blockquote>",
    "<dl><dt>Term</dt><dd>Def</dd></dl>",
    "<figure><img src=\"/fig.png\" alt=\"fig\"><figcaption>cap</figcaption></figure>",
    "<menu><li>one</li></menu>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render inline text semantics (1)" {
  let nodes = [
    abbr([attr("title", "abbrev")], [text("abbr")]),
    b([], [text("b")]),
    bdi([], [text("bdi")]),
    bdo([attr("dir", "rtl")], [text("bdo")]),
    cite([], [text("cite")]),
    data([value_("1")], [text("one")]),
    dfn([], [text("dfn")]),
    i([], [text("i")]),
    kbd([], [text("kbd")]),
    mark([], [text("mark")]),
  ]
  let expected = [
    "<abbr title=\"abbrev\">abbr</abbr>",
    "<b>b</b>",
    "<bdi>bdi</bdi>",
    "<bdo dir=\"rtl\">bdo</bdo>",
    "<cite>cite</cite>",
    "<data value=\"1\">one</data>",
    "<dfn>dfn</dfn>",
    "<i>i</i>",
    "<kbd>kbd</kbd>",
    "<mark>mark</mark>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render inline text semantics (2)" {
  let nodes = [
    q([], [text("q")]),
    ruby(
      [],
      [text("ru"), rt([], [text("rt")]), rp([], [text("(")]), rp([], [text(")")])],
    ),
    s([], [text("s")]),
    samp([], [text("samp")]),
    sub([], [text("sub")]),
    sup([], [text("sup")]),
    time([attr("datetime", "2025-01-01")], [text("time")]),
    u([], [text("u")]),
    var_([], [text("var")]),
    wbr([]),
  ]
  let expected = [
    "<q>q</q>",
    "<ruby>ru<rt>rt</rt><rp>(</rp><rp>)</rp></ruby>",
    "<s>s</s>",
    "<samp>samp</samp>",
    "<sub>sub</sub>",
    "<sup>sup</sup>",
    "<time datetime=\"2025-01-01\">time</time>",
    "<u>u</u>",
    "<var>var</var>",
    "<wbr>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render media and embedded elements" {
  let nodes = [
    map(
      [attr("name", "map1")],
      [area([attr("shape", "rect"), attr("coords", "0,0,1,1"), href("/map")])],
    ),
    picture(
      [],
      [
        source([attr("srcset", "/p.webp"), attr("type", "image/webp")]),
        img([src("/p.png"), attr("alt", "p")]),
      ],
    ),
    audio(
      [bool_attr("controls")],
      [
        source([attr("src", "/a.mp3"), attr("type", "audio/mpeg")]),
        track([attr("kind", "captions"), attr("src", "/c.vtt")]),
      ],
    ),
    video(
      [bool_attr("controls")],
      [
        source([attr("src", "/v.mp4"), attr("type", "video/mp4")]),
        track([attr("kind", "subtitles"), attr("src", "/s.vtt")]),
      ],
    ),
    canvas([attr("width", "100"), attr("height", "50")], []),
    embed([attr("src", "/embed")]),
    iframe([attr("src", "/frame")], []),
    object_(
      [attr("data", "/obj")],
      [param([attr("name", "n"), attr("value", "v")])],
    ),
    svg([], [text("svg")]),
    math([], [text("math")]),
  ]
  let expected = [
    "<map name=\"map1\"><area shape=\"rect\" coords=\"0,0,1,1\" href=\"/map\"></map>",
    "<picture><source srcset=\"/p.webp\" type=\"image/webp\"><img src=\"/p.png\" alt=\"p\"></picture>",
    "<audio controls><source src=\"/a.mp3\" type=\"audio/mpeg\"><track kind=\"captions\" src=\"/c.vtt\"></audio>",
    "<video controls><source src=\"/v.mp4\" type=\"video/mp4\"><track kind=\"subtitles\" src=\"/s.vtt\"></video>",
    "<canvas width=\"100\" height=\"50\"></canvas>",
    "<embed src=\"/embed\">",
    "<iframe src=\"/frame\"></iframe>",
    "<object data=\"/obj\"><param name=\"n\" value=\"v\"></object>",
    "<svg>svg</svg>",
    "<math>math</math>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render forms and interactive elements" {
  let nodes = [
    datalist([], [option([value_("x")], [text("x")])]),
    fieldset(
      [],
      [legend([], [text("Legend")]), input_([type_("text"), name_("field")])],
    ),
    meter([value_("0.5")], [text("meter")]),
    optgroup([attr("label", "grp")], [option([value_("o")], [text("opt")])]),
    output([name_("out")], [text("42")]),
    progress([value_("1"), attr("max", "5")], []),
    details([], [summary([], [text("sum")]), p([], [text("detail")])]),
    dialog([], [text("dialog")]),
    slot([attr("name", "slot")], [text("slot")]),
    template([], [div([], [text("tmpl")])]),
  ]
  let expected = [
    "<datalist><option value=\"x\">x</option></datalist>",
    "<fieldset><legend>Legend</legend><input type=\"text\" name=\"field\"></fieldset>",
    "<meter value=\"0.5\">meter</meter>",
    "<optgroup label=\"grp\"><option value=\"o\">opt</option></optgroup>",
    "<output name=\"out\">42</output>",
    "<progress value=\"1\" max=\"5\"></progress>",
    "<details><summary>sum</summary><p>detail</p></details>",
    "<dialog>dialog</dialog>",
    "<slot name=\"slot\">slot</slot>",
    "<template><div>tmpl</div></template>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render legacy elements (formatting)" {
  let nodes = [
    acronym([], [text("acro")]),
    applet([attr("code", "Applet")], [text("applet")]),
    big([], [text("big")]),
    blink([], [text("blink")]),
    center([], [text("center")]),
    dir([], [li([], [text("item")])]),
    font([attr("color", "red")], [text("font")]),
  ]
  let expected = [
    "<acronym>acro</acronym>",
    "<applet code=\"Applet\">applet</applet>",
    "<big>big</big>",
    "<blink>blink</blink>",
    "<center>center</center>",
    "<dir><li>item</li></dir>",
    "<font color=\"red\">font</font>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render legacy elements (obsolete text)" {
  let nodes = [
    listing([], [text("listing")]),
    marquee([], [text("marquee")]),
    multicol([], [text("multicol")]),
    nobr([], [text("nobr")]),
    plaintext([], [text("plain")]),
    strike([], [text("strike")]),
    tt([], [text("tt")]),
    xmp([], [text("xmp")]),
  ]
  let expected = [
    "<listing>listing</listing>",
    "<marquee>marquee</marquee>",
    "<multicol>multicol</multicol>",
    "<nobr>nobr</nobr>",
    "<plaintext>plain</plaintext>",
    "<strike>strike</strike>",
    "<tt>tt</tt>",
    "<xmp>xmp</xmp>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}

///|
test "render legacy elements (void and frames)" {
  let nodes = [
    basefont([attr("color", "blue")]),
    bgsound([attr("src", "/bg.wav")]),
    frameset([], [frame([src("/f1")]), frame([src("/f2")])]),
    isindex([attr("prompt", "Search")]),
    keygen([attr("name", "key")]),
    menuitem([attr("label", "item")]),
    nextid([attr("n", "1")]),
    spacer([attr("size", "1")]),
    noembed([], [text("noembed")]),
    noframes([], [text("noframes")]),
  ]
  let expected = [
    "<basefont color=\"blue\">",
    "<bgsound src=\"/bg.wav\">",
    "<frameset><frame src=\"/f1\"><frame src=\"/f2\"></frameset>",
    "<isindex prompt=\"Search\">",
    "<keygen name=\"key\">",
    "<menuitem label=\"item\">",
    "<nextid n=\"1\">",
    "<spacer size=\"1\">",
    "<noembed>noembed</noembed>",
    "<noframes>noframes</noframes>",
  ].join("")
  inspect(render_nodes(nodes), content=expected)
}
