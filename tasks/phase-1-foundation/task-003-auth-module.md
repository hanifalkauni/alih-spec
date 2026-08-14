# Task-003: Auth Module

## Status
- [ ] Not Started

## Priority
🔴 High

## Phase
Phase 1: Foundation

## Estimated Time
6–10 hours

## Dependencies
- [x] Task-001: Project setup
- [x] Task-002: Database layer (User model must exist)

---

## Description

Implement the complete authentication module following the spec in
[`specs/modules/auth.md`](../../specs/modules/auth.md).

This includes: register, login, logout, `/me` endpoint, and JWT middleware.

---

## Source Reference
- `source/app/Http/Controllers/AuthController.php`
- `source/app/Http/Requests/Auth/LoginRequest.php`
- Spec: [`specs/modules/auth.md`](../../specs/modules/auth.md)

---

## Sub-Tasks

- [ ] Create `output/internal/dto/auth_dto.go` — request/response DTOs
- [ ] Create `output/internal/domain/interfaces/auth_service.go` — service interface
- [ ] Create `output/internal/repository/user_repository.go`
- [ ] Create `output/internal/service/auth_service.go`
- [ ] Create `output/internal/middleware/auth.go` — JWT validation middleware
- [ ] Create `output/internal/handler/auth_handler.go`
- [ ] Register routes in `output/internal/router/api.go`
- [ ] Write tests in `output/tests/auth_test.go`

---

## Acceptance Criteria

All criteria from [`specs/modules/auth.md`](../../specs/modules/auth.md#acceptance-criteria) must pass.

---

## Notes
