# Business Rules Registry

> Satu tempat yang mengumpulkan **semua business rule** dari seluruh modul.
> AI agent: Selalu cek file ini untuk memastikan tidak ada rule yang terlewat saat implementasi.

---

## Format

```markdown
### [RULE-XXX] Nama Rule
**Modul**: [auth / user / product / dll]
**Spec Ref**: [specs/modules/[module].md#section]
**Status**: [ ] Not Implemented | [/] In Progress | [x] Implemented
**File Target**: `output/internal/[layer]/[file].go`

Deskripsi rule dan bagaimana cara mengimplementasikannya.
```

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
