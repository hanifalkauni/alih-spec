# ⚡ AlihSpec — SDD Agent Instructions

> 📌 **This is the primary context file for AI agents.**
> Read this file COMPLETELY before doing anything else in this project.
>
> ⚡ **Vibe Coder?** Jika kamu user yang ingin full vibe coding,
> baca [`context/VIBE.md`](./VIBE.md) untuk prompt siap pakai.

---

## What Is This Project?

This is an **AlihSpec (Spec-Driven Development)** conversion project.

We are converting an existing project:
- **From**: [Source Language / Framework] (located in `source/`)
- **To**: [Target Language / Framework] (output goes in `output/`)

Your job is to help implement the conversion — writing code in `output/` —
guided by the specifications in `specs/`, following the task list in `tasks/`.

---

## 🗂️ Project Map

```
source/           ← READ-ONLY. The original project. Reference only, never modify.
reference-target/ ← READ-ONLY (OPTIONAL). Reference starter/boilerplate in target language.
specs/            ← The source of truth. Read specs BEFORE writing any code.
tasks/            ← Your work queue. Pick a task, implement it, mark it done.
context/          ← Conventions, glossary, tech stack. Read before coding.
output/           ← Where you write all new code.
docs/             ← Progress logs, decisions, changelog.
```

---

## ⚠️ Critical Rules

1. **NEVER modify anything in `source/` or `reference-target/`** — both are read-only reference materials.
2. **ALWAYS read the spec** in `specs/modules/[module].md` before implementing a module.
3. **ALWAYS write output code** to `output/` only.
4. **ALWAYS follow** the architecture in `specs/architecture.md`.
5. **ALWAYS follow** the conventions in `context/conventions.md`.
6. **UPDATE task status** in `tasks/_index.md` when you start or finish a task.
7. **REFERENCE source files** in code comments when converting specific logic.

---

## 🔄 Your Workflow

When asked to implement something, follow this order:

```
1. Read specs/modules/[relevant module].md
2. Read .sdd/mapping/patterns.md for concept mapping
3. Read context/conventions.md for naming/style rules
4. Find the relevant task in tasks/ and mark it [/] (In Progress)
5. Look at the equivalent source file in source/ for reference
6. Write the implementation in output/
7. Mark the task [x] (Done) in tasks/_index.md
```

---

## 🧠 Tech Stack (Target Project)

| Component | Technology |
|-----------|-----------|
| Language | [e.g., Go 1.22] |
| Framework | [e.g., Gin v1.9] |
| ORM | [e.g., GORM v2] |
| Database | [e.g., PostgreSQL 16] |
| Auth | [e.g., JWT — golang-jwt/jwt v5] |
| Validation | [e.g., go-playground/validator v10] |
| Config | [e.g., godotenv + envconfig] |
| Migration | [e.g., goose] |
| Testing | [e.g., testify + httptest] |

> See full details in [`context/tech-stack.md`](./tech-stack.md)

---

## 🗺️ Quick Reference: Concept Mapping

| Source Concept | Target Concept |
|---------------|----------------|
| Controller | Handler |
| Service | Service |
| Repository | Repository |
| Model | Domain struct |
| Form Request | DTO struct |
| Middleware | Gin Middleware |
| Job | Worker |
| Migration | SQL Migration / goose |

> See full mapping in [`.sdd/mapping/patterns.md`](../.sdd/mapping/patterns.md)

---

## 📋 Current Task Queue

Check [`tasks/_index.md`](../tasks/_index.md) for the current task list and progress.

When picking a task:
- Choose the **lowest-numbered** unblocked task
- Check dependencies are complete before starting
- Mark the task `[/]` when you start it

---

## 📁 Source Project Notes

> Add specific notes about the source project here.
> E.g., "The source project uses Laravel 10 with Sanctum for auth."
> "Database uses MySQL, but target uses PostgreSQL — watch for syntax differences."

- Source project root: `source/`
- Main entry point: `source/[entry file]`
- Key config: `source/[config file]`

---

## ✅ Definition of Done

A task is considered **Done** when:
1. All sub-tasks in the task file are checked ✅
2. All acceptance criteria pass ✅
3. Code follows conventions in `context/conventions.md` ✅
4. File is saved in the correct `output/` path ✅
5. Task is marked `[x]` in `tasks/_index.md` ✅
6. Any important decisions are logged in `docs/decisions.md` ✅

---

## 🚫 Common Mistakes to Avoid

- ❌ Writing code in `source/` (never)
- ❌ Skipping the spec — always read it first
- ❌ Using global variables — use dependency injection
- ❌ Putting business logic in handlers
- ❌ Direct DB access in handlers or services
- ❌ Ignoring error returns — always handle errors
- ❌ Using `fmt.Println` for logging — use the logger package
