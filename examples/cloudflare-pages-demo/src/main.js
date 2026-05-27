import wasmUrl from "../../../_build/wasm-gc/debug/build/wasm_preview/wasm_preview.wasm?url";
import "./style.css";

const hello = document.querySelector("#hello");
const searchForm = document.querySelector("#search-form");
const query = document.querySelector("#q");
const results = document.querySelector("#results");
const input = document.querySelector("#input");
const preview = document.querySelector("#preview");

const sample = {
  title: "tmpx browser preview",
  body: [
    { type: "h1", text: "Hello from MoonBit Wasm" },
    { type: "p", text: "This Cloudflare Pages demo reuses tmpx's wasm-gc build." },
    { type: "a", href: "/search?q=<tmpx>&safe=true", text: "Escaped link" },
    { type: "code", text: "<script>alert('not raw')</script>" },
    { type: "ul", items: ["h1", "p", "code", "a", "ul", "ol"] }
  ]
};

input.value = JSON.stringify(sample, null, 2);

let renderFragment = () => "<p>Loading preview renderer...</p>";
let searchTimer = 0;

async function swapFrom(response) {
  results.innerHTML = await response.text();
}

async function loadHello() {
  await swapFrom(await fetch("/hello"));
}

async function loadSearchFromQuery() {
  const params = new URLSearchParams({ q: query.value });
  await swapFrom(await fetch(`/search?${params}`));
}

async function submitSearch(event) {
  event.preventDefault();
  await swapFrom(
    await fetch("/search", {
      method: "POST",
      body: new URLSearchParams(new FormData(searchForm))
    })
  );
}

function queueSearch() {
  clearTimeout(searchTimer);
  searchTimer = setTimeout(loadSearchFromQuery, 300);
}

async function initMoonBit() {
  const { instance } = await WebAssembly.instantiateStreaming(
    fetch(wasmUrl),
    {},
    { builtins: ["js-string"], importedStringConstants: "_" }
  );
  renderFragment = instance.exports.render_fragment;
  updatePreview();
}

function updatePreview() {
  preview.innerHTML = renderFragment(input.value);
}

hello.addEventListener("click", loadHello);
searchForm.addEventListener("submit", submitSearch);
query.addEventListener("input", queueSearch);
input.addEventListener("input", updatePreview);

updatePreview();
initMoonBit();
