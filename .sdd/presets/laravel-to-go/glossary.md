# Glossary: Laravel (PHP) → Go (Gin + GORM)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| Controller | Handler | HTTP request handler di `internal/handler/` |
| Service | Service | Business logic di `internal/service/` |
| Repository | Repository | Data access di `internal/repository/` |
| Model | Domain / Entity | Plain struct + GORM di `internal/domain/` |
| Form Request | DTO (Request) | Input validation struct di `internal/dto/` |
| API Resource | DTO (Response) | Output struct di `internal/dto/` |
| Middleware | Gin Middleware | di `internal/middleware/` |
| Job | Worker | Background task di `internal/worker/` |
| Event | Event | Domain event |
| Listener | Event Handler | di `internal/event/handler/` |
| Observer | Hook / GORM Callback | Lifecycle hooks |
| Policy | Middleware / Guard | Authorization logic |
| Service Provider | bootstrap/app.go | App initialization |
| Service Container | DI constructor chain | Dependency injection |
| Eloquent ORM | GORM | `gorm.io/gorm` |
| Migration | SQL Migration (goose) | `migrations/` folder |
| Seeder | Seed command | `cmd/seed/` |
| Collection | `[]T` slice | Go slice |
| `$request` | `dto.RequestStruct` | Parsed/validated input |
| `$this` | receiver `s *Service` | Method receiver |
| `null` | `nil` | Nil value |
| `array` | `[]T` or `map[K]V` | |
| `__construct()` | `func New()` | Constructor |
| `throw new Exception()` | `return fmt.Errorf()` | Error return |
| `try/catch` | `if err != nil` | Error handling |
| `abort(404)` | `c.AbortWithStatusJSON(404, ...)` | |
| `response()->json()` | `c.JSON(statusCode, data)` | |

---

## File Path Mapping

| Source (Laravel) | Target (Go) |
|-----------------|-------------|
| `app/Http/Controllers/` | `internal/handler/` |
| `app/Services/` | `internal/service/` |
| `app/Repositories/` | `internal/repository/` |
| `app/Models/` | `internal/domain/` |
| `app/Http/Requests/` | `internal/dto/` |
| `app/Http/Resources/` | `internal/dto/` (response structs) |
| `app/Http/Middleware/` | `internal/middleware/` |
| `app/Jobs/` | `internal/worker/` |
| `app/Events/` | `internal/event/` |
| `app/Listeners/` | `internal/event/handler/` |
| `app/Exceptions/` | `pkg/apperror/` |
| `app/Providers/` | `internal/bootstrap/` |
| `app/Console/Commands/` | `cmd/cli/` |
| `database/migrations/` | `migrations/` |
| `database/seeders/` | `cmd/seed/` |
| `routes/api.php` | `internal/router/api.go` |
| `config/*.php` | `config/config.go` |
| `tests/` | `tests/` |
| `storage/` | `storage/` or cloud storage |

---

## HTTP Status Codes

| Scenario | Go Constant |
|----------|-------------|
| 200 OK | `http.StatusOK` |
| 201 Created | `http.StatusCreated` |
| 204 No Content | `http.StatusNoContent` |
| 400 Bad Request | `http.StatusBadRequest` |
| 401 Unauthorized | `http.StatusUnauthorized` |
| 403 Forbidden | `http.StatusForbidden` |
| 404 Not Found | `http.StatusNotFound` |
| 409 Conflict | `http.StatusConflict` |
| 422 Unprocessable Entity | `http.StatusUnprocessableEntity` |
| 429 Too Many Requests | `http.StatusTooManyRequests` |
| 500 Internal Server Error | `http.StatusInternalServerError` |
