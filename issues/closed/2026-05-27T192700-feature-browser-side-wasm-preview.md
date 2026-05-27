# Browser-side Wasm preview

Created: 2026-05-27
Completed: 2026-05-27
Model: GPT-5 Codex

## 背景

GitHub issue #11 では、tmpx core の安全境界を変えずに、ブラウザ上で MoonBit Wasm から HTML preview を生成する例が必要になった。

tmpx は text / attr の escaping を render 時に担保しているため、JSON input を raw HTML として扱わず、構造化された block だけを tmpx builder に変換する adapter package として実装する。

## 対応内容

- `src/wasm_preview` package を追加し、`render_fragment(json: String) -> String` と `render_doc(json: String) -> String` を公開した。
- 対応 block は `h1`, `p`, `code`, `a`, `ul`, `ol` に限定した。
- invalid JSON / unsupported shape は `<p>Invalid preview document</p>` を返す。
- `examples/wasm-preview` に Vite demo を追加した。
- README に browser-side Wasm preview と安全境界を追記した。

## 解決方法

JSON は `moonbitlang/core/json` で parse し、許可された shape だけを `f4ah6o/tmpx/tmpx` の builder に変換する。ユーザー入力は `part_text` と `href` を通るため、HTML fragment を browser 側で `innerHTML` に挿入しても raw user HTML は生成されない。
