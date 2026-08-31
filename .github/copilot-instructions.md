# GitHub Copilot Instructions — AlihSpec Project Conversion Framework

## What is this project?

This is an **AlihSpec (Spec-Driven Development)** framework for converting a project
from one language/framework to another.

**MANDATORY**: Read `context/AGENTS.md` and `evaluate/framework-evaluation.md` for the complete project context and conversion guardrails before suggesting code.

## Key Folders

- `source/` — the ORIGINAL project (READ-ONLY, reference only, never modify)
- `reference-target/` — reference TARGET project template (READ-ONLY, optional)
- `specs/` — specifications that define what to implement (Single Source of Truth)
- `tasks/` — task list and progress tracking (`tasks/_index.md`)
- `context/` — rules (`RULES.md`), conventions, tech stack, and QA checklist (`qa-checklist.md`)
- `output/` — where ALL new target code must be written (clean slate)
- `evaluate/` — Master evaluation guide (`framework-evaluation.md`) and case studies hub

## 🚨 Critical Conversion Guardrails

1. **Never suggest changes to files inside `source/` or `reference-target/`**
2. **All code suggestions must target `output/` folder**
3. **Follow architecture defined in `specs/architecture.md`** (Clean Architecture: Handler ➔ Service ➔ Repository ➔ Domain)
4. **Follow naming & coding conventions in `context/conventions.md`**
5. **Use concept mappings from `.sdd/mapping/patterns.md`**
6. **No Dummy Code**: Never return hardcoded mock data in repository/service layer; write real DB queries.
7. **Pointer Nullability**: Use pointer types (`*int64`, `*string`, `*bool`) for optional/nullable struct fields.
8. **DateTime & Currency Parity**: Match exact date serialization format and use `int64` (cents) for currency.
9. When implementing a module, always check `specs/modules/[module].md` and `context/RULES.md` first.

## Workflow

When a user asks to implement something:
1. Check `specs/modules/[relevant].md` and verify against `context/RULES.md`.
2. Check `.sdd/mapping/patterns.md` for concept mapping.
3. Write output to the correct path under `output/` following `specs/architecture.md`.
4. Validate implementation against `context/qa-checklist.md`.

