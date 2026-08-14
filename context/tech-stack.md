# Tech Stack — Target Project

> This file documents the complete technology stack for the converted project (`output/`).

---

## Core

| Component | Technology | Version | Notes |
|-----------|-----------|---------|-------|
| Language | [e.g., Go] | [e.g., 1.22] | |
| HTTP Framework | [e.g., Gin] | [e.g., v1.9] | |
| ORM | [e.g., GORM] | [e.g., v2] | |
| Database | [e.g., PostgreSQL] | [e.g., 16] | |

---

## Libraries

| Package | Purpose | Import Path |
|---------|---------|-------------|
| Gin | HTTP router/framework | `github.com/gin-gonic/gin` |
| GORM | ORM | `gorm.io/gorm` |
| GORM PostgreSQL | DB driver | `gorm.io/driver/postgres` |
| godotenv | .env file loading | `github.com/joho/godotenv` |
| golang-jwt | JWT generation/validation | `github.com/golang-jwt/jwt/v5` |
| validator | Struct validation | `github.com/go-playground/validator/v10` |
| bcrypt | Password hashing | `golang.org/x/crypto/bcrypt` |
| goose | DB migrations | `github.com/pressly/goose/v3` |
| testify | Test assertions | `github.com/stretchr/testify` |
| zap / slog | Structured logging | `go.uber.org/zap` or stdlib `log/slog` |

---

## Dev Tools

| Tool | Purpose |
|------|---------|
| `go vet` | Static analysis |
| `golangci-lint` | Linting |
| `goose` | Database migrations |
| `air` | Hot reload during development |
| `mockery` | Mock generation for interfaces |

---

## Environment Variables

```env
# Application
APP_NAME=my-project
APP_ENV=development          # development | staging | production
APP_PORT=8080
APP_DEBUG=true

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myproject
DB_USER=postgres
DB_PASSWORD=secret
DB_SSL_MODE=disable

# JWT
JWT_SECRET=your-secret-key
JWT_EXPIRY_HOURS=720         # 30 days

# Storage (if applicable)
STORAGE_DRIVER=local         # local | s3
AWS_BUCKET=
AWS_REGION=
```

---

## Makefile Commands

```makefile
make run          # Start development server
make test         # Run all tests
make test-cover   # Run tests with coverage report
make build        # Build production binary
make migrate-up   # Run pending migrations
make migrate-down # Rollback last migration
make lint         # Run linter
make mock         # Generate mocks from interfaces
```
