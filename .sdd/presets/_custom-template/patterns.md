# Pattern Mapping: [Source Framework] ([Source Lang]) → [Target Framework] ([Target Lang])

> **📋 Custom Template** — Isi bagian yang relevan. Hapus bagian yang tidak ada di source/target kamu.
> Lihat `.sdd/presets/CUSTOM-PRESET-GUIDE.md` untuk panduan lengkap.

---

## Application Layer

> Mapping folder/komponen utama dari source ke target.
> Contoh: Controller → Handler, Service → Service, Model → Entity

| Source ([Source Framework]) | Target ([Target Framework]) | Notes |
|----------------------------|----------------------------|-------|
| [Komponen 1] | [Padanan di target] | [Catatan] |
| [Komponen 2] | [Padanan di target] | |
| Controllers / Views | | |
| Services | | |
| Repositories / DAOs | | |
| Models / Entities | | |
| Request validators | | |
| Response transformers | | |
| Middleware | | |
| Background jobs | | |
| Events / Listeners | | |
| Config files | | |

---

## Routing

> Bagaimana mendefinisikan route di target framework.

| Source | Target | Notes |
|--------|--------|-------|
| GET route | | |
| POST route | | |
| PUT/PATCH route | | |
| DELETE route | | |
| Route grouping | | |
| Route middleware | | |
| URL parameters | | |
| Query parameters | | |

---

## ORM / Database

> Mapping query operations dari source ORM ke target ORM.

| Source ORM | Target ORM | Notes |
|-----------|-----------|-------|
| Find by ID | | |
| Find all | | |
| Find with condition (WHERE) | | |
| Find first | | |
| Create record | | |
| Update record | | |
| Delete / Soft delete | | |
| Eager loading / Joins | | |
| Pagination | | |
| Order by | | |
| Count | | |
| Transactions | | |
| Relationships (belongs to) | | |
| Relationships (has many) | | |
| Many-to-many | | |

---

## Authentication

> Mapping auth mechanism dari source ke target.

| Source | Target | Notes |
|--------|--------|-------|
| Get current user | | |
| Auth middleware/guard | | |
| Password hashing | | |
| Password verification | | |
| Token generation | | |
| Token validation | | |

---

## Validation

> Mapping validation rules dari source ke target.

| Source Rule | Target Rule | Notes |
|------------|------------|-------|
| required | | |
| string | | |
| email | | |
| min length | | |
| max length | | |
| integer/number | | |
| boolean | | |
| nullable/optional | | |
| unique (DB check) | | |
| exists (DB check) | | |
| enum / in list | | |

---

## HTTP Response

> Bagaimana mengirim response di target framework.

| Source | Target | Notes |
|--------|--------|-------|
| 200 JSON response | | |
| 201 Created | | |
| 204 No Content | | |
| 404 Not Found | | |
| 401 Unauthorized | | |
| 403 Forbidden | | |
| 422 Validation Error | | |
| 500 Server Error | | |

---

## Configuration / Environment

> Mapping config dan environment variable.

| Source | Target | Notes |
|--------|--------|-------|
| .env loading | | |
| Config access | | |
| DB config | | |

---

## Dependency Injection

> Bagaimana DI dilakukan di target framework.

| Source | Target | Notes |
|--------|--------|-------|
| Inject dependency | | |
| Singleton | | |
| App initialization | | |

---

## Testing

> Mapping test approach dari source ke target.

| Source | Target | Notes |
|--------|--------|-------|
| Test framework | | |
| HTTP test client | | |
| Assertions | | |
| Mocking | | |
| Test fixtures / factories | | |
| DB cleanup between tests | | |
