# Conversion Overview

## Project
**Converting**: [Source Project Name]
**From**: [Source Language / Framework] vX.x
**To**: [Target Language / Framework] vX.x
**Started**: [Date]
**Target Completion**: [Date]

---

## Background

> Describe why this conversion is happening.
> What problems does the new stack solve?
> What are the business/technical motivations?

Example:
> Our Laravel monolith has grown to 150k LOC and is struggling with performance
> under high traffic. We are migrating to Golang (Gin + GORM) to gain:
> - 10x better throughput
> - Lower memory footprint
> - Better concurrency primitives
> - Statically typed codebase

---

## Scope

### In Scope ✅
- [ ] List all modules/features being converted
- [ ] API endpoints
- [ ] Database schema
- [ ] Authentication & authorization
- [ ] Background workers
- [ ] Email/notification system

### Out of Scope ❌
- [ ] Features being dropped or redesigned
- [ ] Legacy endpoints being deprecated
- [ ] Third-party integrations (list which ones)

---

## High-Level Architecture

```
[Source Project]          [Target Project]
──────────────            ──────────────
Controllers      ────►    Handlers
Services         ────►    Services
Repositories     ────►    Repositories
Models           ────►    Domain + GORM Models
Middleware       ────►    Gin Middleware
Jobs             ────►    Workers
Events           ────►    Event Bus
```

> Replace with your actual architecture diagram.

---

## Module Breakdown

| Module | Source File(s) | Target File(s) | Status | Spec |
|--------|---------------|----------------|--------|------|
| Auth | `app/Http/Controllers/AuthController.php` | `internal/handler/auth_handler.go` | Not Started | [auth.md](./modules/auth.md) |
| User | `app/Http/Controllers/UserController.php` | `internal/handler/user_handler.go` | Not Started | [user.md](./modules/user.md) |
| Product | `app/Http/Controllers/ProductController.php` | `internal/handler/product_handler.go` | Not Started | [product.md](./modules/product.md) |

> Add more rows as needed.

---

## Key Decisions

| Decision | Choice | Reason |
|----------|--------|--------|
| ORM | GORM | Most mature Go ORM, closest to Eloquent |
| Router | Gin | Performance + large ecosystem |
| Auth | JWT (golang-jwt) | Stateless, matches Sanctum behavior |
| Validation | go-playground/validator | Struct tags = clean & declarative |
| Config | godotenv + envconfig | Mirrors .env from Laravel |
| Migration | goose | SQL-based, team-friendly |

---

## Dependencies

### Source Project
```
[List main dependencies from composer.json / package.json / etc]
```

### Target Project
```
[List main dependencies from go.mod / package.json / etc]
```

---

## Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Missing feature parity | High | Write specs before coding |
| Data migration errors | High | Dual-write period + validation scripts |
| Team unfamiliarity with Go | Medium | Pair programming + code review |
| Performance regression | Low | Benchmark critical paths |
