# Module Spec: User

## 🎯 Spec Definition of Done (DoD) Checklist
- [x] **Validation & Query Parity**: Pagination params (page, per_page, search) dan update validation tercatat.
- [x] **Branching Logic Parity**: Percabangan role checking (Admin vs Self User) dan email unique validation dipetakan.
- [x] **SQL & Table Join Parity**: Query relasi user roles tercatat.
- [x] **Pointer Nullability Parity**: Field opsional seperti phone dan avatar_url bertipe pointer *string.
- [x] **No Dummy Fallback**: Seluruh data bersumber dari query DB riil.

---
## Overview
Handles user profile management — view, update, and delete user accounts.
CRUD operations for user data by authenticated users and admins.

## Source Reference
- `source/app/Http/Controllers/UserController.php`
- `source/app/Models/User.php`
- `source/app/Http/Requests/User/UpdateUserRequest.php`

## Target Output Files
- `output/internal/handler/user_handler.go`
- `output/internal/service/user_service.go`
- `output/internal/repository/user_repository.go`
- `output/internal/domain/user.go`
- `output/internal/dto/user_dto.go`
- `output/internal/domain/interfaces/user_service.go`
- `output/internal/domain/interfaces/user_repository.go`

---

## API Endpoints

### GET /api/v1/users
**Description**: List all users (admin only).
**Auth Required**: Yes — Admin role

**Query Params**:
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `page` | int | No | Page number (default: 1) |
| `per_page` | int | No | Items per page (default: 15) |
| `search` | string | No | Search by name or email |

**Success Response** `200 OK`:
```json
{
  "success": true,
  "data": [ { "id": 1, "name": "...", "email": "...", "created_at": "..." } ],
  "meta": { "page": 1, "per_page": 15, "total": 100, "total_pages": 7 }
}
```

---

### GET /api/v1/users/{id}
**Description**: Get a specific user by ID.
**Auth Required**: Yes (own profile or admin)

**Success Response** `200 OK`:
```json
{
  "success": true,
  "data": { "id": 1, "name": "John Doe", "email": "john@example.com", "created_at": "..." }
}
```

**Error Responses**:
- `404 Not Found` — User tidak ada
- `403 Forbidden` — Bukan admin dan bukan user sendiri

---

### PUT /api/v1/users/{id}
**Description**: Update user profile.
**Auth Required**: Yes (own profile or admin)

**Request Body**:
```json
{
  "name": "string (optional, min:2, max:100)",
  "email": "string (optional, email format)"
}
```

**Success Response** `200 OK`:
```json
{ "success": true, "message": "Profile updated", "data": { ... } }
```

**Error Responses**:
- `409 Conflict` — Email sudah dipakai user lain
- `422 Unprocessable Entity` — Validation error
- `403 Forbidden` — Tidak punya akses

---

### DELETE /api/v1/users/{id}
**Description**: Delete user (soft delete).
**Auth Required**: Yes — Admin only

**Success Response** `200 OK`:
```json
{ "success": true, "message": "User deleted" }
```

---

## Business Rules

- [ ] User hanya bisa melihat dan edit profil sendiri (kecuali admin)
- [ ] Admin bisa melihat, edit, dan delete semua user
- [ ] Email yang diupdate harus unik (tidak boleh sama dengan user lain)
- [ ] User yang dihapus adalah soft delete (deleted_at diisi, bukan dihapus permanent)
- [ ] User tidak bisa menghapus dirinya sendiri

---

## DTO Structs (Target)

```go
type UpdateUserRequest struct {
    Name  *string `json:"name" validate:"omitempty,min=2,max=100"`
    Email *string `json:"email" validate:"omitempty,email"`
}

type UserResponse struct {
    ID        uint      `json:"id"`
    Name      string    `json:"name"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type UserListResponse struct {
    Data []UserResponse  `json:"data"`
    Meta PaginationMeta  `json:"meta"`
}
```

---

## Interface (Target)

```go
type UserService interface {
    GetByID(ctx context.Context, id uint) (*domain.User, error)
    List(ctx context.Context, filter UserFilter) ([]domain.User, int64, error)
    Update(ctx context.Context, id uint, req dto.UpdateUserRequest) (*domain.User, error)
    Delete(ctx context.Context, id uint) error
}

type UserRepository interface {
    FindByID(ctx context.Context, id uint) (*domain.User, error)
    FindByEmail(ctx context.Context, email string) (*domain.User, error)
    List(ctx context.Context, filter UserFilter) ([]domain.User, int64, error)
    Update(ctx context.Context, user *domain.User) error
    Delete(ctx context.Context, id uint) error
}
```

---

## Acceptance Criteria

- [ ] Admin bisa list semua user dengan pagination
- [ ] User bisa lihat profil sendiri
- [ ] User bisa update nama dan emailnya sendiri
- [ ] Update email yang sudah dipakai return 409
- [ ] Admin bisa delete user (soft delete)
- [ ] User tidak bisa delete dirinya sendiri
- [ ] Non-admin tidak bisa akses data user lain

---

## Test Cases

| Test | Expected |
|------|---------|
| GET /users (admin) | 200 + list |
| GET /users (non-admin) | 403 |
| GET /users/:id (own) | 200 + user data |
| GET /users/:id (other, non-admin) | 403 |
| PUT /users/:id dengan email baru | 200 + updated |
| PUT /users/:id dengan email duplikat | 409 |
| DELETE /users/:id (admin) | 200 |
| DELETE /users/:id (non-admin) | 403 |


