# Clarify and harden the Raw HTML safety boundary

Created: 2026-05-05

Model: gh-migrate

## Summary

Clarify and harden the Raw HTML safety boundary

## Original Issue

- [GitHub #4](https://github.com/f4ah6o/tmpx.mbt/issues/4)


## Description

# Clarify and harden the Raw HTML safety boundary

## Summary

Clarify the intended safety boundary around `raw()` and make unsafe HTML insertion harder to use accidentally.

This follows the proposal in #1. tmpx already escapes text by default and exposes Raw as an explicit unsafe boundary. The next step is to document and test that boundary as a first-class contract.

## Motivation

A major value of tmpx is that normal text content is escaped by default, while raw HTML insertion is explicit. This makes tmpx suitable as a target for Markdown renderers, documentation systems, generated UI, and SSR views.

However, `raw()` should be clearly treated as trusted-content-only. The API and documentation should make this obvious.

## Proposed changes

### 1. Documentation

Add explicit README wording:

```markdown
Raw is for trusted HTML only.
Do not pass user-generated content to raw().
Use text() or part_text() for untrusted content.
```

### 2. Optional API refinement

Either keep `raw()` as-is or add clearer aliases:

```moonbit
raw_trusted_html(content: String) -> Node
raw_unsafe(content: String) -> Node
```

The goal is not necessarily to remove `raw()`, but to make the safety boundary visible in code.

### 3. Tests

Add focused tests for:

- `text("<script>")` is escaped
- `part_text("<script>")` is escaped
- attribute values are escaped
- `raw("<b>x</b>")` is inserted verbatim
- fragment rendering preserves the same rules

## Design constraints

- Preserve current Text / Raw semantics.
- Do not implicitly convert String to Raw.
- Do not introduce sanitizer behavior in tmpx core.
- Keep Raw explicit and visibly unsafe.

## Non-goals

- HTML sanitization
- Markdown parsing
- CSP management
- Runtime browser security policy
