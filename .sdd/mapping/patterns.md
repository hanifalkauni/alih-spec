# Design Pattern Mapping: Source → Target

> This file maps design patterns and architectural concepts from the **source** language/framework
> to equivalent concepts in the **target** language/framework.
>
> **Fill this in based on your specific conversion pair.**

---

## Example: Laravel (PHP) → Golang (Gin + GORM)

### Application Layer

| Source (Laravel) | Target (Golang/Gin) | Notes |
|-----------------|---------------------|-------|
| `app/Http/Controllers/` | `internal/handler/` | HTTP request handlers |
| `app/Services/` | `internal/service/` | Business logic layer |
| `app/Repositories/` | `internal/repository/` | Data access layer |
| `app/Models/` | `internal/domain/` | Domain models / entities |
| `app/Http/Requests/` | `internal/dto/` | Data Transfer Objects |
| `app/Http/Middleware/` | `internal/middleware/` | Gin middleware |
| `app/Jobs/` | `internal/worker/` | Background workers |
| `app/Events/` | `internal/event/` | Event system |
| `app/Listeners/` | `internal/event/handler/` | Event handlers |
| `app/Exceptions/` | `pkg/apperror/` | Custom error types |

### Routing

| Source (Laravel) | Target (Golang/Gin) | Notes |
|-----------------|---------------------|-------|
| `routes/api.php` | `internal/router/api.go` | API route definitions |
| `routes/web.php` | `internal/router/web.go` | Web route definitions |
| `Route::group()` | `router.Group()` | Route grouping |
| `Route::middleware()` | `router.Use()` | Middleware registration |
| `Route::resource()` | Manual CRUD routes | No auto-resource in Gin |

### Database / ORM

| Source (Laravel/Eloquent) | Target (GORM) | Notes |
|--------------------------|----------------|-------|
| `Model::find($id)` | `db.First(&model, id)` | Find by primary key |
| `Model::where(...)->get()` | `db.Where(...).Find(&models)` | Query with condition |
| `Model::create($data)` | `db.Create(&model)` | Insert record |
| `$model->update($data)` | `db.Save(&model)` | Update record |
| `$model->delete()` | `db.Delete(&model)` | Soft/hard delete |
| `Model::with('relation')` | `db.Preload("Relation")` | Eager loading |
| `$table->timestamps()` | `gorm.Model` embedded struct | Auto timestamps |
| Migration files | GORM AutoMigrate or goose | Schema migration |

### Authentication

| Source (Laravel) | Target (Golang) | Notes |
|-----------------|-----------------|-------|
| `Auth::user()` | `c.Get("user")` from middleware | Get current user |
| `auth('sanctum')` | JWT middleware | Token-based auth |
| Laravel Sanctum | `golang-jwt/jwt` | JWT library |
| `bcrypt()` | `golang.org/x/crypto/bcrypt` | Password hashing |

### Validation

| Source (Laravel) | Target (Golang) | Notes |
|-----------------|-----------------|-------|
| Form Request Validation | `go-playground/validator` | Struct validation tags |
| `$request->validate([...])` | `validate.Struct(&dto)` | Validate DTO struct |
| Custom Rule classes | Custom validator functions | Extend validator |

### Configuration

| Source (Laravel) | Target (Golang) | Notes |
|-----------------|-----------------|-------|
| `config/*.php` | `config/config.go` or env | Config structs |
| `.env` | `.env` + `godotenv` | Same pattern |
| `config('app.key')` | `cfg.App.Key` | Config access |

### Dependency Injection

| Source (Laravel) | Target (Golang) | Notes |
|-----------------|-----------------|-------|
| Service Container | Manual DI or `wire` | Constructor injection |
| `app()->make()` | Constructor params | Explicit DI |
| Service Providers | `internal/bootstrap/` | App initialization |

### HTTP Response

| Source (Laravel) | Target (Golang/Gin) | Notes |
|-----------------|---------------------|-------|
| `response()->json($data, 200)` | `c.JSON(200, data)` | JSON response |
| `response()->json($data, 422)` | `c.JSON(422, data)` | Validation error |
| `abort(404)` | `c.AbortWithStatus(404)` | Abort request |
| Laravel Resources | Manual response structs | Response transformation |

### Testing

| Source (Laravel) | Target (Golang) | Notes |
|-----------------|-----------------|-------|
| PHPUnit | `testing` package | Built-in test framework |
| `$this->get('/api/...')` | `httptest.NewRequest()` | HTTP test helpers |
| Factories | Test fixtures / mocks | Test data generation |
| `DatabaseTransactions` | Test DB with cleanup | Isolate test data |

---

## How to Use This File

1. **Replace** the example section above with your actual source/target pair
2. **Expand** rows as you discover new mappings during conversion
3. **Reference** this file when writing `specs/modules/*.md`
4. **AI agents** should read this file to understand concept mapping

---

## Template for Other Language Pairs

```markdown
## [Source Framework] → [Target Framework]

### [Category]

| Source | Target | Notes |
|--------|--------|-------|
| ... | ... | ... |
```
