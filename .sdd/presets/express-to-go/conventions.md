# Conventions: Express.js ➔ Go Clean Architecture

## 1. Transformasi Struktur Layer

```
Source (Express.js / TypeScript):
├── src/
│   ├── controllers/user.controller.ts
│   ├── services/user.service.ts
│   ├── models/user.model.ts
│   ├── middlewares/auth.middleware.ts
│   ├── routes/user.route.ts
│   ├── schemas/user.schema.ts (Zod)
│   └── app.ts

Target (Go Clean Architecture):
├── cmd/server/main.go
├── internal/
│   ├── handler/user_handler.go      # Pengganti controller
│   ├── service/user_service.go      # Pengganti service
│   ├── repository/user_repository.go# Data access GORM
│   ├── domain/user.go               # Domain struct
│   ├── dto/user_dto.go              # Request & Response DTOs
│   ├── middleware/auth.go           # Middleware JWT
│   └── router/api.go                # Route registration
└── pkg/
    ├── apperror/errors.go
    └── response/response.go
```

---

## 2. Paradigma Concurrency & Error Handling

1. **Dari `Promise/async/await` ke Goroutines & Error Return**:
   - Di Express: `const user = await userService.get(id);` dengan `try { ... } catch(err) { ... }`.
   - Di Go: `user, err := h.userService.Get(c.Request.Context(), id)` dengan `if err != nil { ... }`.
2. **Konteks Request (`context.Context`)**:
   - Selalu pass `c.Request.Context()` dari handler ke service dan repository untuk mendukung cancellation & timeout.
