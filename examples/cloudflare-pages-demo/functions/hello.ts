const HTML_HEADERS = {
  "Content-Type": "text/html; charset=utf-8",
};

export function onRequestGet(): Response {
  return new Response("<div>Hello from Cloudflare Pages!</div>", {
    headers: HTML_HEADERS,
  });
}
