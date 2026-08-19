# ⚡ AlihSpec — SDD AI Agent Instructions

> 📌 **Primary Agent Instructions**: Read [`context/AGENTS.md`](./context/AGENTS.md)
> All specifications, rules, task tracking, conventions, and anti-shallow spec directives are defined there.

## Project Quick Map
- 📖 **Complete Agent Instructions**: [`context/AGENTS.md`](./context/AGENTS.md)
- 🔬 **Anti-Shallow Spec & Evaluation Guide**: [`evaluate/evaluation-specs-mismatch.md`](./evaluate/evaluation-specs-mismatch.md)
- 📋 **Active Task Queue**: [`tasks/_index.md`](./tasks/_index.md)
- 🏛️ **Target Architecture**: [`specs/architecture.md`](./specs/architecture.md)
- 🎨 **Coding Conventions**: [`context/conventions.md`](./context/conventions.md)
- 🗺️ **Pattern Mapping**: [`.sdd/mapping/patterns.md`](./.sdd/mapping/patterns.md)
- 📖 **Glossary / Terminology**: [`context/glossary.md`](./context/glossary.md)
- 📜 **Business Rules**: [`context/RULES.md`](./context/RULES.md)
- 🔵 **Source Code (Read-Only Reference)**: `source/`
- 🟣 **Reference Target Template (Optional, Read-Only)**: `reference-target/`
- 🟢 **Target Output (Write Implementation Here)**: `output/`

## 🚨 7 Golden Directives
1. **Deep Controller AST Inspection**: Bedah baris-demi-baris seluruh query parameter, percabangan `if/switch`, dan table joins di controller sumber.
2. **Iterative Per-Module Execution**: Dilarang memproses spesifikasi massal (*bulk*) jika > 10 endpoint.
3. **Pointer Nullability Parity**: Gunakan pointer (`*int64`, `*string`, `*bool`) untuk field opsional/nullable di struct Go/TypeScript.
4. **Strict No Dummy Fallback**: Dilarang keras mengembalikan hardcoded dummy data (`return 5000, nil` atau `[]map{}`) di Repository/Handler.
5. **Spec Definition of Done (DoD)**: Seluruh endpoint harus lolos DoD checklist sebelum membuat task.
6. **Checkpoint 1 (Spec vs Source Alignment)**: Validasi spesifikasi terhadap controller sumber sebelum breakdown task.
7. **Checkpoint 2 (Task vs Spec Alignment)**: Validasi kriteria task terhadap spesifikasi sebelum menulis kode di `output/`.

👉 **Proceed to [`context/AGENTS.md`](./context/AGENTS.md) for detailed instructions.**
