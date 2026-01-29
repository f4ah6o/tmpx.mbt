///|
pub fn html_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Html.element(attrs, children)
}

///|
pub fn head(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Head.element(attrs, children)
}

///|
pub fn body(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Body.element(attrs, children)
}

///|
pub fn title(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Title.element(attrs, children)
}

///|
pub fn base(attrs : Array[Attr]) -> Node {
  Tag::Base.void_element(attrs)
}

///|
pub fn link(attrs : Array[Attr]) -> Node {
  Tag::Link.void_element(attrs)
}

///|
pub fn meta(attrs : Array[Attr]) -> Node {
  Tag::Meta.void_element(attrs)
}

///|
pub fn style_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Style.element(attrs, children)
}

///|
pub fn script(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Script.element(attrs, children)
}

///|
pub fn noscript(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Noscript.element(attrs, children)
}

///|
pub fn address(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Address.element(attrs, children)
}

///|
pub fn article(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Article.element(attrs, children)
}

///|
pub fn aside(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Aside.element(attrs, children)
}

///|
pub fn footer(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Footer.element(attrs, children)
}

///|
pub fn header_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Header.element(attrs, children)
}

///|
pub fn h1(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H1.element(attrs, children)
}

///|
pub fn h2(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H2.element(attrs, children)
}

///|
pub fn h3(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H3.element(attrs, children)
}

///|
pub fn h4(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H4.element(attrs, children)
}

///|
pub fn h5(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H5.element(attrs, children)
}

///|
pub fn h6(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::H6.element(attrs, children)
}

///|
pub fn hgroup(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Hgroup.element(attrs, children)
}

///|
pub fn main_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Main.element(attrs, children)
}

///|
pub fn nav(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Nav.element(attrs, children)
}

///|
pub fn section(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Section.element(attrs, children)
}

///|
pub fn search(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Search.element(attrs, children)
}

///|
pub fn blockquote(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Blockquote.element(attrs, children)
}

///|
pub fn div(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Div.element(attrs, children)
}

///|
pub fn dl(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dl.element(attrs, children)
}

///|
pub fn dt(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dt.element(attrs, children)
}

///|
pub fn dd(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dd.element(attrs, children)
}

///|
pub fn figure(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Figure.element(attrs, children)
}

///|
pub fn figcaption(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Figcaption.element(attrs, children)
}

///|
pub fn hr(attrs : Array[Attr]) -> Node {
  Tag::Hr.void_element(attrs)
}

///|
pub fn li(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Li.element(attrs, children)
}

///|
pub fn menu(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Menu.element(attrs, children)
}

///|
pub fn ol(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ol.element(attrs, children)
}

///|
pub fn p(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::P.element(attrs, children)
}

///|
pub fn pre(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Pre.element(attrs, children)
}

///|
pub fn ul(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ul.element(attrs, children)
}

///|
pub fn a(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::A.element(attrs, children)
}

///|
pub fn abbr(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Abbr.element(attrs, children)
}

///|
pub fn b(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::B.element(attrs, children)
}

///|
pub fn bdi(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Bdi.element(attrs, children)
}

///|
pub fn bdo(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Bdo.element(attrs, children)
}

///|
pub fn br() -> Node {
  Tag::Br.void_element([])
}

///|
pub fn cite(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Cite.element(attrs, children)
}

///|
pub fn code(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Code.element(attrs, children)
}

///|
pub fn data(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Data.element(attrs, children)
}

///|
pub fn dfn(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dfn.element(attrs, children)
}

///|
pub fn em(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Em.element(attrs, children)
}

///|
pub fn i(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::I.element(attrs, children)
}

///|
pub fn kbd(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Kbd.element(attrs, children)
}

///|
pub fn mark(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Mark.element(attrs, children)
}

///|
pub fn q(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Q.element(attrs, children)
}

///|
pub fn ruby(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ruby.element(attrs, children)
}

///|
pub fn rp(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Rp.element(attrs, children)
}

///|
pub fn rt(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Rt.element(attrs, children)
}

///|
pub fn s(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::S.element(attrs, children)
}

///|
pub fn samp(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Samp.element(attrs, children)
}

///|
pub fn small(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Small.element(attrs, children)
}

///|
pub fn span(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Span.element(attrs, children)
}

///|
pub fn strong(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Strong.element(attrs, children)
}

///|
pub fn sub(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Sub.element(attrs, children)
}

///|
pub fn sup(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Sup.element(attrs, children)
}

///|
pub fn time(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Time.element(attrs, children)
}

///|
pub fn u(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::U.element(attrs, children)
}

///|
pub fn var_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Var.element(attrs, children)
}

///|
pub fn wbr(attrs : Array[Attr]) -> Node {
  Tag::Wbr.void_element(attrs)
}

///|
pub fn area(attrs : Array[Attr]) -> Node {
  Tag::Area.void_element(attrs)
}

///|
pub fn audio(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Audio.element(attrs, children)
}

///|
pub fn img(attrs : Array[Attr]) -> Node {
  Tag::Img.void_element(attrs)
}

///|
pub fn map(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Map.element(attrs, children)
}

///|
pub fn picture(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Picture.element(attrs, children)
}

///|
pub fn source(attrs : Array[Attr]) -> Node {
  Tag::Source.void_element(attrs)
}

///|
pub fn track(attrs : Array[Attr]) -> Node {
  Tag::Track.void_element(attrs)
}

///|
pub fn video(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Video.element(attrs, children)
}

///|
pub fn canvas(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Canvas.element(attrs, children)
}

///|
pub fn embed(attrs : Array[Attr]) -> Node {
  Tag::Embed.void_element(attrs)
}

///|
pub fn iframe(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Iframe.element(attrs, children)
}

///|
pub fn object_(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Object.element(attrs, children)
}

///|
pub fn param(attrs : Array[Attr]) -> Node {
  Tag::Param.void_element(attrs)
}

///|
pub fn svg(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Svg.element(attrs, children)
}

///|
pub fn math(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Math.element(attrs, children)
}

///|
pub fn del(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Del.element(attrs, children)
}

///|
pub fn ins(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Ins.element(attrs, children)
}

///|
pub fn table(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Table.element(attrs, children)
}

///|
pub fn caption(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Caption.element(attrs, children)
}

///|
pub fn colgroup(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Colgroup.element(attrs, children)
}

///|
pub fn col(attrs : Array[Attr]) -> Node {
  Tag::Col.void_element(attrs)
}

///|
pub fn tbody(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Tbody.element(attrs, children)
}

///|
pub fn thead(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Thead.element(attrs, children)
}

///|
pub fn tfoot(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Tfoot.element(attrs, children)
}

///|
pub fn tr(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Tr.element(attrs, children)
}

///|
pub fn th(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Th.element(attrs, children)
}

///|
pub fn td(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Td.element(attrs, children)
}

///|
pub fn button(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Button.element(attrs, children)
}

///|
pub fn datalist(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Datalist.element(attrs, children)
}

///|
pub fn fieldset(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Fieldset.element(attrs, children)
}

///|
pub fn form(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Form.element(attrs, children)
}

///|
pub fn input_(attrs : Array[Attr]) -> Node {
  Tag::Input.void_element(attrs)
}

///|
pub fn label(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Label.element(attrs, children)
}

///|
pub fn legend(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Legend.element(attrs, children)
}

///|
pub fn meter(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Meter.element(attrs, children)
}

///|
pub fn optgroup(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Optgroup.element(attrs, children)
}

///|
pub fn option(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Option.element(attrs, children)
}

///|
pub fn output(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Output.element(attrs, children)
}

///|
pub fn progress(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Progress.element(attrs, children)
}

///|
pub fn select(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Select.element(attrs, children)
}

///|
pub fn textarea(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Textarea.element(attrs, children)
}

///|
pub fn details(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Details.element(attrs, children)
}

///|
pub fn dialog(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dialog.element(attrs, children)
}

///|
pub fn summary(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Summary.element(attrs, children)
}

///|
pub fn slot(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Slot.element(attrs, children)
}

///|
pub fn template(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Template.element(attrs, children)
}

///|
pub fn acronym(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Acronym.element(attrs, children)
}

///|
pub fn applet(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Applet.element(attrs, children)
}

///|
pub fn basefont(attrs : Array[Attr]) -> Node {
  Tag::Basefont.void_element(attrs)
}

///|
pub fn bgsound(attrs : Array[Attr]) -> Node {
  Tag::Bgsound.void_element(attrs)
}

///|
pub fn big(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Big.element(attrs, children)
}

///|
pub fn blink(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Blink.element(attrs, children)
}

///|
pub fn center(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Center.element(attrs, children)
}

///|
pub fn dir(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Dir.element(attrs, children)
}

///|
pub fn font(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Font.element(attrs, children)
}

///|
pub fn frame(attrs : Array[Attr]) -> Node {
  Tag::Frame.void_element(attrs)
}

///|
pub fn frameset(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Frameset.element(attrs, children)
}

///|
pub fn isindex(attrs : Array[Attr]) -> Node {
  Tag::Isindex.void_element(attrs)
}

///|
pub fn keygen(attrs : Array[Attr]) -> Node {
  Tag::Keygen.void_element(attrs)
}

///|
pub fn listing(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Listing.element(attrs, children)
}

///|
pub fn marquee(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Marquee.element(attrs, children)
}

///|
pub fn menuitem(attrs : Array[Attr]) -> Node {
  Tag::Menuitem.void_element(attrs)
}

///|
pub fn multicol(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Multicol.element(attrs, children)
}

///|
pub fn nextid(attrs : Array[Attr]) -> Node {
  Tag::Nextid.void_element(attrs)
}

///|
pub fn nobr(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Nobr.element(attrs, children)
}

///|
pub fn noembed(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Noembed.element(attrs, children)
}

///|
pub fn noframes(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Noframes.element(attrs, children)
}

///|
pub fn plaintext(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Plaintext.element(attrs, children)
}

///|
pub fn spacer(attrs : Array[Attr]) -> Node {
  Tag::Spacer.void_element(attrs)
}

///|
pub fn strike(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Strike.element(attrs, children)
}

///|
pub fn tt(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Tt.element(attrs, children)
}

///|
pub fn xmp(attrs : Array[Attr], children : Array[Node]) -> Node {
  Tag::Xmp.element(attrs, children)
}
