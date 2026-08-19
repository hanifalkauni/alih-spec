# Conventions: Laravel ➔ FastAPI Async Clean Architecture

## 1. File Structure (Target FastAPI Project)

```
output/
├── app/
│   ├── api/
│   │   └── v1/
│   │       ├── endpoints/
│   │       │   ├── auth.py          # Auth routes (login, register, me)
│   │       │   ├── users.py         # User CRUD endpoints
│   │       │   └── products.py      # Product endpoints
│   │       └── api.py               # Router aggregator (v1)
│   ├── core/
│   │   ├── config.py                # Pydantic BaseSettings & .env loader
│   │   ├── database.py              # Async SQLAlchemy engine & sessionmaker
│   │   └── security.py              # JWT token generator & password hasher
│   ├── models/                      # SQLAlchemy Declarative Models
│   │   ├── base.py
│   │   ├── user.py
│   │   └── product.py
│   ├── schemas/                     # Pydantic Request & Response DTOs
│   │   ├── auth.py
│   │   ├── user.py
│   │   └── product.py
│   ├── services/                    # Business logic layer
│   │   ├── user_service.py
│   │   └── auth_service.py
│   └── main.py                      # FastAPI Application entry point
├── alembic/                         # Database migrations
│   └── versions/
├── requirements.txt / pyproject.toml
└── .env
```

---

## 2. Naming Conventions

| Item | Laravel (PHP) | FastAPI (Python) |
|---|---|---|
| File Names | `UserController.php` (PascalCase) | `users.py` (snake_case) |
| Class Names | `UserController` (PascalCase) | `UserCreate`, `UserResponse` (PascalCase) |
| Functions & Methods | `getUserProfile()` (camelCase) | `get_user_profile()` (snake_case) |
| Database Columns | `created_at` (snake_case) | `created_at` (snake_case) |
| JSON Response Keys | `user_id` (snake_case) | `user_id` (snake_case) |
