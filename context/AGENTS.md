# ⚡ AlihSpec — Master AI Agent Instructions

> 📌 **This is the primary context file for AI agents.**
> Read this file COMPLETELY before doing anything else in this project.
>
> ⚡ **Vibe Coder?** Jika kamu user yang ingin full vibe coding,
> baca [`context/VIBE.md`](./VIBE.md) untuk prompt siap pakai.
>
> 🔬 **Master Evaluation & Lessons Guide**: Baca [`evaluate/framework-evaluation.md`](../evaluate/framework-evaluation.md) untuk panduan 16 Pilar Universal, 7 Golden Directives, dan pencegahan *Shallow Specs*.

---

## What Is This Project?

This is an **AlihSpec (Spec-Driven Development)** conversion project.

We are converting an existing project:
- **From**: [Source Language / Framework] (located in `source/`)
- **To**: [Target Language / Framework] (output goes in `output/`)
- **Reference Target (Optional)**: [Target Template/Boilerplate] (located in `reference-target/`)

Your job is to help implement the conversion — writing clean, production-ready code in `output/` —
guided strictly by the specifications in `specs/`, following the task list in `tasks/`.

---

## 🗂️ Project Map

```
source/           ➔ READ-ONLY. The original project. Reference only, never modify.
reference-target/ ➔ READ-ONLY (OPTIONAL). Reference starter/boilerplate in target language.
specs/            ➔ The single source of truth. Read specs BEFORE writing any code.
tasks/            ➔ Your work queue. Pick a task, implement it, mark it done.
context/          ➔ Rules, conventions, glossary, tech stack. Read before coding.
output/           ➔ Where you write all new code (clean slate).
docs/             ➔ Progress logs, decisions, changelog, benchmark.
evaluate/         ➔ Deep inspection guide, 16 universal pillars, & anti-shallow spec case studies.
.agents/skills/   ➔ Native AI agent skill definition & procedural references.
```

---

## 🚨 7 Golden Directives for AI Agents (MANDATORY)

To prevent **Logic Drift** and **Shallow Specifications**, every AI Agent **MUST** follow these 7 rules:

### 1. 🔍 Deep Controller AST Inspection (Bedah Kode Sumber Baris-demi-Baris)
- **DO NOT** just read function names, routes, or model names superficially.
- You **MUST** inspect the entire source controller line-by-line:
  - All query parameters (`menu`, `tab`, `filter`, `limit`, `offset`, `search`, etc.).
  - All branching logic (`if ($param == ...)`, `switch-case`, conditional aggregations).
  - All DB queries (Table Joins, GroupBy, SelectRaw, Subqueries, Having).
  - All validation rules and error status codes.

### 2. 🧱 Iterative Per-Module Execution (Dilarang Bulk Processing)
- **DO NOT** process specs for the entire project all at once if endpoints > 10.
- Execute module-by-module in an iterative loop:
  `[ 1. Spec Modul A ] ➔ [ 2. Validate Spec vs Source ] ➔ [ 3. Tasks Modul A ] ➔ [ 4. Code Modul A ] ➔ [ 5. QA Modul A ]`

### 3. 🎯 Pointer Nullability Parity (Pointer pada Struct Target)
- In dynamic languages (PHP, JS, Python), optional fields can be `null`.
- In Go / TypeScript, you **MUST** use **pointer types** (`*int64`, `*string`, `*bool`) for optional/nullable JSON fields.
- This prevents `nil` from rendering as false default zero-values (`0` or `""`) in JSON responses.

### 4. 🚫 Strict No Dummy Fallback (Dilarang Hardcoded Dummy Data)
- **STRICTLY PROHIBITED**: Returning fake hardcoded dummy values (e.g. `return 5000, nil` or `[]map{}`) in Repository or Handler layers.
- Every Repository method must execute real GORM/ORM/SQL queries against the database schema.

### 5. 📋 Spec Definition of Done (DoD) Checklist
Every `specs/modules/[module].md` MUST pass the DoD checklist before coding:
- [ ] Validation & Query Parity: All query params and validation rules captured in DTOs.
- [ ] Branching Parity: All internal if/switch business branches captured in specs.
- [ ] SQL & Join Parity: All source table joins and aggregations documented.
- [ ] Pointer Nullability: All optional fields typed as pointers.

### 6. 🛑 Checkpoint 1: Spec vs. Source Alignment (Pre-Task Validation)
Before creating tasks in `tasks/`, cross-verify that:
- Every controller method in `source/` has a complete matching endpoint in `specs/modules/`.
- All response JSON variations (base mode vs query param modes) are fully modeled in DTOs.

### 7. 🛑 Checkpoint 2: Task vs. Spec Alignment (Pre-Code Validation)
Before writing code in `output/`, verify that:
- The task in `tasks/` specifies every DTO struct, interface, repository query, and test case defined in the spec.
- Foundational dependencies (DB connection, migrations, base entities) are complete before handlers/use cases.

---

## ⚡ Execution Workflow with Dual Checkpoints

```
[Phase 1] ➔ Deep Source Inspection (line-by-line)
[Phase 2] ➔ Write Spec with DoD Checklist in specs/modules/
              ↳ 🛑 CHECKPOINT 1: Spec vs Source Cross-Validation
[Phase 3] ➔ Break down atomic tasks in tasks/
              ↳ 🛑 CHECKPOINT 2: Task vs Spec Alignment
[Phase 4] ➔ Implement in output/ (DTO ➔ Domain ➔ Repo ➔ Service ➔ Handler)
[Phase 5] ➔ Run tests & QA Checklist (Zero dummy values, 100% parity)
```

---

## 📐 Tech Stack (Target Project)

| Component | Technology |
|---|---|
| Language | [e.g., Go 1.22 / TypeScript 5.4 / Python 3.12] |
| Framework | [e.g., Gin / Fiber / NestJS / FastAPI] |
| ORM | [e.g., GORM v2 / Prisma / SQLAlchemy 2.0] |
| Database | [e.g., PostgreSQL 16 / MySQL 8.0] |
| Auth | [e.g., JWT — golang-jwt/jwt v5] |
| Validation | [e.g., go-playground/validator v10 / Pydantic v2] |
| Config | [e.g., godotenv + envconfig] |
| Testing | [e.g., testify + httptest] |

> See full details in [`context/tech-stack.md`](./tech-stack.md)

---

## 📊 Definition of Done (Task Level)

A task is considered **Done** when:
1. All sub-tasks in the task file are checked ✅.
2. All acceptance criteria from the spec pass ✅.
3. No hardcoded dummy data exists in repository/service layer ✅.
4. Pointer types are used for all optional/nullable fields ✅.
5. Code follows conventions in `context/conventions.md` ✅.
6. File is saved in the correct `output/` path ✅.
7. Task is marked `[x]` in `tasks/_index.md` ✅.
8. Any architectural decisions are logged in `docs/decisions.md` ✅.

---

## 🚫 Common Mistakes to Avoid

- ❌ Writing code in `source/` or `reference-target/` (never modify them!)
- ❌ Writing shallow specs (missing query parameters or if/else branches)
- ❌ Returning hardcoded dummy data (`return 0, nil`) instead of writing real DB queries
- ❌ Using non-pointer types for nullable fields (causing false zero-values in JSON)
- ❌ Skipping the spec — always inspect source and write spec first
- ❌ Putting business logic in HTTP handlers — always use service/usecase layer
- ❌ Direct DB access in handlers — always use repository interfaces
