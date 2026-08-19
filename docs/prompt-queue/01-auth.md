# 📦 Antrean Prompt Modul 01: Auth

- **Source Controller**: `source/app/Http/Controllers/AuthController.php`
- **Source Model**: `source/app/Models/User.php`
- **Spec Target**: `specs/modules/auth.md`
- **Task Target**: `tasks/phase-1-foundation/task-003-auth-module.md`

---

## 🌟 Opsi B: Full Cycle Modul Auth (1 Prompt Langsung Beres)

```markdown
Saya ingin mengonversi modul Auth dari `source/` ke `output/` menggunakan framework AlihSpec SDD.

Controller sumber: `source/app/Http/Controllers/AuthController.php`
Model sumber: `source/app/Models/User.php`
Spec target: `specs/modules/auth.md`
Task target: `tasks/phase-1-foundation/task-003-auth-module.md`

Tolong eksekusi siklus konversi penuh untuk modul Auth secara bertahap:

1. SPESIFIKASI (Fase 2):
   - Bedah controller `source/app/Http/Controllers/AuthController.php` baris-demi-baris (Deep Controller AST Inspection).
   - Tulis spesifikasi lengkap di `specs/modules/auth.md` menggunakan template `specs/modules/_template.md`.
   - Terapkan 8 Standar Mutu: DateTime format, Currency int64, Pagination envelope, Validation 422 object-of-arrays, Row-level locking pada mutasi saldo/stok, filter Soft-delete di JOIN, Pointer types untuk field nullable, dan Empty array `[]`.
   - Lengkapi Spec Definition of Done (DoD) Checklist.

2. CHECKPOINT 1 (Audit Keselarasan Spec vs Source):
   - Pastikan seluruh endpoint, query parameters, percabangan if/switch, dan relasi DB sudah tercatat 100%.

3. TASK BREAKDOWN (Fase 3):
   - Buat file task di `tasks/phase-1-foundation/task-003-auth-module.md` menggunakan template `tasks/_template.md` (pecah sub-tasks layer DTO ➔ Domain ➔ Repo ➔ Service ➔ Handler ➔ Tests).
   - Update `tasks/_index.md`.

4. EKSEKUSI CODING (Fase 4):
   - Tulis kode di `output/` lapis demi lapis (DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Route).
   - STRICT NO DUMMY FALLBACK: Seluruh method repository wajib kueri database riil (DILARANG hardcoded dummy).
   - Pelihara audit trail di docs/: catat ADR di `docs/decisions.md` jika ada library baru, deviasi di `docs/mapping-log.md`, riwayat di `docs/changelog.md`, dan milestone di `docs/progress.md`.

5. TESTING & CHECKPOINT 2:
   - Buat & jalankan unit test di `output/tests/`.
   - Validasi zero dummy data dan nullability parity.
   - Tandai task [x] di `tasks/_index.md`.

Tampilkan ringkasan hasil konversi modul Auth setelah selesai.
```

---

## 📋 Opsi A: Step-by-Step Modul Auth

### 1. Tulis Spec Modul Auth (Fase 2 — Deep AST Inspection)
```markdown
Tolong buatkan spesifikasi detail berstandar enterprise untuk modul Auth di `specs/modules/auth.md`.

Referensi Sumber:
- Controller: `source/app/Http/Controllers/AuthController.php`
- Model: `source/app/Models/User.php`

Gunakan template di `specs/modules/_template.md` dan terapkan aturan DEEP CONTROLLER AST INSPECTION & 8 CRITICAL QUALITY STANDARDS:
1. Bedah controller sumber baris-demi-baris:
   - Catat SEMUA query parameter (`?menu=...`, `?tab=...`, `?filter=...`, `?limit=...`, `?offset=...`, `?search=...`).
   - Petakan SEMUA percabangan logika internal (`if/switch` dan mode respons berbeda) ke dalam tabel Branching Matrix.
   - Catat SEMUA kueri SQL, Table Joins (LEFT/INNER JOIN), GROUP BY, dan agregasi kalkulasi (`COALESCE(SUM(...))`, dll.).
2. Terapkan 8 Standar Mutu Enterprise pada Spesifikasi:
   - [DateTime] Catat format serialisasi tanggal (`YYYY-MM-DD HH:mm:ss` / ISO 8601) dan timezone.
   - [Currency/Points/Coins] Gunakan tipe `int64` (basis terkecil/sen) atau exact decimal — DILARANG `float64`.
   - [Pagination] Catat struktur amplop pagination lengkap (`current_page`, `from`, `last_page`, `per_page`, `total`).
   - [Validation Error] Format error HTTP 422 wajib berupa Object of String Arrays `{"errors": {"field": ["msg"]}}`.
   - [Concurrency] Identifikasi operasi pengurangan saldo/stok yang memerlukan row-level locking (`SELECT ... FOR UPDATE`).
   - [Soft Delete] Pastikan setiap join manual menyertakan filter `AND [table].deleted_at IS NULL`.
   - [Pointer Nullability] Seluruh field DTO opsional/nullable WAJIB menggunakan tipe POINTER (`*int64`, `*string`, `*bool`).
   - [Empty State] Koleksi list kosong wajib mengembalikan array kosong `[]` (bukan `null`).
3. Lengkapi Spec Definition of Done (DoD) Checklist di bagian atas berkas.

Tunjukkan draf spesifikasi yang telah selesai untuk saya tinjau.
```

### 2. Checkpoint 1: Verifikasi Spec vs Source (Fase 2B)
```markdown
Tolong lakukan audit silang verifikasi (Checkpoint 1: Spec vs Source Alignment) untuk modul Auth:
1. Bandingkan controller sumber `source/app/Http/Controllers/AuthController.php` baris-demi-baris dengan `specs/modules/auth.md`.
2. Sajikan tabel konfirmasi audit:
   - Semua Endpoint & HTTP Method (Tercatat / Belum)
   - Semua Query Parameter (?menu=, dll)
   - Semua Percabangan if/switch Internal
   - Nullability & Pointer Types di DTO
   - Relasi Tabel, JOIN & Aggregasi DB
   - 8 Standar Mutu Enterprise
3. Jika ada parameter atau percabangan yang terlewat, langsung lengkapi spesifikasinya sekarang.
4. Berikan konfirmasi final apakah spesifikasi sudah 100% siap dibuatkan task breakdown.
```

### 3. Buat Task Breakdown Modul Auth (Fase 3)
```markdown
Berdasarkan spesifikasi di `specs/modules/auth.md` yang telah lolos Checkpoint 1:
1. Buat berkas task terperinci di `tasks/phase-1-foundation/task-003-auth-module.md` menggunakan template `tasks/_template.md`.
2. Pecah sub-task secara terisolasi dan bertingkat (Layer-by-Layer):
   - Layer 1: DTO Structs (dengan struct tags validation dan pointer types untuk field nullable)
   - Layer 2: Domain Entities & Repository/UseCase Interfaces
   - Layer 3: Repository Implementation (kueri database riil, anti-dummy, row-level locking jika mutasi saldo, filter soft-delete pada join)
   - Layer 4: Service / UseCase Layer (implementasi seluruh percabangan kondisi dan kalkulasi bisnis)
   - Layer 5: HTTP Handler & Route Wiring (DTO binding, error mapping, standard JSON response)
   - Layer 6: Unit & Contract Tests
3. Daftarkan task baru tersebut ke dalam tabel antrean di `tasks/_index.md`.
```

### 4. Eksekusi Konversi Modul Auth (Fase 4 — Strict Zero Dummy)
```markdown
Tolong konversi modul Auth dari `source/app/Http/Controllers/AuthController.php` ke `output/` sesuai spesifikasi `specs/modules/auth.md` dan task `tasks/phase-1-foundation/task-003-auth-module.md`.

Instruksi Wajib Eksekusi:
1. Baca `specs/modules/auth.md`, `tasks/phase-1-foundation/task-003-auth-module.md`, dan `context/RULES.md`.
2. Tulis kode target di `output/` lapis demi lapis:
   - DTO structs di `output/internal/dto/` (gunakan pointer untuk field nullable, format JSON envelope)
   - Domain model & interfaces di `output/internal/domain/`
   - Repository di `output/internal/repository/` (WAJIB kueri DB riil — DILARANG KERAS menggunakan hardcoded mock/dummy data!)
   - Service / UseCase di `output/internal/service/` (implementasikan seluruh logika percabangan sesuai Branching Matrix)
   - Handler di `output/internal/handler/`
   - Route registration di `output/internal/router/api.go`
3. Pastikan kode mengikuti arsitektur di `specs/architecture.md` dan konvensi di `context/conventions.md`.
4. Pelihara buku catatan & audit trail proyek secara otomatis:
   - Catat alasan arsitektur di `docs/decisions.md` (ADR) jika ada pemilihan library/desain baru.
   - Catat deviasi teknis di `docs/mapping-log.md` jika ada fitur sumber yang tidak bisa di-map 1:1.
   - Catat modul yang selesai di `docs/changelog.md` dan log milestone di `docs/progress.md`.
5. Update status task di `tasks/_index.md` menjadi `[/]` saat mulai dan `[x]` setelah selesai dan teruji.
```

### 5. Checkpoint 2: Audit Keselarasan Kode vs Spec Modul Auth (Fase 4B)
```markdown
Tolong lakukan audit verifikasi silang (Checkpoint 2: Code vs Spec Parity) untuk modul Auth:
1. Periksa seluruh method repository di `output/internal/repository/`: Apakah ada data dummy hardcoded (`return 5000, nil` atau `[]map{}`) yang tersisa?
2. Periksa apakah seluruh endpoint menangani mode query parameter (`?menu=...`, `?tab=...`) dan mengembalikan DTO yang sesuai?
3. Periksa apakah field opsional mengembalikan `null` yang aman (bukan `0` atau `""`)?
4. Jalankan unit test dan integration test di `output/tests/`.
5. Pastikan dokumentasi audit trail di `docs/changelog.md`, `docs/progress.md`, dan `docs/decisions.md` telah diperbarui.
6. Tampilkan ringkasan hasil pengujian dan konfirmasi kelayakan modul.
```
