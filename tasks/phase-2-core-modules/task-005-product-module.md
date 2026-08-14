# Task-005: Product Module

## Status
- [ ] Not Started

## Priority
🟡 Medium

## Phase
Phase 2: Core Modules

## Estimated Time
6–10 hours

## Dependencies
- [x] Task-001: Project setup
- [x] Task-002: Database layer
- [x] Task-003: Auth module (middleware auth untuk admin guard)

---

## Description

Implementasi modul Product — CRUD lengkap dengan listing, filtering, pagination,
dan role-based access (hanya admin bisa create/update/delete).

---

## Source Reference
- `source/app/Http/Controllers/ProductController.php`
- `source/app/Models/Product.php`
- Spec: [`specs/modules/product.md`](../../specs/modules/product.md)

---

## Sub-Tasks

- [ ] Create domain model `output/internal/domain/product.go`
- [ ] Create migration file `output/migrations/XXX_create_products_table.sql`
- [ ] Create `output/internal/dto/product_dto.go`
- [ ] Create `output/internal/domain/interfaces/product_repository.go`
- [ ] Create `output/internal/domain/interfaces/product_service.go`
- [ ] Create `output/internal/repository/product_repository.go`
- [ ] Create `output/internal/service/product_service.go`
- [ ] Create `output/internal/handler/product_handler.go`
- [ ] Register routes di `output/internal/router/api.go`
- [ ] Write tests di `output/tests/product_test.go`

---

## Acceptance Criteria

Semua criteria dari [`specs/modules/product.md`](../../specs/modules/product.md#acceptance-criteria).

---

## Notes
