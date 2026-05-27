import wasmUrl from "../../../_build/wasm-gc/debug/build/wasm_preview/wasm_preview.wasm?url";
import "./style.css";

const input = document.querySelector("#input");
const preview = document.querySelector("#preview");

const sample = {
  title: "tmpx browser preview",
  body: [
    { type: "h1", text: "Hello from MoonBit Wasm" },
    { type: "p", text: "All text and attributes are escaped by tmpx." },
    { type: "a", href: "/search?q=<tmpx>&safe=true", text: "Escaped link" },
    { type: "code", text: "<script>alert('not raw')</script>" },
    { type: "ul", items: ["h1", "p", "code", "a", "ul", "ol"] }
  ]
};

input.value = JSON.stringify(sample, null, 2);

let renderFragment = () => "<p>Loading preview renderer...</p>";

async function initMoonBit() {
  const { instance } = await WebAssembly.instantiateStreaming(
    fetch(wasmUrl),
    {},
    { builtins: ["js-string"], importedStringConstants: "_" }
  );
  renderFragment = instance.exports.render_fragment;
  update();
}

function update() {
  preview.innerHTML = renderFragment(input.value);
}

input.addEventListener("input", update);
update();
initMoonBit();
