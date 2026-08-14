# GitHub Copilot Instructions — AlihSpec Project Conversion Framework

## What is this project?

This is an **AlihSpec (Spec-Driven Development)** framework for converting a project
from one language/framework to another.

Read `context/AGENTS.md` for the full project context before suggesting code.

## Key Folders

- `source/` — the ORIGINAL project (read-only, reference only)
- `reference-target/` — reference TARGET project template (optional, read-only)
- `specs/` — specifications that define what to implement
- `tasks/` — task list and progress tracking
- `context/` — conventions, glossary, tech stack for the TARGET project
- `output/` — where ALL new code should be written

## Rules

1. **Never suggest changes to files inside `source/` or `reference-target/`**
2. **All code suggestions should target `output/` folder**
3. **Follow architecture defined in `specs/architecture.md`**
4. **Follow naming conventions in `context/conventions.md`**
5. **Use concept mappings from `.sdd/mapping/patterns.md`**
6. When implementing a module, always check `specs/modules/[module].md` first

## Workflow

When a user asks to implement something:
1. Check `specs/modules/[relevant].md` for the specification
2. Check `.sdd/mapping/patterns.md` for concept mapping
3. Write output to the correct path under `output/`
4. Follow the folder structure in `specs/architecture.md`

## Style

Follow all conventions in `context/conventions.md` and `context/glossary.md`.
