# Task-007: Integration Tests & CI Setup

## Status
- [ ] Not Started

## Priority
🟡 Medium

## Phase
Phase 3: Integration & Polish

## Estimated Time
4–8 hours

## Dependencies
- [x] Semua modul selesai (Phase 1 & 2)
- [x] Task-006: Route wiring selesai

---

## Description

Tulis integration tests untuk semua modul utama dan setup CI pipeline
agar tests berjalan otomatis setiap ada perubahan code.

---

## Sub-Tasks

- [ ] Setup test database (separate dari development DB)
- [ ] Buat test helper di `output/tests/testhelper/`
- [ ] Tulis integration tests untuk setiap modul:
  - [ ] `output/tests/auth_test.go`
  - [ ] `output/tests/user_test.go`
  - [ ] `output/tests/product_test.go`
- [ ] Pastikan semua acceptance criteria dari setiap spec terpenuhi di test
- [ ] Jalankan semua test dan pastikan 100% pass
- [ ] Setup `Makefile` target: `make test` dan `make test-cover`
- [ ] (Optional) Setup GitHub Actions / CI pipeline

---

## Acceptance Criteria

- [ ] Semua test pass dengan `make test`
- [ ] Coverage minimal 70% untuk service layer
- [ ] Tidak ada test yang flaky (random pass/fail)
- [ ] Test tidak memodifikasi development database

---

## Notes
- Gunakan `context/qa-checklist.md` untuk validasi sebelum mark done
