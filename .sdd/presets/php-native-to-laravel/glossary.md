# Glossary: PHP Native ➔ Laravel 11 MVC

## 1. Padanan Konsep & Istilah

| PHP Native Concept | Laravel 11 Term | Penjelasan |
|---|---|---|
| `mysqli_query()` / `PDO` | Eloquent ORM & Query Builder | Abstraksi query database berorientasi objek yang aman |
| File Scripting terpisah | Controller Resource Methods | Pengelompokan logika per modul |
| `include 'header.php'` | Blade `@extends` & `@section` | Pewarisan layout tampilan |
| `$_POST` / `$_GET` | `Request $request` | Object wrapper HTTP request |
| `session_start()` | Laravel Session Store | Manajemen session otomatis via cookie terenkripsi |
| `header("Location: ...")` | `redirect()->route(...)` | Navigasi halaman yang terstruktur |
| `md5()` password | `Hash::make()` (Bcrypt/Argon2) | Standar enkripsi kata sandi modern |
| Manual SQL check | `$request->validate()` | Validasi input deklaratif |

---

## 2. Path Mapping

| PHP Native File Pattern | Laravel 11 Equivalent |
|---|---|
| `koneksi.php` / `db.php` | `.env` & `config/database.php` |
| `[feature]_list.php` | `app/Http/Controllers/[Feature]Controller.php` (method `index`) |
| `[feature]_tambah.php` | `resources/views/[feature]/create.blade.php` & method `create` |
| `[feature]_simpan.php` | `app/Http/Controllers/[Feature]Controller.php` (method `store`) |
| `[feature]_edit.php` | `resources/views/[feature]/edit.blade.php` & method `edit` |
| `[feature]_update.php` | `app/Http/Controllers/[Feature]Controller.php` (method `update`) |
| `[feature]_hapus.php` | `app/Http/Controllers/[Feature]Controller.php` (method `destroy`) |
| `cek_session.php` | `app/Http/Middleware/Authenticate.php` |
