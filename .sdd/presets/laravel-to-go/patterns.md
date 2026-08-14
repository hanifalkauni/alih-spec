# Pattern Mapping: Laravel (PHP) → Go (Gin + GORM)

## Application Layer

| Source (Laravel) | Target (Go/Gin) | Notes |
|-----------------|-----------------|-------|
| `app/Http/Controllers/` | `internal/handler/` | HTTP handlers |
| `app/Services/` | `internal/service/` | Business logic |
| `app/Repositories/` | `internal/repository/` | Data access |
| `app/Models/` | `internal/domain/` | Domain structs |
| `app/Http/Requests/` | `internal/dto/` (request) | Input DTOs |
| `app/Http/Resources/` | `internal/dto/` (response) | Output DTOs |
| `app/Http/Middleware/` | `internal/middleware/` | Gin middleware |
| `app/Jobs/` | `internal/worker/` | Background jobs |
| `app/Events/` | `internal/event/` | Domain events |
| `app/Listeners/` | `internal/event/handler/` | Event handlers |
| `app/Exceptions/` | `pkg/apperror/` | Custom errors |
| `app/Providers/` | `internal/bootstrap/` | App initialization |
| `app/Console/Commands/` | `cmd/cli/` | CLI commands |

## Routing

| Source (Laravel) | Target (Go/Gin) | Notes |
|-----------------|-----------------|-------|
| `routes/api.php` | `internal/router/api.go` | API routes |
| `routes/web.php` | `internal/router/web.go` | Web routes |
| `Route::get()` | `router.GET()` | |
| `Route::post()` | `router.POST()` | |
| `Route::put()` | `router.PUT()` | |
| `Route::delete()` | `router.DELETE()` | |
| `Route::group()` | `router.Group()` | |
| `Route::middleware()` | `router.Use()` | |
| `Route::resource()` | Manual CRUD routes | No auto-resource in Gin |
| `Route::apiResource()` | Manual CRUD routes | |
| `{id}` param | `:id` param | `c.Param("id")` |

## ORM (Eloquent → GORM)

| Source (Eloquent) | Target (GORM) | Notes |
|-------------------|----------------|-------|
| `Model::find($id)` | `db.First(&m, id)` | |
| `Model::findOrFail($id)` | `db.First(&m, id)` + err check | |
| `Model::all()` | `db.Find(&models)` | |
| `Model::where(...)->get()` | `db.Where(...).Find(&models)` | |
| `Model::where(...)->first()` | `db.Where(...).First(&model)` | |
| `Model::create($data)` | `db.Create(&model)` | |
| `$model->update($data)` | `db.Save(&model)` | |
| `$model->delete()` | `db.Delete(&model)` | |
| `Model::withTrashed()` | `db.Unscoped()` | |
| `Model::with('relation')` | `db.Preload("Relation")` | |
| `Model::has('relation')` | `db.Joins(...)` | |
| `Model::whereHas(...)` | `db.Joins(...).Where(...)` | |
| `$table->timestamps()` | `gorm.Model` embedded | Auto timestamps |
| `$table->softDeletes()` | `gorm.Model` embedded | Soft delete |
| `protected $fillable` | Struct tags | GORM uses structs |
| `protected $hidden` | `json:"-"` tag | |
| `protected $casts` | Typed struct fields | Go is typed |
| `$model->toArray()` | Struct to map | Use json marshal |
| `paginate($n)` | Manual offset/limit | Or use scoped query |

## Authentication

| Source (Laravel) | Target (Go) | Notes |
|-----------------|-------------|-------|
| `Auth::user()` | `c.Get("user")` | From JWT middleware |
| `Auth::id()` | `c.GetUint("userID")` | |
| `auth('sanctum')` | JWT Bearer middleware | |
| Laravel Sanctum token | `golang-jwt/jwt` | |
| `bcrypt($pass)` | `bcrypt.GenerateFromPassword()` | `golang.org/x/crypto/bcrypt` |
| `Hash::check($pass, $hash)` | `bcrypt.CompareHashAndPassword()` | |
| `Auth::guard('api')` | Custom middleware | |
| `$request->user()` | `c.Get("user").(*domain.User)` | |

## Validation

| Source (Laravel) | Target (Go) | Notes |
|-----------------|-------------|-------|
| `$request->validate([...])` | `validate.Struct(&dto)` | `go-playground/validator` |
| `required` | `validate:"required"` | |
| `email` | `validate:"email"` | |
| `min:8` | `validate:"min=8"` | |
| `max:255` | `validate:"max=255"` | |
| `unique:table,col` | Custom validator + DB check | |
| `exists:table,col` | Custom validator + DB check | |
| `nullable` | Pointer type `*string` | |
| `confirmed` | `validate:"eqfield=FieldName"` | |
| `in:a,b,c` | `validate:"oneof=a b c"` | |
| `numeric` | `validate:"numeric"` | |
| `integer` | Use `int` type in struct | |
| `array` | Use `[]T` type in struct | |

## HTTP Response

| Source (Laravel) | Target (Go/Gin) | Notes |
|-----------------|-----------------|-------|
| `response()->json($data, 200)` | `c.JSON(200, data)` | |
| `response()->json($data, 201)` | `c.JSON(201, data)` | |
| `response()->noContent()` | `c.Status(204)` | |
| `abort(404)` | `c.AbortWithStatus(404)` | |
| `abort(404, 'msg')` | `c.AbortWithStatusJSON(404, ...)` | |
| Laravel API Resource | Response DTO struct | |
| Laravel ResourceCollection | `[]ResponseDTO` | |
| `response()->paginate()` | Manual meta + data | |

## Config & Environment

| Source (Laravel) | Target (Go) | Notes |
|-----------------|-------------|-------|
| `.env` | `.env` + `godotenv` | Same pattern |
| `config('app.name')` | `cfg.App.Name` | Struct-based config |
| `config('database.default')` | `cfg.DB.Driver` | |
| `env('KEY', 'default')` | `os.Getenv("KEY")` or envconfig | |
| `config/app.php` | `config/config.go` | Go struct |
| `config/database.php` | `config/database.go` | |
| `config/mail.php` | `config/mail.go` | |
| `storage_path()` | `cfg.Storage.Path` | |

## Testing

| Source (Laravel) | Target (Go) | Notes |
|-----------------|-------------|-------|
| PHPUnit | `testing` package | Built-in |
| `$this->get('/api/...')` | `httptest.NewRequest()` + `httptest.NewRecorder()` | |
| `$this->assertStatus(200)` | `assert.Equal(t, 200, w.Code)` | testify |
| `$this->assertJson([...])` | `assert.JSONEq(t, ...)` | |
| Database factories | Test fixtures / `testdata/` | |
| `DatabaseTransactions` | DB cleanup in `TestMain` | |
| `RefreshDatabase` | Truncate tables after each test | |
| Mockery (PHP) | `mockery` (Go) or `testify/mock` | |

## Dependency Injection

| Source (Laravel) | Target (Go) | Notes |
|-----------------|-------------|-------|
| Service Container | Constructor injection | Manual or `wire` |
| `app()->make(SomeClass::class)` | Constructor params | Explicit |
| `__construct(SomeClass $dep)` | `func New(dep Dep) *Handler` | |
| Service Providers | `internal/bootstrap/app.go` | |
| Singleton binding | Package-level singleton | `sync.Once` |
| Facade | Package-level function | `pkg/somepkg.Do()` |
