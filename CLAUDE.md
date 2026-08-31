# Claude Code Instructions — AlihSpec SDD Framework

> 📌 **Primary Context**: Read [`context/AGENTS.md`](./context/AGENTS.md)
> 🔬 **Master Evaluation Guide**: Read [`evaluate/framework-evaluation.md`](./evaluate/framework-evaluation.md) for 16 Universal Pillars & 7 Golden Directives.

## What is AlihSpec?
AlihSpec is a Spec-Driven Development (SDD) conversion framework. We convert existing codebases:
- **From**: `source/` (READ-ONLY reference — NEVER modify files here)
- **To**: `output/` (All new code is written here following Clean Architecture)
- **Reference Target**: `reference-target/` (READ-ONLY optional boilerplate)

## 🚨 7 Mandatory Golden Directives
1. **Deep Controller AST Inspection**: Bedah baris-demi-baris seluruh query param (`menu`, `tab`, `filter`), percabangan `if/switch`, relasi database, subquery, dan validasi di controller sumber.
2. **Iterative Per-Module Execution**: Dilarang memproses spesifikasi massal (*bulk*) jika > 10 endpoint. Alur: Spec ➔ Checkpoint 1 ➔ Task ➔ Checkpoint 2 ➔ Code ➔ QA.
3. **Pointer Nullability Parity**: Gunakan tipe pointer (`*int64`, `*string`, `*bool`) untuk field opsional/nullable agar tidak menghasilkan zero-value palsu (`0` / `""`) di JSON.
4. **Strict No Dummy Fallback**: Dilarang keras mengembalikan hardcoded dummy data (`return 5000, nil` atau `[]map{}`) di Repository/Handler layer.
5. **Spec Definition of Done (DoD)**: Setiap `specs/modules/[module].md` wajib lolos checklist DoD sebelum task dibuat.
6. **Checkpoint 1 (Spec vs Source)**: Validasi spesifikasi terhadap controller sumber sebelum breakdown task.
7. **Checkpoint 2 (Task vs Spec)**: Validasi kriteria task terhadap spesifikasi sebelum menulis kode di `output/`.

## 🛡️ 16 Universal Conversion Pillars
1. **Zero Environment Key Drift**: Key `.env` 100% identik dengan variabel sumber.
2. **URL Builder Resiliency**: Helper pembersih URL anti double-slash (`//`).
3. **Universal Context Claims**: Ekstraksi token JWT dinamis (*multi-key fallback* untuk `business_id`, `store_id`, `user_id`).
4. **Route Prefix Dual-Mounting**: Dukung rute `/api/v1/...` dan `/v1/...` serentak.
5. **Domain Valuation & Localization**: Implementasikan helper multiplier dan format currency di domain layer.
6. **Smart Query Normalization**: Defaulting parameter sebelum validasi DTO.
7. **Pointer Nullability Parity**: Pointer pada struct field nullable.
8. **Flexible Payload Coercion**: Parsing form-urlencoded / stringed-numbers.
9. **Strict Zero Dummy Fallback**: 100% query database riil.
10. **Explicit DB Transaction Propagation**: Oper `tx` context ke seluruh repo calls dalam satu usecase.
11. **ORM Explicit Table & Column Binding**: Deklarasi `TableName()` eksplisit (anti-implicit pluralization).
12. **Idempotency & Safe Mutation**: Perlindungan `X-Idempotency-Key` / Redis lock pada mutasi finansial.
13. **Async & Graceful Shutdown Safety**: Anti-job drop saat container restart (`SIGTERM`/`SIGINT`).
14. **HTTP Client Timeout Parity**: Timeout outbound HTTP eksplisit anti-hang.
15. **Safe File Upload Streaming**: Streaming I/O `io.Copy` anti-RAM OOM.
16. **Structured Observability**: Structured JSON logging & `X-Request-ID` tracing context.

## Target Architecture (`specs/architecture.md`)
- Clean Layered Architecture: `internal/handler` ➔ `internal/service` ➔ `internal/repository` ➔ `internal/domain`
- No business logic in handlers; no direct DB access in handlers; no raw SQL in services.

## Validation Commands
```bash
# Validate framework integrity and links
powershell -ExecutionPolicy Bypass -File .\scripts\alih.ps1 validate
# Or in bash:
bash scripts/alih.sh validate
```
