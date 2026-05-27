const HTML_HEADERS = {
  "Content-Type": "text/html; charset=utf-8",
};

function renderSearchResults(q: string): string {
  if (!q) return "<em>No query provided.</em>";
  const items = [q, `${q} alpha`, `${q} beta`].map(
    (item) => `<li>${item}</li>`
  );
  return `<div><strong>Results for:</strong> ${q}</div><ul>${items.join("")}</ul>`;
}

async function readQuery(request: Request, url: URL): Promise<string> {
  if (request.method.toUpperCase() !== "POST") {
    return url.searchParams.get("q") ?? "";
  }
  const body = await request.text();
  const data = new URLSearchParams(body);
  return data.get("q") ?? "";
}

export async function onRequest(context: EventContext<unknown, string, unknown>): Promise<Response> {
  const url = new URL(context.request.url);
  const q = await readQuery(context.request, url);
  return new Response(renderSearchResults(q), { headers: HTML_HEADERS });
}
