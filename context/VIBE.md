# ⚡ Bank Prompt Vibe Coding (AlihSpec SDD) — Edisi Standar Mutu Enterprise

> Kumpulan prompt siap pakai berpresisi tinggi untuk kamu yang ingin **Full Vibe Coding**.
> Dirancang khusus untuk memandu AI Coding Agents (Antigravity, Cursor, Kiro, Copilot, Windsurf, Claude Code) agar menghasilkan konversi kode yang **100% akurat, zero logic drift, dan bebas bug laten**.

---

## 🧭 Panduan Memilih Prompt

- **Proyek Sedang / Besar (> 5 Modul)**: Gunakan **Prompt Fase 1 s/d Fase 5** secara bertahap dengan *Dual Validation Checkpoints*.
- **Proyek Kecil (< 5 Modul)**: Gunakan **Prompt One-Shot Master** di bagian bawah.

---

## 🎯 DAFTAR PROMPT BERDASARKAN FASE

---

### 🔍 1. Analisis Sumber Mendalam (Fase 1)

```markdown
Saya baru menginisialisasi framework AlihSpec untuk mengonversi proyek ini.
Source code proyek sumber berada di folder `source/`.

Tolong lakukan analisis mendalam terhadap seluruh codebase di `source/`:
1. Baca berkas `context/AGENTS.md` dan `evaluate/evaluation-specs-mismatch.md` untuk memahami standar mutu dan aturan pencegahan spesifikasi dangkal (shallow specs).
2. Baca `.sdd/config.yaml` dan `context/tech-stack.md` untuk memahami bahasa dan framework target.
3. Bedah seluruh folder `source/` dan buatkan laporan komprehensif yang mencakup:
   - Daftar seluruh modul bisnis (Auth, User, Product, Wallet/Coin, Order, dll.)
   - Pemetaan seluruh Route & Endpoint (HTTP Method, URI, Controller Action, Middleware terpasang)
   - Seluruh Schema Database, Relasi antar Tabel (1:1, 1:N, N:M), Foreign Keys, Enum values, dan Index
   - Dependensi penting pihak ketiga dari package manager (composer.json / package.json / requirements.txt)
   - Identifikasi algoritma hashing password dan struktur token JWT asli (nama key payload/claims: sub, uid, user_id, dll.)

Tuliskan hasil analisis terstruktur ini ke dalam berkas `specs/overview.md`.
```

---

### 📋 2. Tulis Spesifikasi Modul — Deep AST Inspection (Fase 2)

```markdown
Tolong buatkan spesifikasi detail berstandar enterprise untuk modul [NAMA_MODUL] di `specs/modules/[nama-modul].md`.

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

---

### 🛑 2B. Checkpoint 1: Verifikasi Keselarasan Spec vs Source

```markdown
Tolong lakukan audit silang verifikasi (Checkpoint 1: Spec vs Source Alignment) untuk modul [NAMA_MODUL]:
1. Bandingkan controller sumber di `source/` baris-demi-baris dengan `specs/modules/[nama-modul].md`.
2. Sajikan tabel konfirmasi audit dengan format:
   | Item Audit | Status (Lengkap / Kurang) | Catatan Verifikasi |
   |---|---|---|
   | Semua Endpoint & HTTP Method | ... | ... |
   | Semua Query Parameter (?menu=, dll) | ... | ... |
   | Semua Percabangan if/switch Internal | ... | ... |
   | Nullability & Pointer Types di DTO | ... | ... |
   | Relasi Tabel, JOIN & Aggregasi DB | ... | ... |
   | 8 Standar Mutu Enterprise | ... | ... |
3. Jika ada parameter atau percabangan yang terlewat, langsung lengkapi spesifikasinya sekarang.
4. Berikan konfirmasi final apakah spesifikasi sudah 100% siap dibuatkan task breakdown.
```

---

### 🗂️ 3. Buat Task Breakdown Berlapis (Fase 3)

```markdown
Berdasarkan spesifikasi di `specs/modules/[nama-modul].md` yang telah lolos Checkpoint 1:
1. Buat berkas task terperinci di `tasks/phase-2-core-modules/task-[nomor]-[nama-modul].md` menggunakan template `tasks/_template.md`.
2. Pecah sub-task secara terisolasi dan bertingkat (Layer-by-Layer):
   - Layer 1: DTO Structs (dengan struct tags validation dan pointer types untuk field nullable)
   - Layer 2: Domain Entities & Repository/UseCase Interfaces
   - Layer 3: Repository Implementation (kueri database riil, anti-dummy, row-level locking jika mutasi saldo, filter soft-delete pada join)
   - Layer 4: Service / UseCase Layer (implementasi seluruh percabangan kondisi dan kalkulasi bisnis)
   - Layer 5: HTTP Handler & Route Wiring (DTO binding, error mapping, standard JSON response)
   - Layer 6: Unit & Contract Tests
3. Daftarkan task baru tersebut ke dalam tabel antrean di `tasks/_index.md`.
```

---

### 🚀 4. Eksekusi Konversi Modul — Strict Zero Dummy (Fase 4)

```markdown
Tolong konversi modul [NAMA_MODUL] dari `source/` ke `output/` sesuai spesifikasi dan task breakdown yang ada.

Instruksi Wajib Eksekusi:
1. Baca `specs/modules/[nama-modul].md`, `tasks/.../task-[nomor]-[nama-modul].md`, dan `context/RULES.md`.
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

---

### 🛑 4B. Checkpoint 2: Audit Keselarasan Kode Target vs Spesifikasi

```markdown
Tolong lakukan audit verifikasi silang (Checkpoint 2: Code vs Spec Parity) untuk modul [NAMA_MODUL]:
1. Periksa seluruh method repository di `output/internal/repository/`: Apakah ada data dummy hardcoded (`return 5000, nil` atau `[]map{}`) yang tersisa?
2. Periksa apakah seluruh endpoint menangani mode query parameter (`?menu=...`, `?tab=...`) dan mengembalikan DTO yang sesuai?
3. Periksa apakah field opsional mengembalikan `null` yang aman (bukan `0` atau `""`)?
4. Jalankan unit test dan integration test di `output/tests/`.
5. Pastikan dokumentasi audit trail di `docs/changelog.md`, `docs/progress.md`, dan `docs/decisions.md` telah diperbarui.
6. Tampilkan ringkasan hasil pengujian dan konfirmasi kelayakan modul.
```

---

### 🗄️ 5. Konversi Database Schema & Migrasi

```markdown
Tolong konversi seluruh skema database dari `source/` ke teknologi target:

1. Baca seluruh migration files / DDL schema di `source/database/migrations/` (atau setara).
2. Buat target domain model structs di `output/internal/domain/`.
3. Buat file migrasi target (Goose / GORM AutoMigrate / Prisma / Alembic) di `output/migrations/`.
4. Update dokumentasi skema di `specs/data-models/schema.md`.

Perhatikan dengan teliti:
- Semua relasi tabel (Foreign Keys, composite keys, indexing)
- Format tipe data presisi (DECIMAL/BIGINT untuk mata uang, TIMESTAMP with timezone)
- Soft delete columns (`deleted_at` timestamp)
- Initial seed data / constant lookup tables (roles, statuses)
```

---

### 🧪 6. Pembuatan Unit & Integration Tests Lengkap

```markdown
Tolong buatkan unit test dan integration test komprehensif untuk modul [NAMA_MODUL].

Referensi:
- Spec: `specs/modules/[nama-modul].md` (bagian Acceptance Criteria & Test Cases)
- Implementasi: `output/internal/[handler|service|repository]/`

Tuliskan test suite di `output/tests/[nama-modul]_test.go` (atau format target).
Pastikan test suite menguji 100% skenario berikut:
1. Happy Path — Base Mode (request valid tanpa query params)
2. Branching Permutations — Semua mode query param (`?menu=mission`, `?menu=history`, dll.)
3. Null Safety — Data relasi kosong di DB tetap menghasilkan JSON valid dengan nilai null
4. Validation Errors — Field wajib tidak diisi menghasilkan HTTP 422 / 400 dengan envelope yang sesuai
5. Concurrency Test — Uji race condition pada mutasi saldo/stok
```

---

### 🔍 7. Validasi Integritas Framework & QA Final

```markdown
Semua modul telah selesai dikonversi. Tolong lakukan validasi kualitas menyeluruh:
1. Jalankan validator integritas framework: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`).
2. Periksa seluruh checklist di `context/qa-checklist.md` (Spec coverage, code quality, 8 enterprise standards, feature parity).
3. Jalankan seluruh test suite di `output/` dan pastikan 0 failure.
4. Update milestone final "Conversion Complete" di `docs/progress.md` dan `docs/changelog.md`.
5. Tampilkan dashboard progres akhir melalui `.\scripts\alih.ps1 status`.
6. Sajikan laporan kesiapan perilisan (Release Readiness Report).
```

---

## 🏆 ONE-SHOT MASTER PROMPT — Untuk Proyek Skala Kecil/Menengah

Jika Anda ingin AI mengeksekusi seluruh siklus secara mandiri namun tetap menerapkan standar mutu ketat:

```markdown
Saya ingin mengonversi seluruh proyek dari folder `source/` ke `output/` menggunakan framework AlihSpec SDD.

Tolong lakukan konversi secara bertahap (Iteratif per modul) dengan mematuhi ATURAN DEEP CONTROLLER AST INSPECTION dan 8 CRITICAL QUALITY STANDARDS di `evaluate/evaluation-specs-mismatch.md`:

LANGKAH 1 — ANALISIS & ARSITEKTUR:
- Scan `source/` dan petakan seluruh modul, endpoint, query params, relasi DB, dan JWT claims.
- Tuliskan ringkasan arsitektur ke `specs/overview.md` dan `specs/architecture.md`.
- Catat milestone inisialisasi di `docs/progress.md`.

LANGKAH 2 — SETUP OUTPUT PROJECT:
- Inisialisasi scaffold project target di `output/` sesuai `context/tech-stack.md` dan konvensi di `context/conventions.md`.
- Buat database schema & migrations di `output/migrations/`.

LANGKAH 3 — ITERATIVE PER-MODULE CONVERSION (Ulangi untuk Setiap Modul):
Untuk setiap modul bisnis:
  a. Tulis spesifikasi lengkap di `specs/modules/[modul].md` dengan DoD Checklist, Branching Matrix, dan DTO Pointer types.
  b. Eksekusi Checkpoint 1 (Validasi spec vs source controller line-by-line).
  c. Buat task breakdown di `tasks/` dan update `tasks/_index.md`.
  d. Tulis kode target di `output/` (DTO ➔ Domain ➔ Repository Real Queries ➔ Service Logic ➔ Handler ➔ Tests).
  e. DILARANG KERAS menggunakan data dummy/fallback hardcoded pada repository!
  f. Eksekusi Checkpoint 2 (Validasi zero dummy data & OpenAPI contract match).
  g. Pelihara audit trail: catat ADR baru di `docs/decisions.md`, deviasi teknis di `docs/mapping-log.md`, riwayat penambahan modul di `docs/changelog.md`, dan milestone di `docs/progress.md`.
  h. Tandai task [x] di `tasks/_index.md`.

LANGKAH 4 — VALIDASI & RELEASE QA:
- Jalankan `.\scripts\alih.ps1 validate` untuk memastikan integritas 100%.
- Jalankan seluruh unit & integration test suite di `output/`.
- Update status rilis akhir di `docs/progress.md` dan `docs/changelog.md`.
- Sajikan dashboard status akhir dari `.\scripts\alih.ps1 status`.

Berikan laporan progres setiap kali menyelesaikan 1 modul. Berhenti dan tanyakan kepada saya jika menemukan ambiguitas logika bisnis yang tidak tercantum di kode sumber.
```
