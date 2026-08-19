# Conventions: CodeIgniter ➔ Laravel 11

## 1. Naming Conventions

| Item | CodeIgniter (CI3/CI4) | Laravel Target | Contoh Laravel |
|---|---|---|---|
| Controller Class | `User_controller` / `User` | StudlyCaps + `Controller` | `UserController` |
| Controller File | `User_controller.php` | `app/Http/Controllers/UserController.php` |
| Model Class | `M_user` / `UserModel` | Singular StudlyCaps | `User` |
| Model File | `M_user.php` | `app/Models/User.php` |
| Table Name | `users` / `tbl_users` | Plural snake_case (tanpa prefix `tbl_`) | `users` |
| Primary Key | `id` / `user_id` | `id` (bigIncrements) | `id` |
| Foreign Key | `role_id` / `id_role` | `[model]_id` | `role_id` |
| View File | `user_list.php` | `resources/views/users/index.blade.php` |
| Migration File | `2026_01_01_create_user.php` | `database/migrations/YYYY_MM_DD_HHMMSS_create_users_table.php` |

---

## 2. Best Practices Refactoring

1. **Hilangkan Prefix `M_` atau `tbl_`**:
   - Model `M_kategori.php` diubah menjadi `Category.php`.
   - Tabel `tbl_barang` diubah menjadi `products` (atau definisikan `protected $table = 'tbl_barang';` jika database lama tidak diubah).
2. **Ubah Prosedural `$this->load` menjadi Injeksi Class / Eloquent**:
   - Jangan gunakan `$this->load->model('M_user')`. Panggil langsung `User::find($id)` atau inject `UserRepositoryInterface` di constructor.
3. **Pindahkan Logika Bisnis dari Controller**:
   - Jangan biarkan controller memuat query database ratusan baris. Pindahkan query ke Eloquent Model, Scopes, atau Service Class di `app/Services/`.
4. **Gunakan Blade Components / Layouts**:
   - Gantikan pola include `$this->load->view('header')` dan `$this->load->view('footer')` dengan satu Blade Layout `@extends('layouts.app')`.
