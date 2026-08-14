# Task-004: User Module

## Status
- [ ] Not Started

## Priority
🟡 Medium

## Phase
Phase 2: Core Modules

## Estimated Time
5–8 hours

## Dependencies
- [x] Task-001: Project setup
- [x] Task-002: Database layer (User domain model harus sudah ada)
- [x] Task-003: Auth module (middleware auth harus sudah ada)

---

## Description

Implementasi modul User — list, get, update, delete user profile.
Lengkap dengan pagination, authorization (user hanya bisa edit diri sendiri, admin bisa semua),
dan soft delete.

---

## Source Reference
- `source/app/Http/Controllers/UserController.php`
- `source/app/Models/User.php`
- Spec: [`specs/modules/user.md`](../../specs/modules/user.md)

---

## Sub-Tasks

- [ ] Create `output/internal/dto/user_dto.go` — request/response DTOs
- [ ] Create `output/internal/domain/interfaces/user_service.go`
- [ ] Create `output/internal/domain/interfaces/user_repository.go`
- [ ] Create `output/internal/repository/user_repository.go`
- [ ] Create `output/internal/service/user_service.go`
- [ ] Create `output/internal/handler/user_handler.go`
- [ ] Register routes di `output/internal/router/api.go`
- [ ] Write tests di `output/tests/user_test.go`

---

## Acceptance Criteria

Semua criteria dari [`specs/modules/user.md`](../../specs/modules/user.md#acceptance-criteria).

---

## Notes
