---
name: alih-spec
description: Master Spec-Driven Development (SDD) conversion skill for migrating codebases across programming stacks (Laravel, Go, NestJS, FastAPI, Django, Rails, Spring Boot, etc.) with 100% behavioral parity, 7 Golden Directives, 16 Universal Conversion Pillars, and Dual-Validation Checkpoints. Activate this skill whenever the user wants to convert, migrate, refactor across languages, or build Clean Architecture backends from existing legacy source code.
---

# ⚡ AlihSpec — Master Code Conversion & SDD AI Agent Skill

This skill equips AI agents with enterprise-grade capabilities to autonomously and accurately convert legacy or source codebases into target programming stacks using the **Spec-Driven Development (SDD)** methodology without *Logic Drift*, *Shallow Specifications*, or *Hidden Production Bugs*.

---

## 🏛️ Core Principles & The 7 Golden Directives

Every time this skill is active, the AI agent **MUST STRICTLY ENFORCE** these 7 non-negotiable directives:

1. **Deep Controller AST Inspection**: Bedah baris-demi-baris seluruh query parameter (`menu`, `tab`, `filter`), percabangan `if/switch`, relasi multi-tabel database, subquery, dan validasi di controller sumber. Dilarang hanya membaca nama route atau nama model secara sekilas.
2. **Iterative Per-Module Execution**: Dilarang memproses spesifikasi atau penulisan kode massal (*bulk*) jika > 10 endpoint. Eksekusi modul demi modul secara bertahap:
   `[ 1. Spec Modul ] ➔ [ 2. Checkpoint 1 ] ➔ [ 3. Tasks Modul ] ➔ [ 4. Checkpoint 2 ] ➔ [ 5. Target Code in output/ ] ➔ [ 6. QA Parity ]`
3. **Pointer Nullability Parity**: Gunakan tipe pointer (`*int64`, `*string`, `*bool` di Go, atau `T | null` di TypeScript) untuk seluruh field DTO dan skema database yang bersifat opsional/nullable agar tidak menghasilkan *false zero-value* (`0` atau `""`) pada output JSON.
4. **Strict No Dummy Fallback**: Dilarang keras mengembalikan hardcoded dummy data (`return 5000, nil` atau `[]map{}`) pada Repository atau Handler layer. Setiap method Repository wajib menuliskan query database SQL/ORM riil yang terhubung ke skema tabel.
5. **Spec Definition of Done (DoD) Checklist**: Seluruh spesifikasi modul wajib lolos checklist DoD (Validation Parity, Branching Parity, SQL & Join Parity, Pointer Nullability) sebelum task dibuat.
6. **Checkpoint 1 (Spec vs Source Alignment)**: Validasi spesifikasi terhadap controller sumber sebelum breakdown task di `tasks/`.
7. **Checkpoint 2 (Task vs Spec Alignment)**: Validasi kriteria task terhadap spesifikasi sebelum menulis kode di `output/`.

---

## 🛡️ The 16 Universal Conversion Pillars (4 Quadrants)

When designing specifications, DTOs, database queries, and handlers, follow the 16 Universal Pillars:

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                16 PILAR PELAJARAN UNIVERSAL KONVERSI KODE                   │
├─────────────────────────────────────────────────────────────────────────────┤
│ 🌐 A. PROTOKOL, ROUTING & KONFIGURASI (Config & Gateway)                   │
│  1. Zero Environment Key Drift  │ Selaraskan nama key .env 100% dari sumber │
│  2. URL Builder Resiliency      │ Anti double-slash (//) pada base URL      │
│  3. Universal Context Claims    │ Ekstraksi multi-key session/JWT dinamis   │
│  4. Route Prefix Dual-Mounting  │ Dukung prefix /api dan root secara serentak│
│                                                                             │
│ 🎯 B. KONTRAK DATA, TIPE & PAYLOAD (Contract & Validation)                  │
│  5. Domain Valuation & Locale   │ Bedah helper multiplier & format currency │
│  6. Smart Query Normalization   │ Defaulting parameter sebelum validasi DTO │
│  7. Pointer Nullability Parity  │ Gunakan pointer/optional untuk field null │
│  8. Flexible Payload Coercion   │ Tangani form-urlencoded & stringed numbers│
│                                                                             │
│ 🗄️ C. DATABASE, TRANSAKSI & ACID (Database & Persistence)                   │
│  9. Strict Zero Dummy Fallback  │ Query database riil, dilarang hardcoded   │
│ 10. Explicit DB Tx Propagation  │ Oper tx context ke seluruh multi-repo     │
│ 11. Explicit ORM Table Binding  │ Anotasi TableName() & kolom eksplisit     │
│ 12. Idempotency & Safe Mutation │ Anti double-charge pada mutasi finansial  │
│                                                                             │
│ ⚡ D. RESOURCE SAFETY & OBSERVABILITY (I/O, Concurrency & SRE)              │
│ 13. Async & Shutdown Safety     │ Anti-job drop saat container restart      │
│ 14. HTTP Client Timeout Parity  │ Timeout eksplisit anti-hang network calls │
│ 15. Safe File Upload Streaming  │ Streaming I/O anti-RAM OOM pada upload    │
│ 16. Structured Observability    │ Structured JSON logging & Trace/Request ID│
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🧭 The 5-Phase Conversion Lifecycle

```mermaid
flowchart TD
    S["Read source/ & context/"] --> P1["Fase 1: Overview & Architecture (specs/overview.md)"]
    P1 --> P2["Fase 2: Module Spec (Deep AST Inspection)"]
    P2 --> CP1{"🛑 Checkpoint 1: Spec vs Source Match?"}
    CP1 -- No (Missing params/branches) --> P2
    CP1 -- Yes --> P3["Fase 3: Task Breakdown (tasks/)"]
    P3 --> CP2{"🛑 Checkpoint 2: Task vs Spec Match?"}
    CP2 -- No (Missing criteria/DTOs) --> P3
    CP2 -- Yes --> P4["Fase 4: Write Target Code in output/"]
    P4 --> P5["Fase 5: QA Parity Audit & Validation"]
```

### 📋 Fase 1: Analisis Menyeluruh & Arsitektur Global
1. Bedah seluruh folder `source/` untuk memetakan seluruh modul bisnis, daftar endpoint/rute, dependensi package, dan schema database.
2. Tuliskan ringkasan arsitektur ke `specs/overview.md` dan `specs/architecture.md`.
3. Inisialisasi antrean prompt modul di `docs/prompt-queue/` (jika menggunakan workflow Vibe Coding).

### 📋 Fase 2: Spesifikasi Modul Detail (Deep AST Inspection)
1. Tulis spesifikasi modul di `specs/modules/[nama-modul].md`.
2. Cantumkan:
   - **DTO Request & Response**: Wajib mencantumkan seluruh query param (`menu`, `tab`, `filter`, `limit`, `offset`) dan menggunakan pointer untuk field nullable.
   - **Branching Matrix**: Petakan seluruh kombinasi kondisi `if/switch` dari controller sumber.
   - **SQL & Query Spec**: Catat nama tabel asli, klausa JOIN, WHERE, GROUP BY, dan Locking.
   - **Definition of Done (DoD) Checklist**.
3. **Eksekusi Checkpoint 1**: Cocokkan spesifikasi terhadap controller sumber line-by-line.

### 📋 Fase 3: Pembuatan Task Atomik
1. Buat berkas task di `tasks/` (misal: `tasks/phase-2-user/task-001-dto.md`, `task-002-repo.md`, dst.).
2. Cantumkan Acceptance Criteria teknis, skenario pengujian, dan dependensi task.
3. Daftarkan dan update progress di `tasks/_index.md`.
4. **Eksekusi Checkpoint 2**: Validasi keselarasan task terhadap spesifikasi sebelum menulis kode.

### 📋 Fase 4: Penulisan Kode Target di `output/` (Clean Architecture)
1. Seluruh implementasi kode target ditulis secara eksklusif di dalam folder `output/`.
2. Ikuti Clean Architecture satu arah:
   `Handler (HTTP Delivery) ➔ Service / UseCase (Business Logic) ➔ Repository (Real SQL/ORM Queries) ➔ Domain / Entities`
3. **Pantangan Arsitektur**:
   - Dilarang menaruh business logic di Handler.
   - Dilarang mengakses database langsung di Handler.
   - Dilarang mengembalikan dummy mock data di Repository.
   - Seluruh mutasi multi-tabel dalam satu usecase wajib dioper di dalam satu transaksi database (`tx`).

### 📋 Fase 5: QA Parity Audit & Validasi Integritas
1. Jalankan unit test dan integration test terhadap seluruh usecase.
2. Verifikasi terhadap checklist `context/qa-checklist.md`:
   - [x] DateTime & Timezone serialization (`YYYY-MM-DD HH:mm:ss`).
   - [x] Currency/Coin precision (`int64` sen basis, anti-float64).
   - [x] Pagination envelope & offset computation `(page-1)*per_page`.
   - [x] Validation error format HTTP 422 (`Object of Arrays`).
   - [x] Soft delete leakage prevention (`AND deleted_at IS NULL`).
   - [x] Empty state consistency (`[]` vs `404/null`).
3. Jalankan validator integritas framework:
   - Windows PowerShell: `powershell -ExecutionPolicy Bypass -File .\scripts\alih.ps1 validate`
   - Linux / macOS Bash: `bash scripts/alih.sh validate`
4. Tandai task selesai `[x]` di `tasks/_index.md` dan catat milestone di `docs/progress.md`.

---

## 📚 Skill References Directory

When deep contextual guidance is needed, consult the following bundled reference files:
- [16 Universal Pillars Reference](./references/16-pillars-cheatsheet.md)
- [Deep Controller AST Inspection Guide](./references/ast-inspection-guide.md)
- [Dual-Validation Checkpoints Protocol](./references/dual-checkpoints.md)
