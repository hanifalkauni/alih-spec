# Pattern Mapping: CodeIgniter (CI3 / CI4) ➔ Laravel 11

> Panduan pemetaan pola desain, arsitektur, dan sintaks dari CodeIgniter (CI3/CI4) ke Laravel modern (Laravel 11+).

---

## 1. Application Layer & Folder Structure

| Source (CodeIgniter 3 / 4) | Target (Laravel 11) | Notes & Best Practices |
|---|---|---|
| `application/controllers/` (CI3)<br>`app/Controllers/` (CI4) | `app/Http/Controllers/` | Controller standar dengan Dependency Injection |
| `application/models/` (CI3)<br>`app/Models/` (CI4) | `app/Models/` | Digantikan oleh Eloquent ORM Models |
| `application/views/` (CI3)<br>`app/Views/` (CI4) | `resources/views/` | Migrasi ke Blade Templating (`.blade.php`) |
| `$this->form_validation` | `app/Http/Requests/` | FormRequest terpisah atau `$request->validate()` |
| `application/helpers/` | `app/Helpers/` atau Service Classes | Helper global didaftarkan via `composer.json` |
| `application/libraries/` | `app/Services/` | Service layer untuk logika bisnis kompleks |
| `application/hooks/` (CI3)<br>`app/Filters/` (CI4) | `app/Http/Middleware/` | HTTP Middleware |
| `application/config/routes.php` | `routes/web.php` & `routes/api.php` | Route declaration ekspresif |
| `application/config/database.php` | `.env` & `config/database.php` | Environment-based config |
| `application/migrations/` | `database/migrations/` | Schema Builder & Artisan Migrations |

---

## 2. Routing

| Source (CodeIgniter) | Target (Laravel) | Notes |
|---|---|---|
| Auto-routing URL: `/user/detail/5` | `Route::get('/users/{id}', [UserController::class, 'show'])` | Laravel menggunakan explicit route definitions |
| `$route['products'] = 'catalog/index';` | `Route::get('/products', [CatalogController::class, 'index']);` | |
| `$route['api/v1/auth'] = 'api/v1/auth/login';` | `Route::post('/api/v1/auth', [AuthController::class, 'login']);` | Gunakan `routes/api.php` |
| `$route['admin/(:any)'] = 'admin/$1';` | `Route::prefix('admin')->group(function () { ... });` | Route group & prefix |
| CI4 `$routes->resource('photos')` | `Route::resource('photos', PhotoController::class)` | RESTful Resource Routes |
| CI4 `$routes->group('api', ...)` | `Route::prefix('api')->middleware('api')->group(...)` | Middleware grouping |

---

## 3. Database & Query Handling (Query Builder ➔ Eloquent ORM)

| Source (CodeIgniter Active Record) | Target (Laravel Eloquent) | Notes |
|---|---|---|
| `$this->db->get('users')->result()` | `User::all()` | Mendapatkan semua record |
| `$this->db->get_where('users', ['id' => $id])->row()` | `User::find($id)` atau `User::findOrFail($id)` | Single record by ID |
| `$this->db->where('email', $email)->get('users')->row()` | `User::where('email', $email)->first()` | First record match |
| `$this->db->insert('users', $data);` | `User::create($data);` | Memerlukan `$fillable` di model |
| `$this->db->where('id', $id)->update('users', $data);` | `$user->update($data);` atau `User::where('id', $id)->update($data);` | Mass update |
| `$this->db->where('id', $id)->delete('users');` | `User::destroy($id);` atau `$user->delete();` | Soft delete via `use SoftDeletes;` |
| `$this->db->select('*')->join('roles', ...)` | `$user->role` | Relasi Eloquent (`belongsTo`, `hasMany`) |
| `$this->db->trans_start(); ... trans_complete();` | `DB::transaction(function () { ... });` | Auto rollback jika throw exception |
| `$this->db->query("SELECT * FROM users WHERE id = ?", [$id])` | `DB::select("SELECT * FROM users WHERE id = ?", [$id])` | Raw SQL query |
| `$this->db->count_all_results('users')` | `User::count()` | Aggregator count |
| `$this->db->limit(10, 20)` | `User::paginate(10)` atau `User::skip(20)->take(10)->get()` | Auto pagination di Blade / API |

---

## 4. Request, Input & Form Validation

| Source (CodeIgniter) | Target (Laravel) | Notes |
|---|---|---|
| `$this->input->post('name')` | `$request->input('name')` atau `$request->name` | Injeksi `Request $request` di method |
| `$this->input->get('page')` | `$request->query('page')` | Query parameter |
| `$this->input->is_ajax_request()` | `$request->ajax()` atau `$request->expectsJson()` | Deteksi AJAX / JSON header |
| `$this->input->ip_address()` | `$request->ip()` | Client IP |
| `$this->form_validation->set_rules(...)` | `$request->validate([...])` | Validasi deklaratif |
| `rules: 'required|valid_email'` | `'required|email'` | Aturan validasi |
| `rules: 'is_unique[users.email]'` | `'unique:users,email'` | Validasi unik database |
| `rules: 'matches[password]'` | `'confirmed'` | Input konfirmasi password |
| `rules: 'min_length[8]'` | `'min:8'` | Panjang karakter minimal |
| `form_error('field')` | `@error('field') {{ $message }} @enderror` | Blade error directive |

---

## 5. Authentication & Session

| Source (CodeIgniter) | Target (Laravel) | Notes |
|---|---|---|
| `$this->session->set_userdata('user', $data)` | `session(['user' => $data])` atau `Auth::login($user)` | Session state |
| `$this->session->userdata('user_id')` | `Auth::id()` atau `session('user_id')` | Autentikasi bawaan |
| `$this->session->sess_destroy()` | `Auth::logout()` & `$request->session()->invalidate()` | Logout aman |
| `$this->session->set_flashdata('msg', 'ok')` | `redirect()->back()->with('msg', 'ok')` | Flash message |
| CI3 Password hashing (`password_hash`) | `Hash::make($password)` & `Hash::check($pass, $hash)` | Bcrypt / Argon2 otomatis |
| Custom Auth helper / library | `Laravel Sanctum` / `Laravel Breeze` / `Auth::attempt()` | Ekosistem auth lengkap |

---

## 6. Views & Templating (PHP Native Views ➔ Blade)

| Source (CodeIgniter View) | Target (Laravel Blade) | Notes |
|---|---|---|
| `$this->load->view('header');`<br>`$this->load->view('content');`<br>`$this->load->view('footer');` | `@extends('layouts.app')`<br>`@section('content')`<br>`...`<br>`@endsection` | Template inheritance |
| `<?php echo $title; ?>` atau `<?= $title ?>` | `{{ $title }}` | Auto-escape HTML (aman dari XSS) |
| `<?php echo $raw_html; ?>` | `{!! $raw_html !!}` | Unescaped HTML output |
| `<?php if ($role == 'admin'): ?> ... <?php endif; ?>` | `@if($role === 'admin') ... @endif` | Blade control directives |
| `<?php foreach ($users as $u): ?> ... <?php endforeach; ?>` | `@forelse($users as $u) ... @empty ... @endforelse` | Blade loop dengan empty state |
| `base_url('assets/css/style.css')` | `asset('css/style.css')` atau `Vite::asset(...)` | Asset management |
| `site_url('users/edit/' . $id)` | `route('users.edit', $id)` | Named route |

---

## 7. HTTP Response & API JSON

| Source (CodeIgniter) | Target (Laravel) | Notes |
|---|---|---|
| `$this->output->set_content_type('application/json')->set_output(json_encode($data));` | `response()->json($data, 200)` | Fluent response helper |
| `show_404()` | `abort(404, 'Resource not found')` | Exception handling otomatis |
| `redirect('dashboard')` | `redirect()->route('dashboard')` | Named route redirect |
| CI4 `$this->respond($data, 200)` | `new UserResource($user)` | Laravel API Resource transformer |
| CI4 `$this->failNotFound('msg')` | `response()->json(['message' => 'msg'], 404)` | Standardized API error format |
