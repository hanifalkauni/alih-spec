# Task-006: Final Route Wiring & Middleware

## Status
- [ ] Not Started

## Priority
🟡 Medium

## Phase
Phase 3: Integration & Polish

## Estimated Time
3–5 hours

## Dependencies
- [x] Semua modul Phase 1 dan Phase 2 selesai

---

## Description

Final wiring semua route, middleware global, error handler, dan pastikan
seluruh API berjalan konsisten end-to-end.

---

## Sub-Tasks

- [ ] Pastikan semua route terdaftar di `output/internal/router/api.go`
- [ ] Setup global middleware (CORS, logger, recovery, rate limiter)
- [ ] Setup global error handler yang return format response konsisten
- [ ] Verifikasi semua endpoint sesuai `specs/api-contracts/openapi.yaml`
- [ ] Test semua route dengan tools (Postman/curl)
- [ ] Update `output/README.md` dengan cara run project

---

## Acceptance Criteria

- [ ] Semua endpoint dari openapi.yaml bisa diakses
- [ ] Error response format konsisten di semua endpoint
- [ ] CORS sudah dikonfigurasi
- [ ] Health check endpoint `/health` berfungsi

---

## Notes
