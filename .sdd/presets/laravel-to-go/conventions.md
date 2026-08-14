# Convention Mapping: Laravel (PHP) → Go (Gin + GORM)

## Naming

| Concept | PHP/Laravel | Go | Example |
|---------|------------|-----|---------|
| Variables | `$camelCase` | `camelCase` | `$userId` → `userID` |
| Functions | `camelCase` | `camelCase` (unexported) | `getUserById` |
| Exported symbols | `PascalCase` | `PascalCase` | `UserController` → `UserHandler` |
| Constants | `UPPER_SNAKE` | `PascalCase` or `UPPER_SNAKE` | `MAX_RETRY` → `MaxRetry` |
| Files | `PascalCase.php` | `snake_case.go` | `UserController.php` → `user_handler.go` |
| Packages | `App\Http\Controllers` | `handler` | Single lowercase word |
| DB tables | `snake_case` | `snake_case` | `user_profiles` |
| DB columns | `snake_case` | `snake_case` (GORM tag) | `created_at` |
| JSON keys | `snake_case` | `snake_case` (json tag) | `"user_id"` |

## ID Fields

> In Go, always use `ID` (uppercase), never `Id`.

| PHP | Go |
|-----|-----|
| `$user->id` | `user.ID` |
| `$post->user_id` | `post.UserID` |
| `userId` | `userID` |

## File Structure

| Laravel | Go | Notes |
|---------|-----|-------|
| `UserController.php` | `user_handler.go` | |
| `UserService.php` | `user_service.go` | |
| `UserRepository.php` | `user_repository.go` | |
| `User.php` (Model) | `user.go` (domain) | |
| `UserRequest.php` | `user_dto.go` | |
| `UserResource.php` | `user_dto.go` | Same file, different structs |
| `UserPolicy.php` | `user_middleware.go` or guard func | |

## Error Handling Pattern

```go
// Source (PHP/Laravel)
throw new ModelNotFoundException("User not found");
abort(404, "Not found");

// Target (Go)
if errors.Is(err, gorm.ErrRecordNotFound) {
    return apperror.ErrNotFound
}
return fmt.Errorf("UserService.GetByID: %w", err)
```

## Response Pattern

```go
// Standard success
response.Success(c, http.StatusOK, "User retrieved", userDTO)

// Created
response.Success(c, http.StatusCreated, "User created", userDTO)

// No content
c.Status(http.StatusNoContent)

// Error
response.Error(c, http.StatusNotFound, "User not found", nil)

// Validation error
response.ValidationError(c, http.StatusUnprocessableEntity, validationErrors)
```

## Struct Tags Convention

```go
type User struct {
    gorm.Model                                             // id, created_at, updated_at, deleted_at
    Name     string  `gorm:"size:100;not null" json:"name"`
    Email    string  `gorm:"uniqueIndex;not null" json:"email"`
    Password string  `gorm:"not null" json:"-"`           // json:"-" = hidden (like $hidden)
    Age      *int    `gorm:"default:null" json:"age,omitempty"` // nullable = pointer
}
```

## DTO Convention

```go
// Request DTO (equivalent to Form Request)
type CreateUserRequest struct {
    Name     string `json:"name" validate:"required,min=2,max=100"`
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required,min=8"`
}

// Response DTO (equivalent to API Resource)
type UserResponse struct {
    ID        uint      `json:"id"`
    Name      string    `json:"name"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
}
```

## Interface Location

Always define interfaces in `internal/domain/interfaces/`:

```go
// internal/domain/interfaces/user_repository.go
type UserRepository interface {
    FindByID(ctx context.Context, id uint) (*domain.User, error)
    FindByEmail(ctx context.Context, email string) (*domain.User, error)
    Create(ctx context.Context, user *domain.User) error
    Update(ctx context.Context, user *domain.User) error
    Delete(ctx context.Context, id uint) error
}
```
