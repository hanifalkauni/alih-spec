# Data Models & Database Schema

## Overview
This document defines the database schema for the **target** project.
All models should be implemented in `output/internal/domain/`.

---

## Conventions

- All tables use `snake_case` naming
- All tables have: `id` (PK, auto-increment), `created_at`, `updated_at`
- Soft-deletable tables also have: `deleted_at`
- Foreign key format: `{referenced_table_singular}_id`

---

## Entity Relationship Diagram

```
[users] 1──────n [posts]
   │
   └──────n [user_roles] n──────1 [roles]
```

> Replace this with your actual ERD.

---

## Tables

### `users`

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `id` | BIGINT UNSIGNED | NO | AUTO | Primary key |
| `name` | VARCHAR(100) | NO | — | Full name |
| `email` | VARCHAR(255) | NO | — | Unique email |
| `password` | VARCHAR(255) | NO | — | Hashed password |
| `email_verified_at` | TIMESTAMP | YES | NULL | Email verification |
| `remember_token` | VARCHAR(100) | YES | NULL | Remember me token |
| `created_at` | TIMESTAMP | NO | NOW() | |
| `updated_at` | TIMESTAMP | NO | NOW() | |
| `deleted_at` | TIMESTAMP | YES | NULL | Soft delete |

**Go Domain Model**:
```go
type User struct {
    gorm.Model
    Name            string     `gorm:"size:100;not null" json:"name"`
    Email           string     `gorm:"size:255;uniqueIndex;not null" json:"email"`
    Password        string     `gorm:"size:255;not null" json:"-"`
    EmailVerifiedAt *time.Time `gorm:"column:email_verified_at" json:"email_verified_at,omitempty"`
    RememberToken   *string    `gorm:"size:100" json:"-"`
}
```

---

### `[table_name]`

> Add more table definitions following the same format above.

---

## Migration Strategy

### Option 1: GORM AutoMigrate (Development)
```go
db.AutoMigrate(&domain.User{}, &domain.Product{})
```

### Option 2: SQL Migration Files (Production Recommended)
Files in `output/migrations/`:
```
001_create_users_table.sql
002_create_products_table.sql
003_add_email_verified_at_to_users.sql
```

**Recommended tool**: [goose](https://github.com/pressly/goose)
```bash
goose up        # Apply pending migrations
goose down      # Rollback last migration
goose status    # Show migration status
```

---

## Indexes

| Table | Index | Columns | Type |
|-------|-------|---------|------|
| `users` | `idx_users_email` | `email` | UNIQUE |
| `users` | `idx_users_deleted_at` | `deleted_at` | INDEX |

---

## Seed Data

Document any required seed data (roles, permissions, categories, etc.):

| Table | Description | File |
|-------|-------------|------|
| `roles` | System roles (admin, user) | `output/cmd/seed/roles.go` |
