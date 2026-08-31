# 🛡️ QA Checklist — Validasi Kualitas & Presisi Konversi

> Gunakan checklist ini setelah selesai mengonversi setiap modul.
> Pastikan semua item terpenuhi sebelum menandai task sebagai `[x] Done`.

---

## 📋 Per-Modul QA Checklist

### 1. 🔍 Spec & Logic Parity (Anti-Shallow Specs)
- [ ] **Query Parameters Parity**: Semua parameter (`?menu=...`, `?tab=...`, `?filter=...`, `?limit=...`) diproses dengan benar.
- [ ] **Internal Branching Parity**: Seluruh percabangan logika `if/switch` di controller sumber sudah terimplementasi di service/usecase layer.
- [ ] **Strict No Dummy Fallback**: Tidak ada method di repository maupun service yang mengembalikan data dummy/fallback hardcoded.
- [ ] **Multi-Table Joins & Aggregations**: Semua query database, JOIN, GROUP BY, dan kalkulasi SQL riil sudah terhubung ke skema tabel.

### 2. 💎 8 Enterprise Quality Standards Verification
- [ ] **[Q1] DateTime & Timezone Parity**: Format tanggal pada JSON output (`YYYY-MM-DD HH:mm:ss` atau RFC3339) dan timezone offset identik dengan sumber.
- [ ] **[Q2] Currency & Numeric Precision**: Nilai saldo, koin, poin, atau harga tidak menggunakan `float64` biasa (menggunakan `int64` basis terkecil atau decimal library).
- [ ] **[Q3] Pagination Envelope & Offset**: Amplop metadata paginasi (`current_page`, `from`, `last_page`, `per_page`, `total`) dan perhitungan offset (`(page - 1) * per_page`) identik 100%.
- [ ] **[Q4] Validation Error Format**: Error response HTTP 422 berformat *Object of String Arrays* `{"errors": {"field": ["msg"]}}` sesuai ekspektasi frontend.
- [ ] **[Q5] Concurrency & Row-Level Locking**: Mutasi saldo/stok yang berpotensi race condition menggunakan transaksi dan `SELECT ... FOR UPDATE`.
- [ ] **[Q6] Soft Delete in Manual Joins**: Semua manual JOIN dan raw query menyertakan filter `AND [table].deleted_at IS NULL`.
- [ ] **[Q7] JWT Claims Key Parity**: Key nama klaim JWT (`sub`, `uid`, `user_id`, `roles`) diekstrak dengan key yang sama persis dari token sumber.
- [ ] **[Q8] Empty State Contract**: Data koleksi list kosong mengembalikan array kosong `[]` (bukan `null`).

### 3. 🎯 Pointer Nullability Parity
- [ ] Field DTO yang opsional atau nullable di database menggunakan tipe **pointer** (`*int64`, `*string`, `*bool`) sehingga tidak memicu false zero-value (`0` atau `""`) di JSON.

### 4. 🏛️ Code Architecture, Resilience & Conventions
- [ ] File berada di path yang benar sesuai `specs/architecture.md`.
- [ ] Naming convention mengikuti `context/conventions.md`.
- [ ] Tidak ada business logic di handler layer (hanya di service/usecase).
- [ ] Tidak ada akses DB langsung di handler (hanya melalui repository interface).
- [ ] **Transaction Propagation**: Mutasi multi-tabel dalam satu proses bisnis berjalan dalam satu transaksi DB (`tx`).
- [ ] **Explicit Table Binding**: Seluruh domain entity mendeklarasikan `TableName()` eksplisit (anti-implicit pluralization).
- [ ] **Idempotency Protection**: Mutasi finansial/non-idempotent dilindungi oleh `X-Idempotency-Key` / Redis lock.
- [ ] **Async & Shutdown Safety**: Background jobs terhubung ke Graceful Shutdown listener (`SIGTERM`/`SIGINT`).
- [ ] **HTTP Client Timeout**: Outbound HTTP client memiliki timeout eksplisit (anti-hang).
- [ ] **Safe File Streaming**: Upload file menggunakan streaming IO langsung ke storage (anti-RAM OOM).
- [ ] **Structured Logging & Tracing**: Menggunakan structured JSON log dengan propagasi `X-Request-ID`.
- [ ] Error handling proper (tidak ada error yang diabaikan/swallowed).
- [ ] Context propagation benar (`ctx context.Context` sebagai argumen pertama).

### 5. 🧪 Testing & Acceptance Criteria
- [ ] Unit tests dan integration tests mencakup:
  - Skenario Base Mode
  - Skenario Query Parameter Mode (`?menu=...`)
  - Skenario Null Safety (record relasi kosong)
  - Skenario Validation Error (HTTP 400/422)
- [ ] Seluruh test pass 100% (0 failure).

### 6. 📊 Task Tracking & Documentation
- [ ] Task di `tasks/` sudah di-mark `[x]`.
- [ ] `tasks/_index.md` sudah diupdate.
- [ ] Keputusan arsitektur penting dicatat di `docs/decisions.md`.

---

## 🏆 Final Release Checklist (Sebelum Go-Live)

- [ ] **100% Feature Parity**: Semua endpoint dari source project sudah ada di output target.
- [ ] **OpenAPI Contract Tested**: Seluruh request/response telah divalidasi terhadap `specs/api-contracts/openapi.yaml`.
- [ ] **Zero Dummy Code**: Audit repository membuktikan tidak ada data hardcoded mock tersisa.
- [ ] **Framework Validation Pass**: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`) menghasilkan `0 errors, 0 warnings`.
- [ ] **Build & Run Pass**: Project target berhasil di-build dan di-run tanpa runtime error saat startup.
