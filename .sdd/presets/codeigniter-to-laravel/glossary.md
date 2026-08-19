# Glossary: CodeIgniter ➔ Laravel 11

## 1. Padanan Istilah & Konsep

| CodeIgniter Term | Laravel Term | Penjelasan |
|---|---|---|
| Active Record (CI3) / Model (CI4) | Eloquent ORM | Abstraksi interaksi database berbasis objek |
| Form Validation Library | FormRequest / Validator | Komponen validasi data masukan user |
| Hooks / Filters | Middleware | Pengecekan request sebelum masuk ke controller |
| Session Library | Session / Auth Facade | Pengelolaan sesi dan login pengguna |
| Helper Functions | Global Helpers / Collections | Fungsi pembantu format data atau string |
| `$this->load->view()` | `view('view.name')` | Render tampilan antarmuka Blade |
| Flashdata | Flash Session (`with('success', ...)`) | Pesan notifikasi 1x request |
| Auto-routing | Explicit Route Definitions | Deklarasi route terpusat di `routes/` |

---

## 2. Directory Mapping

| CodeIgniter Path | Laravel Path |
|---|---|
| `application/config/config.php` | `config/app.php` & `.env` |
| `application/config/database.php` | `config/database.php` & `.env` |
| `application/config/routes.php` | `routes/web.php` & `routes/api.php` |
| `application/controllers/` | `app/Http/Controllers/` |
| `application/models/` | `app/Models/` |
| `application/views/` | `resources/views/` |
| `application/helpers/` | `app/Helpers/` |
| `application/libraries/` | `app/Services/` |
| `application/hooks/` | `app/Http/Middleware/` |
| `assets/` | `public/` & `resources/` (Vite) |
