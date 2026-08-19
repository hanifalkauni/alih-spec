# Glossary: CodeIgniter ➔ Go (Gin + GORM)

## 1. Terminology Mapping

| CodeIgniter Term | Go (Gin + GORM) Term | Keterangan |
|---|---|---|
| Controller | Handler | Menangani HTTP request/response |
| Model (Active Record) | Repository + Domain Model | Domain untuk struktur data, Repository untuk query DB |
| Library | Service | Layer kalkulasi logika bisnis |
| Form Validation | DTO Struct Tags | Validasi tipe data dan tag `validate:"..."` |
| Session | JWT Claims / Context Value | Autentikasi stateless via Bearer Token |
| Hooks / Filters | Middleware | Interceptor HTTP request |
| Auto-routing | Explicit Router Grouping | Registrasi route via `router.GET`, `router.POST` |
| Flashdata | Response JSON message | Notifikasi API via payload JSON |

---

## 2. Directory Mapping

| CodeIgniter Path | Go Clean Architecture Path |
|---|---|
| `application/controllers/` | `internal/handler/` |
| `application/models/` | `internal/repository/` & `internal/domain/` |
| `application/libraries/` | `internal/service/` |
| `application/hooks/` | `internal/middleware/` |
| `application/config/routes.php` | `internal/router/api.go` |
| `application/config/database.php` | `config/database.go` & `.env` |
