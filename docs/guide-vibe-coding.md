# ⚡ Vibe Coding Guide — Konversi Project dengan AI (AlihSpec SDD)

> Untuk kamu yang ingin **zero manual work**.
> Cukup copy-paste prompt ke AI agent dan review hasilnya.
>
> **Estimasi waktu setup**: 5 menit  
> **Cara kerja**: Kamu Prompt ➔ AI Eksekusi ➔ Validasi Checkpoint ➔ Repeat

---

## 🧭 Gambaran Besar Alur Kerja

```
FASE 0        FASE 1        FASE 2        FASE 3        FASE 4        FASE 5
 Setup    ➔  Analisis  ➔   Specs    ➔    Tasks   ➔   Konversi  ➔   Validasi
 5 menit       AI       AI + Check 1      AI       AI + Check 2   AI + Kamu
```

Kamu hanya aktif di Fase 0 (setup minimal) dan me-review hasil checkpoint setiap fase.

---

## ⚡ FASE 0: Setup Awal (5 Menit, Manual)

Hanya 3 langkah mudah:

### Langkah 1 — Jalankan init script

```powershell
# Windows
.\scripts\alih.ps1 init

# Linux / macOS
bash scripts/alih.sh init
```

Ikuti pertanyaan yang muncul:
- Nama project
- Source language & framework (misal: `php`, `laravel` atau `php`, `codeigniter`)
- Target language & framework (misal: `go`, `gin` atau `typescript`, `nestjs`)

### Langkah 2 — Tambahkan source project

```bash
# Copy project lama ke folder source/
xcopy /E /I C:\path\to\your\project source\

# Atau gunakan git submodule
git submodule add https://github.com/your/project.git source
```

*(Opsional: Jika punya template starter kit target, letakkan di `reference-target/`)*.

---

## 🤖 FASE 1: Analisis Mendalam Source Project

### Kirim prompt ini ke AI:

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

## 📋 FASE 2: Tulis Spesifikasi Modul (Deep AST Inspection)

### Kirim prompt ini ke AI:

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

### 🛑 CHECKPOINT 1: Verifikasi Keselarasan Spec vs Source
Setelah AI selesai menulis spec, kirim prompt verifikasi ini:

```markdown
Tolong lakukan audit silang verifikasi (Checkpoint 1: Spec vs Source Alignment) untuk modul [NAMA_MODUL]:
1. Bandingkan controller sumber di `source/` baris-demi-baris dengan `specs/modules/[nama-modul].md`.
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

---

## 🗂️ FASE 3: Generate Task Breakdown Berlapis

### Kirim prompt ini ke AI:

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

## 🚀 FASE 4: Eksekusi Konversi Modul (Strict Zero Dummy)

### Kirim prompt ini ke AI:

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

### 🛑 CHECKPOINT 2: Audit Keselarasan Kode Target vs Spesifikasi
Setiap modul selesai, kirim prompt ini:

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

## 🔍 FASE 5: Validasi Akhir & QA

### Jalankan CLI Validator:
```powershell
# Windows
.\scripts\alih.ps1 validate

# Linux / macOS
bash scripts/alih.sh validate
```

### Kirim prompt QA akhir ke AI:
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

## 📚 Panduan Berkas Audit Trail & Memory System (docs/)

Selama proses vibe coding, AI akan memelihara berkas-berkas berikut secara otomatis:

| Berkas | Kapan Diperbarui Otomatis? | Fungsi Utama |
|---|---|---|
| 📈 [`docs/progress.md`](./progress.md) | Setiap modul/fase selesai | Log pencapaian milestone & rekap status sesi untuk handover ke AI/sesi baru. |
| 🏛️ [`docs/decisions.md`](./decisions.md) | Saat ada keputusan arsitektur (ADR) | Mencatat alasan (*WHY*) di balik pemilihan library, pattern, atau konfigurasi. |
| 🗺️ [`docs/mapping-log.md`](./mapping-log.md) | Saat ada fitur yang tidak bisa 1:1 | Mencatat deviasi atau workaround teknis dari bahasa sumber ke target. |
| 📝 [`docs/changelog.md`](./changelog.md) | Setiap rilis modul baru | Riwayat penambahan ([Added]), perubahan ([Changed]), dan perbaikan ([Fixed]). |

---

## 💡 Perintah Monitoring Cepat (Gunakan Kapan Saja)

- **Cek Progress Dashboard**: `.\scripts\alih.ps1 status` (atau `bash scripts/alih.sh status`)
- **Validasi Integritas**: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`)
- **Bantuan Perintah**: `.\scripts\alih.ps1 help`
