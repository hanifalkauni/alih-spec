# QA Checklist — Validasi Hasil Konversi

> Gunakan checklist ini setelah selesai mengkonversi setiap modul.
> Pastikan semua item terpenuhi sebelum mark task sebagai `[x] Done`.

---

## Per-Modul Checklist

Ganti `[module]` dengan nama modul yang sedang divalidasi.

### ✅ 1. Spec Coverage

- [ ] Semua API endpoint di `specs/modules/[module].md` sudah diimplementasi
- [ ] Semua request/response format sudah sesuai spec
- [ ] Semua business rules sudah diimplementasi
- [ ] Semua acceptance criteria sudah terpenuhi
- [ ] Semua error cases sudah dihandle (404, 401, 422, dll)

### ✅ 2. Code Quality

- [ ] File ada di path yang benar sesuai `specs/architecture.md`
- [ ] Naming mengikuti `context/conventions.md`
- [ ] Tidak ada business logic di handler layer
- [ ] Tidak ada direct DB call di handler atau service (hanya di repository)
- [ ] Error handling proper (no swallowed errors)
- [ ] Context propagation benar (`ctx context.Context` sebagai arg pertama)
- [ ] Logging menggunakan logger package (bukan fmt.Println)

### ✅ 3. Interface & Dependency

- [ ] Interface sudah didefinisikan di `domain/interfaces/`
- [ ] Dependency injection via constructor (bukan global variable)
- [ ] Handler → Service → Repository (tidak ada skip layer)

### ✅ 4. Data Layer

- [ ] Domain model sudah sesuai schema di `specs/data-models/schema.md`
- [ ] Semua relasi sudah diimplementasi
- [ ] Migration file sudah dibuat (jika ada tabel baru/modified)
- [ ] Soft delete dihandle jika diperlukan

### ✅ 5. API Contract

- [ ] Request validation sudah sesuai dengan `specs/api-contracts/openapi.yaml`
- [ ] Response structure konsisten (success/error format seragam)
- [ ] HTTP status code sudah benar
- [ ] Response field names sesuai konvensi

### ✅ 6. Tests

- [ ] Unit test untuk service layer sudah ada
- [ ] Happy path test sudah ada
- [ ] Error/edge case test sudah ada
- [ ] Semua test pass

### ✅ 7. Task Tracking

- [ ] Task di `tasks/` sudah di-mark `[x]`
- [ ] `tasks/_index.md` sudah diupdate
- [ ] Progress counter di `_index.md` sudah diperbarui

---

## Final Release Checklist

Jalankan ini sebelum menyatakan seluruh konversi selesai.

### ✅ Feature Parity

- [ ] Semua endpoint dari source project sudah ada di output
- [ ] Semua business rules sudah terimplementasi
- [ ] Tidak ada fitur yang hilang (bukan sengaja di-drop)
- [ ] Fitur yang di-drop sudah didokumentasikan di `specs/overview.md` (Out of Scope)

### ✅ Cross-Cutting Concerns

- [ ] Authentication sudah bekerja end-to-end
- [ ] Authorization/permission sudah bekerja
- [ ] Request validation sudah konsisten di semua endpoint
- [ ] Error response format sudah konsisten
- [ ] Logging sudah ada di semua layer yang diperlukan
- [ ] Environment variables sudah didokumentasikan di `.env.example`

### ✅ Database

- [ ] Semua tabel sudah di-migrate
- [ ] Semua relasi berfungsi
- [ ] Index database sudah ada (terutama untuk foreign keys)
- [ ] Seed data sudah ada (jika diperlukan)

### ✅ Integration Tests

- [ ] Semua endpoint sudah punya minimal 1 integration test
- [ ] Test berjalan dengan database test terpisah
- [ ] Semua test pass (0 failures)

### ✅ Documentation

- [ ] `docs/progress.md` sudah updated dengan milestone selesai
- [ ] `docs/decisions.md` sudah mencatat semua ADR penting
- [ ] `docs/changelog.md` sudah updated
- [ ] `context/known-issues.md` sudah mencatat semua gotchas

### ✅ Project Runs

- [ ] Project bisa dijalankan dengan `make run` atau equivalent
- [ ] Health check endpoint (`/health`) return 200
- [ ] Tidak ada runtime error saat startup
- [ ] Project bisa connect ke database

---

## Cara Pakai dengan AI

Setelah selesai satu modul, kirim prompt ini ke AI:

```
Tolong validasi modul [auth/user/product] yang sudah diimplementasi
menggunakan checklist di context/qa-checklist.md.

Cek:
1. Spec coverage — semua endpoint dan business rule sudah ada?
2. Code quality — ikuti conventions dan architecture?
3. Tests — sudah ada dan pass?

Laporkan hasilnya dan langsung perbaiki yang kurang.
```
