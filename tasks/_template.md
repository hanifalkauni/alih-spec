# Task-XXX: [Task Name]

> **📋 Task Breakdown Template (AlihSpec SDD)**  
> Salin berkas ini ke folder fase yang sesuai (`phase-1-foundation/`, `phase-2-core-modules/`, atau `phase-3-integration/`).

---

## Status
- [ ] Not Started

## Priority
🔴 High / 🟡 Medium / 🟢 Low

## Phase
Phase X: [Phase Name]

## Estimated Time
X–Y hours

## Dependencies
- [ ] Task-XXX: [Dependency task name, misal: DB Layer / Base Auth]

---

## 🛑 Pre-Implementation Verification (Checkpoint 2)

Sebelum menulis kode di `output/`, verifikasi bahwa:
- [ ] **Spec DoD Verified**: Berkas [`specs/modules/[module].md`](../specs/modules/[module].md) telah lolos DoD checklist.
- [ ] **All Branches Captured**: Semua mode query param dan percabangan logic memiliki DTO dan skenario di spec.
- [ ] **No Dummy Data Rule**: Tidak ada rencana menggunakan data dummy/fallback hardcoded.

---

## 📌 Description

[Deskripsi detail mengenai apa yang akan diimplementasikan pada task ini, mengacu pada spesifikasi terkait.]

---

## 🔍 References
- Source Controller: `source/[path/to/source/file]`
- Module Spec: [`specs/modules/[module].md`](../specs/modules/[module].md)
- OpenAPI Contract: [`specs/api-contracts/openapi.yaml`](../specs/api-contracts/openapi.yaml)
- Business Rules: [`context/RULES.md`](../context/RULES.md)

---

## 🛠️ Sub-Tasks (Layer-by-Layer Implementation)

### 1. Data Transfer Objects (DTO) Layer
- [ ] Buat `output/internal/dto/[module]_dto.go`
  - [ ] Request DTO dengan validasi struct tags
  - [ ] Response DTO dengan tipe pointer pada field opsional/nullable

### 2. Domain & Entity Layer
- [ ] Buat / sesuaikan `output/internal/domain/[module].go`
- [ ] Buat interface repository & usecase di `output/internal/domain/interfaces/`

### 3. Repository Layer (Real Database Queries)
- [ ] Buat `output/internal/repository/[module]_repository.go`
  - [ ] Implementasikan query GORM riil (termasuk JOIN, GroupBy, dan agregasi)
  - [ ] **DILARANG** mengembalikan nilai dummy/hardcoded

### 4. Service / UseCase Layer (Business Logic & Branching)
- [ ] Buat `output/internal/service/[module]_service.go`
  - [ ] Implementasikan seluruh percabangan kondisi (`if/switch`) sesuai spesifikasi
  - [ ] Tangani error handling dan context cancellation

### 5. HTTP Handler & Router Layer
- [ ] Buat `output/internal/handler/[module]_handler.go`
  - [ ] Binding DTO request & validasi
  - [ ] Panggil Service / UseCase
  - [ ] Kirim standard JSON response
- [ ] Daftarkan route di `output/internal/router/api.go`

### 6. Testing & Validation
- [ ] Tulis unit test di `output/tests/[module]_test.go`
- [ ] Uji endpoint dengan curl / Postman untuk memastikan response sesuai kontrak OpenAPI

---

## 🎯 Acceptance Criteria

- [ ] Seluruh kriteria penerimaan di [`specs/modules/[module].md`](../specs/modules/[module].md) terpenuhi.
- [ ] Tidak ada hardcoded dummy data di repository maupun service layer.
- [ ] Nullability JSON output sesuai dengan data sumber (tidak ada field null yang berubah jadi default 0/"").
- [ ] Lolos checklist QA di [`context/qa-checklist.md`](../context/qa-checklist.md).

---

## 📁 Output Files

```
output/internal/dto/[module]_dto.go
output/internal/domain/[module].go
output/internal/repository/[module]_repository.go
output/internal/service/[module]_service.go
output/internal/handler/[module]_handler.go
output/tests/[module]_test.go
```

