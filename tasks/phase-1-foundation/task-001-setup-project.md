# Task-001: Initialize Go Project Structure

## Status
- [ ] Not Started

## Priority
🔴 High — This must be done before any other task.

## Phase
Phase 1: Foundation

## Estimated Time
2–4 hours

## Dependencies
- None

---

## Description

Set up the initial Go project scaffold in `output/` following the architecture defined in
[`specs/architecture.md`](../../specs/architecture.md).

This task is **purely structural** — create the folder layout, `go.mod`, `Makefile`, and entry point.
No business logic should be written in this task.

---

## Source Reference
- N/A (this is a new project setup task)
- Architecture spec: [`specs/architecture.md`](../../specs/architecture.md)
- Tech stack: [`context/tech-stack.md`](../../context/tech-stack.md)

---

## Sub-Tasks

- [ ] Create `output/go.mod` with correct module name
- [ ] Create `output/cmd/server/main.go` with minimal Gin server
- [ ] Create all required directories:
  - [ ] `output/internal/handler/`
  - [ ] `output/internal/service/`
  - [ ] `output/internal/repository/`
  - [ ] `output/internal/domain/interfaces/`
  - [ ] `output/internal/dto/`
  - [ ] `output/internal/middleware/`
  - [ ] `output/internal/router/`
  - [ ] `output/internal/bootstrap/`
  - [ ] `output/internal/worker/`
  - [ ] `output/pkg/apperror/`
  - [ ] `output/pkg/response/`
  - [ ] `output/pkg/logger/`
  - [ ] `output/pkg/validator/`
  - [ ] `output/config/`
  - [ ] `output/migrations/`
  - [ ] `output/tests/`
- [ ] Create `output/.env.example` with required environment variables
- [ ] Create `output/Makefile` with common commands (`run`, `test`, `build`, `migrate`)
- [ ] Install base dependencies (`gin`, `gorm`, `godotenv`, etc.)

---

## Acceptance Criteria

- [ ] `go mod tidy` runs without errors
- [ ] `go run cmd/server/main.go` starts the server on port 8080
- [ ] `GET /health` returns `{"status": "ok"}`
- [ ] Folder structure matches `specs/architecture.md`

---

## Output Files

```
output/
├── cmd/server/main.go
├── internal/
│   ├── handler/.gitkeep
│   ├── service/.gitkeep
│   ├── repository/.gitkeep
│   ├── domain/interfaces/.gitkeep
│   ├── dto/.gitkeep
│   ├── middleware/.gitkeep
│   ├── router/router.go
│   └── bootstrap/app.go
├── pkg/
│   ├── apperror/errors.go
│   ├── response/response.go
│   └── logger/logger.go
├── config/config.go
├── .env.example
├── go.mod
├── go.sum
└── Makefile
```

---

## Notes

> Any technical decisions or notes about this task.
- Use `github.com/gin-gonic/gin` v1.9+
- Use `gorm.io/gorm` with `gorm.io/driver/postgres`
- Use `github.com/joho/godotenv` for env loading
