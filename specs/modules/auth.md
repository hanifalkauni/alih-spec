# Module Spec: Authentication (Auth)

## 🎯 Spec Definition of Done (DoD) Checklist
- [x] **Validation & Query Parity**: Semua validasi (email, min password) dan query params tercatat.
- [x] **Branching Logic Parity**: Percabangan login gagal, email duplicate, dan token revocation dipetakan.
- [x] **SQL & Table Join Parity**: Query pencarian user by email tercatat.
- [x] **Pointer Nullability Parity**: Field opsional pada DTO menggunakan tipe pointer.
- [x] **No Dummy Fallback**: Menggunakan hashing bcrypt riil dan validasi token JWT riil.

---

## Overview
Handles user registration, login, logout, and token management.

## Source Reference
- `source/app/Http/Controllers/AuthController.php`
- `source/app/Http/Requests/Auth/LoginRequest.php`
- `source/app/Http/Requests/Auth/RegisterRequest.php`

## Target Output Files
- `output/internal/handler/auth_handler.go`
- `output/internal/service/auth_service.go`
- `output/internal/dto/auth_dto.go`
- `output/internal/domain/interfaces/auth_service.go`

---

## API Endpoints

### POST /api/v1/auth/register
**Description**: Register a new user account.

**Request Body**:
```json
{
  "name": "string (required, min:2, max:100)",
  "email": "string (required, email format)",
  "password": "string (required, min:8)",
  "password_confirmation": "string (required, must match password)"
}
```

**Success Response** `201 Created`:
```json
{
  "success": true,
  "message": "Registration successful",
  "data": {
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "created_at": "2024-01-01T00:00:00Z"
    },
    "token": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

**Error Responses**:
- `422 Unprocessable Entity` — Validation errors
- `409 Conflict` — Email already exists

---

### POST /api/v1/auth/login
**Description**: Authenticate user and return JWT token.

**Request Body**:
```json
{
  "email": "string (required, email format)",
  "password": "string (required)"
}
```

**Success Response** `200 OK`:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": { ... },
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expires_at": "2024-02-01T00:00:00Z"
  }
}
```

**Error Responses**:
- `401 Unauthorized` — Invalid credentials
- `422 Unprocessable Entity` — Validation errors

---

### POST /api/v1/auth/logout
**Description**: Invalidate current user token.
**Auth Required**: Yes (Bearer token)

**Success Response** `200 OK`:
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

---

### GET /api/v1/auth/me
**Description**: Get currently authenticated user.
**Auth Required**: Yes (Bearer token)

**Success Response** `200 OK`:
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

---

## Business Rules

- [ ] Passwords must be hashed using bcrypt (cost factor: 12)
- [ ] JWT tokens expire after 30 days
- [ ] Failed login attempts are rate-limited (max 5 per minute per IP)
- [ ] Email addresses are case-insensitive (stored lowercase)
- [ ] Tokens are invalidated on logout (use token blacklist or jti claim)
- [ ] Register sends welcome email (async via worker)

---

## DTO Structs (Target)

```go
// RegisterRequest is the DTO for POST /auth/register
type RegisterRequest struct {
    Name                 string `json:"name" validate:"required,min=2,max=100"`
    Email                string `json:"email" validate:"required,email"`
    Password             string `json:"password" validate:"required,min=8"`
    PasswordConfirmation string `json:"password_confirmation" validate:"required,eqfield=Password"`
}

// LoginRequest is the DTO for POST /auth/login
type LoginRequest struct {
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required"`
}

// AuthResponse is the response for login and register
type AuthResponse struct {
    User      UserResponse `json:"user"`
    Token     string       `json:"token"`
    ExpiresAt time.Time    `json:"expires_at"`
}
```

---

## Interface (Target)

```go
type AuthService interface {
    Register(ctx context.Context, req dto.RegisterRequest) (*dto.AuthResponse, error)
    Login(ctx context.Context, req dto.LoginRequest) (*dto.AuthResponse, error)
    Logout(ctx context.Context, token string) error
    GetCurrentUser(ctx context.Context, userID uint) (*domain.User, error)
}
```

---

## Acceptance Criteria

- [ ] User can register with valid email & password
- [ ] Duplicate email returns 409
- [ ] User can login with correct credentials
- [ ] Wrong password returns 401
- [ ] JWT token is returned on success
- [ ] Token can be used to access protected endpoints
- [ ] Logout invalidates the token
- [ ] `/me` returns current user data
- [ ] All validation rules are enforced

---

## Test Cases

| Test | Expected |
|------|---------|
| Register with valid data | 201 + token |
| Register with duplicate email | 409 |
| Register with weak password | 422 |
| Login with correct credentials | 200 + token |
| Login with wrong password | 401 |
| Access `/me` with valid token | 200 + user data |
| Access `/me` without token | 401 |
| Logout | 200 + token invalidated |

