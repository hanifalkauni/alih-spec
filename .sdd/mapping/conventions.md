# Code Convention Mapping: Source → Target

> Defines how naming, file organization, and coding style conventions
> map from the source to target language/framework.

---

## Naming Conventions

### Variables & Functions

| Source (PHP/Laravel) | Target (Go) | Example |
|---------------------|-------------|---------|
| `camelCase` functions | `camelCase` (unexported) | `getUserById` |
| `PascalCase` methods | `PascalCase` (exported) | `GetUserById` |
| `snake_case` DB columns | `snake_case` DB tags | `first_name` in GORM tag |
| `$variable` | `variable` | No `$` prefix |
| `CONSTANT_CASE` | `PascalCase` or `CONSTANT_CASE` | `MaxRetries` |

### Files & Folders

| Source (PHP/Laravel) | Target (Go) | Notes |
|---------------------|-------------|-------|
| `UserController.php` | `user_handler.go` | snake_case filenames |
| `app/Models/User.php` | `internal/domain/user.go` | |
| `app/Http/Controllers/` | `internal/handler/` | |
| `app/Services/` | `internal/service/` | |
| `app/Repositories/` | `internal/repository/` | |
| `database/migrations/` | `migrations/` | |

### Database

| Source (Laravel) | Target (Go/GORM) | Notes |
|-----------------|-----------------|-------|
| Table: `users` | Table: `users` | Same convention |
| Column: `created_at` | Column: `created_at` | Same |
| Foreign key: `user_id` | Foreign key: `user_id` | Same |
| Model: `User` | Struct: `User` | PascalCase |
| Pivot table: `role_user` | Join table: `role_users` | |

### API Endpoints

| Pattern | Convention | Example |
|---------|-----------|---------|
| Resource | `kebab-case` | `/api/v1/user-profiles` |
| Version prefix | `/api/vX/` | `/api/v1/` |
| Action | REST verbs | GET, POST, PUT, DELETE |

---

## File Header Convention

Every output file should start with:

```go
// Package [name] provides [brief description].
//
// Source reference: [path to equivalent source file]
// Spec: [path to spec file]
package [name]
```

---

## Error Handling Convention

### Source (PHP/Laravel)
```php
throw new ValidationException($validator);
```

### Target (Go)
```go
if err != nil {
    return fmt.Errorf("validation failed: %w", err)
}
```

- Always wrap errors with `%w` for unwrapping support
- Use custom error types defined in `pkg/apperror/`
- Return errors up the stack, handle at handler layer

---

## Response Format Convention

All API responses follow this structure:

```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... },
  "meta": {
    "page": 1,
    "per_page": 15,
    "total": 100
  }
}
```

Error response:
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "email": ["The email field is required."]
  }
}
```

---

## Import Organization (Target: Go)

Order imports as follows:
1. Standard library
2. Third-party packages
3. Internal packages

```go
import (
    "context"
    "fmt"

    "github.com/gin-gonic/gin"
    "gorm.io/gorm"

    "github.com/yourorg/project/internal/domain"
    "github.com/yourorg/project/pkg/apperror"
)
```

---

## Test File Convention

| Convention | Rule |
|-----------|------|
| Test files | Same package, `_test.go` suffix |
| Test functions | `TestFunctionName_Scenario` |
| Mock files | `mocks/` subdirectory |
| Fixtures | `testdata/` subdirectory |
