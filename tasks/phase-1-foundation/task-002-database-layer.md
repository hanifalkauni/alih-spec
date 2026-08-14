# Task-002: Database Layer

## Status
- [ ] Not Started

## Priority
🔴 High

## Phase
Phase 1: Foundation

## Estimated Time
3–6 hours

## Dependencies
- [x] Task-001: Project setup must be complete

---

## Description

Set up the complete database layer including:
- Database connection configuration
- Base GORM model
- Migration setup
- All domain model structs from `specs/data-models/schema.md`

---

## Source Reference
- `source/database/migrations/` — all migration files
- `source/app/Models/` — all Eloquent models
- Schema spec: [`specs/data-models/schema.md`](../../specs/data-models/schema.md)

---

## Sub-Tasks

- [ ] Create `output/config/database.go` — DB connection setup
- [ ] Create domain model structs for all tables in schema spec:
  - [ ] `output/internal/domain/user.go`
  - [ ] `output/internal/domain/[other models]`
- [ ] Create SQL migration files in `output/migrations/`
- [ ] Set up goose migration runner
- [ ] Add DB health check to `/health` endpoint
- [ ] Write connection test

---

## Acceptance Criteria

- [ ] App connects to PostgreSQL using `.env` credentials
- [ ] All migrations run successfully with `goose up`
- [ ] All domain model structs match schema spec
- [ ] `GET /health` shows `{"status": "ok", "db": "connected"}`

---

## Notes

> Document any schema differences between source and target here.
