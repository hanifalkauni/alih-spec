# Conventions: PHP Native ➔ Laravel 11 MVC

## 1. Transformasi Struktur File

```
Source (PHP Native Prosedural):
├── koneksi.php
├── index.php
├── login.php
├── cek_login.php
├── logout.php
├── user_tambah.php
├── user_simpan.php
├── user_edit.php
├── user_update.php
├── user_hapus.php
└── template/
    ├── header.php
    └── footer.php

Target (Laravel 11 MVC):
├── app/
│   ├── Http/Controllers/
│   │   ├── AuthController.php       # Menggabungkan login, cek_login, logout
│   │   └── UserController.php       # Menggabungkan index, tambah, simpan, edit, update, hapus
│   └── Models/
│       └── User.php                 # Eloquent model untuk table users
├── database/migrations/
│   └── YYYY_MM_DD_create_users_table.php
├── resources/views/
│   ├── layouts/
│   │   └── app.blade.php            # Menggabungkan header & footer
│   ├── auth/
│   │   └── login.blade.php
│   └── users/
│       ├── index.blade.php
│       ├── create.blade.php
│       └── edit.blade.php
└── routes/
    └── web.php                      # Seluruh deklarasi URL terpusat
```

---

## 2. Refactoring Best Practices

1. **Konsolidasi File CRUD**:
   - Gabungkan 5 file terpisah (`user_tambah.php`, `user_simpan.php`, `user_edit.php`, `user_update.php`, `user_hapus.php`) menjadi 1 Controller terpadu: `UserController` dengan 7 resource methods (`index`, `create`, `store`, `show`, `edit`, `update`, `destroy`).
2. **Hentikan Penggunaan `md5()` untuk Password**:
   - Jika database lama memakai MD5, buat strategi migrasi password (misal: saat login pertama berhasil dengan MD5, otomatis rehash ke `Hash::make($password)`).
3. **Standarisasi Penamaan Kolom**:
   - Gantikan `id_user`, `nama_lengkap`, `tgl_lahir` menjadi `id`, `name`, `birth_date` (atau atur `$table = '...'` dan `$primaryKey = 'id_user'` jika schema database tidak diubah).
