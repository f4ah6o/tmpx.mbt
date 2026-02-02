# tmpx.mbt AGENTS (Entry Point)

This file is the entry point for the repository. The authoritative contract and
API surface live in `src/tmpx/AGENTS.md`.

## Goals & Contract (short)

- Supported surface is defined by the published builder batches.
- Deterministic rendering (AttrSet normalization + fixed attribute order + void policy).
- Safety boundary: Text escapes by default; Raw is explicit unsafe.
- mhx-only helpers; htmx helpers are intentionally omitted.

## References

- `src/tmpx/AGENTS.md` (contract + API)
- `src/tmpx/MIGRATION.md` (migration notes)
- `src/tmpx/FEEDBACK.md` (feedback)

## Deferred (beta)

Out of scope for now: `svg`, `math`, `canvas`, `script`, `style`.

## Commands

- `moon test`
- `moon info`
