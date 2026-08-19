# Business & Architectural Rules Registry

> Satu tempat yang mengumpulkan **semua aturan arsitektur & business rules** dari seluruh modul.
> AI agent: Selalu cek file ini untuk memastikan tidak ada aturan atau percabangan yang terlewat saat implementasi.

---

## 🏛️ Core Architectural Guardrails (Wajib Dipatuhi Semua Agent)

### [RULE-ARCH-01] Deep Controller AST Inspection (Bedah Baris-demi-Baris)
**Modul**: Semua Modul (Fase 1 & 2)
**Status**: [x] Mandatory Directives
Agent **DILARANG** hanya membaca nama fungsi controller atau model secara sekilas. Agent **WAJIB** membedah seluruh baris logika controller sumber: semua query param (`menu`, `tab`, `filter`), semua percabangan kondisi `if/switch`, dan semua relasi/JOIN database sebelum membuat spesifikasi.

### [RULE-ARCH-02] Strict No Dummy Fallback (Dilarang Hardcoded Dummy Data)
**Modul**: Repository & Service Layer
**Status**: [x] Mandatory Directives
Agent **DILARANG KERAS** mengembalikan data dummy hardcoded (seperti `return 5000, nil` atau `[]map{}`) pada layer repository atau handler. Setiap method repository wajib mengeksekusi query database riil yang terhubung ke skema tabel.

### [RULE-ARCH-03] Pointer Nullability Parity (Pointer pada Nullable Fields)
**Modul**: DTO & Domain Layer
**Status**: [x] Mandatory Directives
Pada bahasa bertipe statis (Go / TypeScript), seluruh field JSON yang bersifat opsional atau nullable di database **WAJIB** menggunakan tipe pointer (`*int64`, `*string`, `*bool`). Hal ini mencegah nilai `nil/null` berubah secara salah menjadi nilai default (`0` atau `""`) pada output JSON.

### [RULE-ARCH-04] Dual Validation Checkpoints
**Modul**: Workflow Pipeline
**Status**: [x] Mandatory Directives
- **Checkpoint 1 (Spec vs Source)**: Validasi spesifikasi terhadap controller sumber sebelum membuat file task di `tasks/`.
- **Checkpoint 2 (Task vs Spec)**: Validasi kriteria task terhadap spesifikasi sebelum menulis kode di `output/`.

### [RULE-ARCH-05] Iterative Per-Module Execution
**Modul**: Workflow Pipeline
**Status**: [x] Mandatory Directives
Dilarang memproses spesifikasi atau konversi kode secara massal (*bulk*) jika proyek memiliki > 10 endpoint. Eksekusi wajib dilakukan per modul secara bertahap (Spec ➔ Validate ➔ Task ➔ Code ➔ Test).

---

## Authentication Rules

### [RULE-001] Password Hashing
**Modul**: Auth
**Spec Ref**: [`specs/modules/auth.md`](../specs/modules/auth.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/auth_service.go`

Semua password harus di-hash dengan bcrypt, cost factor minimum 12.
Plain text password tidak boleh disimpan di database.

---

### [RULE-002] JWT Token Expiry
**Modul**: Auth
**Spec Ref**: [`specs/modules/auth.md`](../specs/modules/auth.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/auth_service.go`

JWT token harus expire setelah 30 hari.
Expiry time harus dikonfigurasi via environment variable `JWT_EXPIRY_HOURS`.

---

### [RULE-003] Email Case Insensitive
**Modul**: Auth, User
**Spec Ref**: [`specs/modules/auth.md`](../specs/modules/auth.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/auth_service.go`, `output/internal/service/user_service.go`

Email address harus disimpan dalam lowercase.
Pada saat login atau lookup, email harus dinormalisasi ke lowercase dulu.

---

### [RULE-004] Rate Limiting Login
**Modul**: Auth
**Spec Ref**: [`specs/modules/auth.md`](../specs/modules/auth.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/middleware/rate_limit.go`

Endpoint `POST /auth/login` dibatasi maksimal 5 request per menit per IP.
Setelah limit tercapai, return `429 Too Many Requests`.

---

## User Rules

### [RULE-010] User Profile Authorization
**Modul**: User
**Spec Ref**: [`specs/modules/user.md`](../specs/modules/user.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/user_service.go`

User hanya bisa melihat dan edit profil miliknya sendiri, kecuali user dengan role Admin yang memiliki akses penuh ke seluruh user.

---

### [RULE-011] Unique Email on Update
**Modul**: User
**Spec Ref**: [`specs/modules/user.md`](../specs/modules/user.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/user_service.go`

Update email harus memvalidasi bahwa email baru belum digunakan oleh user lain di database (return 409 Conflict jika duplikat).

---

### [RULE-012] Prevent Self-Deletion
**Modul**: User
**Spec Ref**: [`specs/modules/user.md`](../specs/modules/user.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/user_service.go`

User (termasuk Admin) tidak diizinkan menghapus akunnya sendiri melalui endpoint delete.

---

## Product Rules

### [RULE-020] Non-Negative Pricing & Stock
**Modul**: Product
**Spec Ref**: [`specs/modules/product.md`](../specs/modules/product.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/domain/product.go`, `output/internal/dto/product_dto.go`

Nilai `price` dan `stock` tidak boleh negatif (`price >= 0` dan `stock >= 0`).

---

### [RULE-021] Unique Product Name per Category
**Modul**: Product
**Spec Ref**: [`specs/modules/product.md`](../specs/modules/product.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/service/product_service.go`

Nama produk harus unik di dalam kategori yang sama.

---

### [RULE-022] Out-of-Stock Visibility
**Modul**: Product
**Spec Ref**: [`specs/modules/product.md`](../specs/modules/product.md)
**Status**: [ ] Not Implemented
**File Target**: `output/internal/dto/product_dto.go`

Produk dengan stock 0 tetap ditampilkan di public catalog list, tetapi ditandai dengan status `out_of_stock`.

---

## Cross-Cutting Rules

### [RULE-X01] Soft Delete
**Modul**: Semua modul dengan data yang bisa dihapus
**Status**: [ ] Not Implemented

Data yang dihapus tidak boleh dihapus permanen dari database (kecuali ditetapkan berbeda).
Gunakan soft delete (`deleted_at` timestamp).

### [RULE-X02] Audit Timestamps
**Modul**: Semua
**Status**: [ ] Not Implemented

Semua record harus punya `created_at` dan `updated_at` yang diisi otomatis.

### [RULE-X03] Consistent Error Response
**Modul**: Semua
**Status**: [ ] Not Implemented

Semua error response harus mengikuti format:
```json
{ "success": false, "message": "...", "errors": {...} }
```
