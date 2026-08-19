# Conventions: CodeIgniter ➔ Go Clean Architecture

## 1. File Structure (Target Go Project)

```
output/
├── cmd/server/main.go               # Entry point
├── config/database.go               # GORM DB connection
├── internal/
│   ├── bootstrap/app.go             # Dependency injection wiring
│   ├── domain/                      # Structs domain & interfaces
│   │   ├── user.go
│   │   └── interfaces/
│   ├── dto/                         # Request/Response data transfer objects
│   │   ├── user_dto.go
│   │   └── auth_dto.go
│   ├── handler/                     # HTTP Handlers (Controllers)
│   │   └── user_handler.go
│   ├── middleware/                  # JWT auth & CORS middleware
│   │   └── auth.go
│   ├── repository/                  # GORM database queries
│   │   └── user_repository.go
│   ├── router/                      # Route registration
│   │   └── api.go
│   └── service/                     # Business logic services
│       └── user_service.go
└── pkg/
    ├── apperror/                    # Custom application errors
    └── response/                    # Standardized JSON response helpers
```

---

## 2. Naming Conventions

| Item | CodeIgniter | Go Target |
|---|---|---|
| Package Name | N/A | lowercase single word (`handler`, `service`) |
| Domain Struct | `M_user` | `User` (Exported, PascalCase) |
| Repository Interface | N/A | `UserRepository` |
| Repository Struct | `M_user` | `userRepository` (Unexported) |
| Handler Function | `function index()` | `func (h *UserHandler) GetAll(c *gin.Context)` |
| JSON tags | N/A | `json:"user_id"` (snake_case) |
