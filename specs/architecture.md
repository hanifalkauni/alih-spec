# Target Project Architecture

> This document defines the folder structure, layering, and architectural
> principles for the **output** (converted) project.
>
> AI agents and developers must follow this structure when writing output code.

---

## Architectural Pattern

**Pattern**: Clean Architecture / Layered Architecture

```
┌──────────────────────────────────────────┐
│               HTTP Layer                  │  ← Handlers, Middleware, Router
├──────────────────────────────────────────┤
│             Service Layer                 │  ← Business Logic
├──────────────────────────────────────────┤
│           Repository Layer                │  ← Data Access
├──────────────────────────────────────────┤
│             Domain Layer                  │  ← Models, Entities, Interfaces
└──────────────────────────────────────────┘
```

**Dependency Rule**: Each layer only depends on the layer below it.
Handlers → Services → Repositories → Domain

---

## Output Folder Structure

```
output/
├── cmd/
│   └── server/
│       └── main.go                  # Application entry point
│
├── internal/
│   ├── bootstrap/                   # App initialization (DI wiring)
│   │   ├── app.go
│   │   └── deps.go
│   │
│   ├── router/                      # Route definitions
│   │   ├── api.go
│   │   └── router.go
│   │
│   ├── middleware/                  # HTTP middleware
│   │   ├── auth.go
│   │   ├── cors.go
│   │   └── logger.go
│   │
│   ├── handler/                     # HTTP handlers (Controllers)
│   │   ├── auth_handler.go
│   │   ├── user_handler.go
│   │   └── product_handler.go
│   │
│   ├── service/                     # Business logic services
│   │   ├── auth_service.go
│   │   ├── user_service.go
│   │   └── product_service.go
│   │
│   ├── repository/                  # Data access layer
│   │   ├── user_repository.go
│   │   └── product_repository.go
│   │
│   ├── domain/                      # Domain models & interfaces
│   │   ├── user.go
│   │   ├── product.go
│   │   └── interfaces/              # Repository & service interfaces
│   │       ├── user_repository.go
│   │       └── user_service.go
│   │
│   ├── dto/                         # Data Transfer Objects (Request/Response)
│   │   ├── auth_dto.go
│   │   ├── user_dto.go
│   │   └── product_dto.go
│   │
│   └── worker/                      # Background workers / jobs
│       └── email_worker.go
│
├── pkg/                             # Shared/reusable packages
│   ├── apperror/                    # Custom error types
│   │   └── errors.go
│   ├── response/                    # Standard HTTP response helpers
│   │   └── response.go
│   ├── logger/                      # Logger wrapper
│   │   └── logger.go
│   └── validator/                   # Custom validators
│       └── validator.go
│
├── config/                          # Configuration
│   ├── config.go                    # Config structs
│   └── database.go                  # DB connection setup
│
├── migrations/                      # Database migrations
│   ├── 001_create_users_table.sql
│   └── 002_create_products_table.sql
│
├── tests/                           # Integration & E2E tests
│   ├── auth_test.go
│   └── testhelper/
│
├── .env.example                     # Environment variables template
├── go.mod
├── go.sum
├── Makefile                         # Build, test, run commands
└── Dockerfile                       # Container build
```

---

## Layering Rules

### Handler Layer (`internal/handler/`)
- ✅ Parse HTTP request (params, body, headers)
- ✅ Validate input DTO
- ✅ Call service layer
- ✅ Return HTTP response
- ❌ Never directly access database
- ❌ Never contain business logic

### Service Layer (`internal/service/`)
- ✅ Contain all business logic
- ✅ Call repository layer for data access
- ✅ Orchestrate multiple repositories if needed
- ❌ Never directly access HTTP context
- ❌ Never write raw SQL

### Repository Layer (`internal/repository/`)
- ✅ All database queries
- ✅ Accept and return domain models
- ❌ Never contain business logic
- ❌ Never call services

### Domain Layer (`internal/domain/`)
- ✅ Plain structs with GORM tags
- ✅ Interfaces for repositories and services
- ❌ No external dependencies

---

## Standard File Template

### Handler file structure
```go
package handler

type UserHandler struct {
    userService domain.interfaces.UserService
}

func NewUserHandler(userService domain.interfaces.UserService) *UserHandler {
    return &UserHandler{userService: userService}
}

func (h *UserHandler) GetUser(c *gin.Context) { ... }
func (h *UserHandler) CreateUser(c *gin.Context) { ... }
func (h *UserHandler) UpdateUser(c *gin.Context) { ... }
func (h *UserHandler) DeleteUser(c *gin.Context) { ... }
```

---

## Interface Contract

Define interfaces in `internal/domain/interfaces/` before implementing:

```go
type UserRepository interface {
    FindByID(ctx context.Context, id uint) (*User, error)
    FindByEmail(ctx context.Context, email string) (*User, error)
    Create(ctx context.Context, user *User) error
    Update(ctx context.Context, user *User) error
    Delete(ctx context.Context, id uint) error
    List(ctx context.Context, filter UserFilter) ([]User, int64, error)
}
```
