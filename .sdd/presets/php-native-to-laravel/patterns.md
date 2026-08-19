# Pattern Mapping: PHP Native (Prosedural) ➔ Laravel 11

> Panduan modernisasi kode PHP Native / Prosedural lawas (`mysqli_*`, file-based routing, HTML campur PHP) ke Laravel 11 MVC yang bersih, aman, dan modular.

---

## 1. Arsitektur File & Routing

| Source (PHP Native Prosedural) | Target (Laravel 11 MVC) | Penjelasan & Solusi |
|---|---|---|
| `koneksi.php` / `config.php` | `.env` & `config/database.php` | Konfigurasi database terpusat dan aman |
| File routing: `tambah_user.php`, `proses_simpan.php` | `Route::get('/users/create', ...)` & `Route::post('/users', ...)` | Dipisah menjadi Route HTTP eksplisit di `routes/web.php` |
| `edit.php?id=5` & `proses_update.php` | `Route::get('/users/{id}/edit', ...)` & `Route::put('/users/{id}', ...)` | RESTful routing dengan Route Model Binding |
| `hapus.php?id=5` | `Route::delete('/users/{id}', [UserController::class, 'destroy'])` | Menggunakan HTTP DELETE yang aman dari CSRF |
| `include 'header.php';`<br>`include 'sidebar.php';`<br>`include 'footer.php';` | `@extends('layouts.app')`<br>`@section('content') ... @endsection` | Blade Layout Templating tunggal |
| Kode logic SQL di atas halaman HTML | `app/Http/Controllers/` & `app/Services/` | Pemisahan penuh antara logika bisnis dan view |

---

## 2. Operasi Database (`mysqli_*` / `mysql_*` ➔ Eloquent ORM)

| Source (PHP Native `mysqli`) | Target (Laravel Eloquent) | Notes |
|---|---|---|
| `$conn = mysqli_connect(...)` | `DB` connection bawaan Laravel | Otomatis dikelola oleh framework |
| `$q = mysqli_query($conn, "SELECT * FROM users");`<br>`while($row = mysqli_fetch_array($q)) { ... }` | `$users = User::all();`<br>`@foreach($users as $user) ... @endforeach` | Eloquent Collection & Blade loop |
| `$q = mysqli_query($conn, "SELECT * FROM users WHERE id='$id'");`<br>`$data = mysqli_fetch_assoc($q);` | `$user = User::findOrFail($id);` | Mencegah SQL Injection via Prepared Statements otomatis |
| `mysqli_query($conn, "INSERT INTO users (name, email) VALUES ('$name', '$email')");` | `User::create($request->validated());` | Aman dengan `$fillable` & validasi |
| `mysqli_query($conn, "UPDATE users SET name='$name' WHERE id='$id'");` | `$user->update($request->validated());` | Clean Eloquent update |
| `mysqli_query($conn, "DELETE FROM users WHERE id='$id'");` | `$user->delete();` | Mendukung Soft Delete jika diinginkan |
| `mysqli_num_rows($q)` | `User::count()` atau `$users->count()` | Aggregator count |
| `mysqli_insert_id($conn)` | `$user->id` | ID record baru langsung tersedia |
| `mysqli_real_escape_string($conn, $input)` | *Tidak diperlukan* | PDO Parameter Binding otomatis mencegah SQL Injection |

---

## 3. Form Input, Validasi & Keamanan (Security)

| Source (PHP Native) | Target (Laravel 11) | Keuntungan Keamanan |
|---|---|---|
| `$_POST['username']` | `$request->input('username')` atau `$request->username` | Sanitasi & null handling |
| `$_GET['search']` | `$request->query('search')` | Aman dari undefined index error |
| `$_FILES['foto']['name']` | `$request->file('foto')->store('avatars', 'public')` | File upload storage manager |
| Validasi manual `if(empty($_POST['nama'])) { echo "kosong"; }` | `$request->validate(['nama' => 'required|min:3'])` | Validasi deklaratif dengan pesan error otomatis |
| Form tanpa proteksi | `@csrf` directive di dalam `<form>` | Mencegah serangan CSRF |
| `echo $data['nama'];` (Rentan XSS) | `{{ $user->nama }}` (Auto HTML-escaped) | Kebal serangan Cross-Site Scripting (XSS) |

---

## 4. Autentikasi & Session

| Source (PHP Native) | Target (Laravel 11) | Penjelasan |
|---|---|---|
| `session_start();` | Dikelola otomatis oleh middleware Laravel | Tidak perlu manual start session |
| `$_SESSION['login'] = true;`<br>`$_SESSION['user_id'] = $row['id'];` | `Auth::login($user);` atau `session(['user_id' => $user->id])` | Session handling aman |
| Pengecekan `if(!isset($_SESSION['login'])) { header('location:login.php'); }` | `Route::middleware('auth')->group(...)` | Auth Middleware otomatis me-redirect guest ke `/login` |
| `session_destroy();` | `Auth::logout();` & `$request->session()->invalidate();` | Logout aman & regenerasi session ID |
| `md5($_POST['password'])` *(Sangat Rentan!)* | `Hash::make($password)` & `Hash::check($pass, $hash)` | Algoritma Bcrypt / Argon2 modern yang aman |
