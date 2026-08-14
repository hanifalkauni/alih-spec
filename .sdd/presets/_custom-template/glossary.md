# Glossary: [Source Framework] ([Source Lang]) → [Target Framework] ([Target Lang])

> **📋 Custom Template** — Isi dengan padanan istilah dan path yang sesuai.
> Lihat contoh di `.sdd/presets/laravel-to-go/glossary.md` sebagai referensi.

---

## Terminology Mapping

> Daftar padanan istilah dari source ke target.
> Fokus pada istilah yang **berbeda nama** meski konsepnya sama.

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| [Istilah di source] | [Padanan di target] | [Catatan jika perlu] |
| Controller | | |
| Service | | |
| Repository / DAO | | |
| Model / Entity | | |
| Request validator | | |
| Response transformer | | |
| Middleware | | |
| Job / Task | | |
| Event | | |
| Listener / Handler | | |
| Config | | |
| Migration | | |
| Seeder | | |
| Test | | |
| Mock | | |
| [Tambahkan sesuai kebutuhan] | | |

---

## File Path Mapping

> Mapping dari path di source project ke path di target project.

| Source Path | Target Path |
|-------------|------------|
| `[source/path/to/controllers/]` | `[output/internal/handler/]` |
| `[source/path/to/services/]` | `[output/internal/service/]` |
| `[source/path/to/models/]` | `[output/internal/domain/]` |
| `[source/path/to/middleware/]` | `[output/internal/middleware/]` |
| `[source/path/to/migrations/]` | `[output/migrations/]` |
| `[source/path/to/tests/]` | `[output/tests/]` |
| `[source/path/to/config/]` | `[output/config/]` |
| `[source entry point]` | `[output/cmd/server/main.go]` |

---

## HTTP Status Code Mapping

> Bagaimana HTTP status code ditulis/direpresentasikan di target language/framework.

| Scenario | Source | Target |
|----------|--------|--------|
| 200 OK | `[source syntax]` | `[target syntax]` |
| 201 Created | | |
| 204 No Content | | |
| 400 Bad Request | | |
| 401 Unauthorized | | |
| 403 Forbidden | | |
| 404 Not Found | | |
| 409 Conflict | | |
| 422 Validation Error | | |
| 429 Too Many Requests | | |
| 500 Internal Server Error | | |

---

## Key Concept Differences

> Hal-hal yang benar-benar berbeda antara source dan target yang sering membingungkan.
> Ini adalah bagian yang paling penting untuk diisi dengan baik!

| Konsep | Di Source | Di Target | Implikasi |
|--------|----------|----------|-----------|
| Error handling | [e.g., try/catch] | [e.g., return error] | [apa yang berubah] |
| Null handling | [e.g., null] | [e.g., nil / Option<T>] | |
| Async | [e.g., async/await] | [e.g., goroutine / Promise] | |
| [Tambahkan sesuai kebutuhan] | | | |
