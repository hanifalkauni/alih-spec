# Coding Conventions — Target Project

> ⚙️ **File ini di-generate otomatis dari preset yang dipilih.**
>
> **Jangan edit manual.** Jalankan `scripts/sdd-init` untuk mengisi file ini
> sesuai preset yang sesuai dengan conversion pair kamu.
>
> Atau copy manual dari preset yang sesuai:
> ```
> copy .sdd\presets\[preset-name]\conventions.md context\conventions.md
> ```

---

> **Jika kamu melihat konten kosong di bawah ini**, jalankan init script terlebih dahulu:
> ```powershell
> .\scripts\sdd-init.ps1
> ```

<!-- PRESET CONTENT STARTS HERE — auto-populated by sdd-init -->



---

## File & Folder Naming

| Rule | Convention | Example |
|------|-----------|---------|
| Go source files | `snake_case.go` | `user_handler.go` |
| Test files | `[file]_test.go` | `user_handler_test.go` |
| Packages | `lowercase`, single word | `handler`, `service` |
| Directories | `snake_case` | `internal/`, `pkg/` |

---

## Struct & Interface Naming

| Rule | Convention | Example |
|------|-----------|---------|
| Exported structs | `PascalCase` | `UserHandler` |
| Unexported structs | `camelCase` | `userConfig` |
| Interfaces | `PascalCase`, noun | `UserRepository` |
| Methods | `PascalCase` (exported) | `GetByID`, `Create` |

---

## Variable Naming

| Rule | Convention | Example |
|------|-----------|---------|
| Local variables | `camelCase` | `userID`, `authToken` |
| ID fields | `ID` (not `Id`) | `UserID`, `ProductID` |
| Acronyms | All caps | `HTTP`, `URL`, `ID` |
| Context param | Always `ctx` | `ctx context.Context` |
| Gin context | Always `c` | `c *gin.Context` |
| Error variable | `err` | `if err != nil` |

---

## Error Handling

```go
// ✅ Correct — always wrap errors
result, err := service.GetUser(ctx, id)
if err != nil {
    return fmt.Errorf("UserHandler.GetUser: %w", err)
}

// ✅ Use apperror package for domain errors
if user == nil {
    return apperror.ErrNotFound
}

// ❌ Wrong — never ignore errors
result, _ := service.GetUser(ctx, id)

// ❌ Wrong — never use errors.New for domain errors
return errors.New("user not found")
```

---

## HTTP Response Format

Always use the `pkg/response` package:

```go
// Success with data
response.Success(c, http.StatusOK, "User retrieved", user)

// Success without data
response.SuccessMessage(c, http.StatusOK, "Operation successful")

// Error
response.Error(c, http.StatusNotFound, "User not found", nil)

// Validation error
response.ValidationError(c, http.StatusUnprocessableEntity, err)
```

---

## Dependency Injection

```go
// ✅ Correct — constructor injection
type UserHandler struct {
    userService interfaces.UserService
}

func NewUserHandler(userService interfaces.UserService) *UserHandler {
    return &UserHandler{userService: userService}
}

// ❌ Wrong — never use global variables for dependencies
var userService = service.NewUserService()
```

---

## Context Propagation

Always pass `context.Context` as the **first argument**:

```go
// ✅ Correct
func (s *UserService) GetByID(ctx context.Context, id uint) (*domain.User, error) { ... }

// ❌ Wrong — missing context
func (s *UserService) GetByID(id uint) (*domain.User, error) { ... }
```

---

## Logging

Use the `pkg/logger` package, never `fmt.Println`:

```go
// ✅ Correct
logger.Info("user created", "userID", user.ID)
logger.Error("failed to create user", "error", err)

// ❌ Wrong
fmt.Println("user created:", user.ID)
log.Printf("error: %v", err)
```

---

## File Header Comment

Every source file should start with:

```go
// Package [name] provides [description].
//
// Source reference: [path/to/equivalent/source/file]
// Spec: [path/to/spec/file]
package [name]
```

---

## Import Grouping

```go
import (
    // 1. Standard library
    "context"
    "fmt"
    "net/http"

    // 2. Third-party (blank line separator)
    "github.com/gin-gonic/gin"
    "gorm.io/gorm"

    // 3. Internal packages (blank line separator)
    "github.com/yourorg/project/internal/domain"
    "github.com/yourorg/project/pkg/apperror"
)
```

---

## Test Conventions

```go
// Function naming: TestFunctionName_Scenario
func TestUserService_GetByID_ReturnsUser(t *testing.T) { ... }
func TestUserService_GetByID_UserNotFound_ReturnsError(t *testing.T) { ... }

// Use testify for assertions
assert.NoError(t, err)
assert.Equal(t, expected, actual)
require.NotNil(t, result)
```
