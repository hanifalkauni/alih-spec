# 📖 Master Reference Guide: Evaluasi & Standardisasi Presisi Konversi Kode (AlihSpec SDD)

> 📌 **Petunjuk Operasional & Standardisasi Agent AI (AlihSpec Framework)**
> Berkas ini disusun sebagai acuan utama bagi seluruh Agent AI yang mengeksekusi proyek alih kode (konversi framework/bahasa) menggunakan metodologi **Spec-Driven Development (SDD)** pada AlihSpec.

---

## 🎯 Tujuan Dokumen Ini
Dokumen ini dibuat untuk mencegah terjadinya **Logic Drift** dan **Spesifikasi Dangkal (*Shallow Specs*)** saat mengonversi kode dari aplikasi sumber (seperti Laravel/PHP) ke aplikasi target (seperti Go Fiber). 

Setiap Agent AI yang membaca dokumen ini **WAJIB** menerapkan prinsip, checklist, dan panduan eksekusi yang dijelaskan di bawah ini.

---

## 🔍 1. Studi Kasus: Mengapa Spesifikasi Dangkal Berbahaya?

### ⚠️ Contoh Kasus Nyata (Cita Module `currentCoin`)
Pada pengujian awal konversi modul Cita, spesifikasi di `specs/modules/cita.md` hanya mencatat DTO sederhana:

```go
// ❌ CONTOH SPESIFIKASI TERLALU SEDERHANA (DILARANG)
type CitaCurrentCoinResponse struct {
	CurrentCoin int64 `json:"current_coin"`
}
```

Padahal pada kode sumber Laravel (`CoinController.php`), fungsi `currentCoin()` memiliki 3 percabangan bisnis kompleks:
1. **Base Mode**: Mengembalikan `current_coin` dan `current_valuation_coin`.
2. **Mode `menu=mission`**: Mengkueri 5 tabel (`tsm`, `tsmt`, `dcr`, `audiences`, `submissions`, `dte_automations`) untuk menghitung akumulasi `potential_coin`.
3. **Mode `menu=history_coin`**: Mengelompokkan berdasarkan `coin_expiry_date` terdekat untuk mengembalikan `nearest_coin_expiry_date`, `nearest_coin_expiry_date_formatted`, dan `sum_coin_nearest_coin_expiry_date`.

> **Pelajaran Kunci bagi Agent**: Menghasilkan spesifikasi ringkas tanpa membedah isi controller sumber akan menyebabkan *missed business rules* dan memaksa pembuatan kode *fallback dummy* yang melanggar kontrak OpenAPI.

---

## 🛠️ 2. Aturan Emas & Panduan Eksekusi Agent AI (Mandatory Agent Directives)

Setiap Agent AI yang mengeksekusi AlihSpec SDD **WAJIB** mematuhi 7 aturan utama berikut:

### 1️⃣ Aturan Deep Controller AST Inspection (Bedah Kode Sumber Baris-demi-Baris)
- Jangan hanya membaca nama fungsi, route, atau nama model GORM secara umum.
- Agent **WAJIB** membaca seluruh isi fungsi controller sumber baris-demi-baris:
  - Membaca semua aturan `request()->validate()` dan query parameter (`menu`, `tab`, `filter`, `limit`, `offset`).
  - Membaca semua percabangan `if ($param == ...)` / `switch-case`.
  - Membaca semua Join tabel, Group By, SelectRaw, dan Having pada query database.

### 2️⃣ Aturan Iterative Per-Module Execution (Eksekusi Bertahap per Modul)
- **DILARANG KERAS** memproses spesifikasi seluruh modul sekaligus (*bulk processing*) jika jumlah endpoint > 10.
- Eksekusi wajib dilakukan secara bertahap (Iteratif):
  ```text
  [ 1. Spec Modul A ] ➔ [ 2. Validate Spec vs Source ] ➔ [ 3. Task Breakdown Modul A ] ➔ [ 4. Code Modul A ] ➔ [ 5. QA Modul A ]
  ```

### 3️⃣ Aturan Pointer Nullability Parity (Pointer pada Struct Go)
- Di bahasa dinamis seperti PHP, bidang opsional dapat bernilai `null`.
- Di Go, gunakan tipe **pointer** (`*int64`, `*string`, `*bool`) untuk seluruh bidang JSON opsional pada DTO target. Ini memastikan bahwa jika nilai bernilai `nil`, bidang tersebut tidak muncul secara salah sebagai nilai default (`0` atau `""`) di JSON output.

### 4️⃣ Aturan Strict No Dummy Fallback (Dilarang Menggunakan Hardcoded Dummy Value)
- **DILARANG KERAS** mengembalikan *hardcoded dummy data* (seperti `return 5000, nil` atau `WithData([]map{})`) pada layer Repository atau Handler.
- Setiap method pada layer Repository wajib menuliskan query GORM riil yang terhubung ke database.

### 5️⃣ Aturan Spec Definition of Done (DoD) Checklist
Sebelum berkas `specs/modules/[module].md` dinyatakan **SELESAI**, Agent WAJIB memeriksa checklist berikut:
- [ ] **Validation & Query Parity**: Semua aturan validasi dan query parameters dicatat di DTO.
- [ ] **Branching Parity**: Semua percabangan logika respon dicatat di UseCase & DTO.
- [ ] **Query SQL Parity**: Semua nama tabel asli, nama kolom asli, dan klausa JOIN/GROUP BY dicatat di Repository Spec.
- [ ] **Pointer Nullability Parity**: Semua bidang opsional menggunakan tipe pointer.

### 6️⃣ Aturan Validation Checkpoint 1: Spec vs Source Alignment
Sebelum pembuatan task breakdown di `tasks/`, Agent **WAJIB** mengeksekusi proses verifikasi silang (*cross-validation*):
- **Cek Kelengkapan**: Bandingkan daftar fungsi controller di `source/` dengan file `specs/modules/[module].md`.
- **Cek Parameter & Respon**: Pastikan semua query params, validation error codes, dan skema JSON di `specs/` persis dengan logika di `source/`.
- **Jika Tidak Sesuai**: Stop dan perbaiki file spec sebelum melangkah ke tahap berikutnya!

### 7️⃣ Aturan Validation Checkpoint 2: Task vs Spec Alignment
Sebelum eksekusi penulisan kode di `output/`, Agent **WAJIB** mengeksekusi validasi keselarasan tugas:
- **Cek Pemetaan Task**: Pastikan berkas `tasks/[phase]/task-[xxx]-[module].md` memuat semua DTO struct, interface method, dan acceptance criteria yang didefinisikan di `specs/modules/[module].md`.
- **Cek Dependency Order**: Pastikan task urutan dasar (Foundation/DB Layer) diselesaikan terlebih dahulu sebelum task Handler/UseCase.

---

## 🗺️ 3. Tabel Pemetaan Pola Query (Eloquent ➔ GORM Pattern Mapping)

Gunakan tabel pemetaan ini saat mengonversi query dari Laravel Eloquent ke Go GORM:

| Laravel Eloquent Pattern | Go GORM Equivalent Pattern | Catatan Kunci |
|---|---|---|
| `$query->whereDate('expired_at', '>=', $today)` | `db.Where("expired_at >= ?", today)` | Gunakan format string `"YYYY-MM-DD"` |
| `$query->selectRaw('COALESCE(SUM(coin), 0) as total')` | `db.Select("COALESCE(SUM(coin), 0)").Scan(&total)` | Gunakan `.Scan()` untuk menampung agregat |
| `$query->groupBy('date')->having('total', '>', 0)` | `db.Group("date").Having("total > 0")` | Gunakan `.Group()` dan `.Having()` di GORM |
| `$query->cursorPaginate($limit)` | `db.Limit(limit).Offset(offset).Scan(&items)` | Gunakan Limit & Offset untuk pagination |
| `DB::table('users')->pluck('id')` | `db.Table("users").Pluck("id", &ids)` | Pass pointer slice `&ids` ke `.Pluck()` |
| `DB::transaction(function() { ... })` | `db.Transaction(func(tx *gorm.DB) error { ... })` | Bungkus mutasi DB dalam GORM Transaction |

---

## 📋 4. Ringkasan Workflow Konversi Standar dengan Dual Validation Checkpoints

```mermaid
flowchart TD
    A["Read source/ routes & controllers"] --> B["Deep Controller AST Inspection"]
    B --> C["Write specs/modules/[module].md with DoD Checklist"]
    C --> V1{"Validation 1: Spec vs Source Match?"}
    V1 -- No (Missing params/branches) --> B
    V1 -- Yes --> D["Create Tasks in tasks/"]
    D --> V2{"Validation 2: Task vs Spec Match?"}
    V2 -- No (Missing criteria/DTOs) --> D
    V2 -- Yes --> E["User Review & Approval"]
    E --> F["Write Target Code in output/ (DTO, Entity, Repo, UseCase, Handler)"]
    F --> G["Run Unit Tests & E2E Tests (go test ./...)"]
    G --> H["Perform QA Parity Audit & Mark Task Complete"]
```

---

## 🏆 Kesimpulan untuk Agent AI

Dengan menambahkan **Dual Validation Checkpoints** (Spec vs Source dan Task vs Spec), Agent AI dijamin tidak akan pernah melupakan query parameter, percabangan logika, atau field DTO pada proyek konversi AlihSpec SDD.
