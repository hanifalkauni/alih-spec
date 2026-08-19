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

*(Opsional: Jika kamu punya starter kit/boilerplate target yang ingin ditiru, salin ke `reference-target/`)*.

---

## 🤖 FASE 1: Analisis Mendalam Source Project

### Kirim prompt ini ke AI:

```
Saya baru setup AlihSpec framework untuk konversi project.
Source project ada di folder source/.

Tolong lakukan hal berikut:
1. Baca context/AGENTS.md dan evaluate/evaluation-specs-mismatch.md untuk memahami aturan konversi dan pencegahan shallow specs.
2. Baca .sdd/config.yaml untuk tau source/target tech stack.
3. Scan seluruh source/ dan buat laporan berisi:
   - Daftar semua modul/fitur (auth, user, product, order, dll)
   - Daftar semua endpoint/route (HTTP method & controller action)
   - Daftar semua model database dan relasi antar tabel
   - Dependensi penting dari package manager (composer.json / package.json)

Tulis ringkasannya ke specs/overview.md.
```

---

## 📋 FASE 2: Tulis Spesifikasi Modul (Deep AST Inspection)

### Kirim prompt ini ke AI:

```
Berdasarkan hasil analisis di specs/overview.md, buatkan spesifikasi lengkap untuk SETIAP modul di specs/modules/[nama].md.

Gunakan template di specs/modules/_template.md dan ikuti ATURAN DEEP CONTROLLER AST INSPECTION:
1. Bedah controller sumber baris-demi-baris:
   - Catat SEMUA query parameter (?menu=..., ?tab=..., ?filter=..., ?limit=..., ?offset=...)
   - Petakan SEMUA percabangan internal (if/switch) dan mode respon berbeda ke dalam Branching Matrix
   - Catat SEMUA kueri SQL, Table Joins (LEFT JOIN / INNER JOIN), GROUP BY, dan agregasi kalkulasi
2. Pastikan DTO Struct menggunakan tipe POINTER (*int64, *string, *bool) untuk field opsional/nullable.
3. Lengkapi Spec Definition of Done (DoD) Checklist di bagian atas berkas.
4. DILARANG membuat spesifikasi dangkal (shallow specs) yang menyederhanakan logika percabangan!

Update juga specs/data-models/schema.md dan specs/api-contracts/openapi.yaml.
```

### 🛑 CHECKPOINT 1: Verifikasi Keselarasan Spec vs Source
Setelah AI selesai menulis spec, kirim prompt verifikasi ini:

```
Lakukan audit silang Checkpoint 1 (Spec vs Source Alignment):
1. Bandingkan controller sumber di source/ dengan specs/modules/.
2. Apakah ada query param, percabangan if/switch, atau join tabel di controller sumber yang belum tercatat di spec?
3. Apakah semua field opsional sudah bertipe pointer di DTO?
4. Berikan laporan konfirmasi bahwa spec 100% siap dibuatkan task breakdown.
```

---

## 🗂️ FASE 3: Generate Task Breakdown

### Kirim prompt ini ke AI:

```
Specs sudah 100% diverifikasi. Sekarang buat task breakdown lengkap:

1. Buat task files di tasks/ untuk setiap modul menggunakan template tasks/_template.md:
   - Phase 1: Foundation (setup project, DB layer, auth)
   - Phase 2: Core Modules (semua modul bisnis utama)
   - Phase 3: Integration & Testing (route wiring, tests, CI)
2. Pecah sub-task secara berlapis: DTO ➔ Domain ➔ Repository (Real Queries) ➔ Service/UseCase ➔ Handler ➔ Tests.
3. Update tasks/_index.md dengan daftar task yang sudah dibuat.
```

---

## 🚀 FASE 4: Eksekusi Konversi Modul (Strict No Dummy Data)

### Kirim prompt ini ke AI:

```
Kerjakan task di tasks/_index.md secara bertahap dan teruji.

Aturan Wajib Eksekusi:
1. Baca specs/modules/[modul].md dan tasks/.../task-[xxx].md.
2. Tulis kode target di output/:
   - DTO structs di output/internal/dto/ (wajib pointer untuk field nullable)
   - Domain model & interfaces di output/internal/domain/
   - Repository di output/internal/repository/ (WAJIB query GORM/SQL riil, DILARANG KERAS menggunakan data dummy/fallback hardcoded!)
   - Service / UseCase di output/internal/service/ (tangani semua percabangan if/switch sesuai branching matrix)
   - HTTP Handler di output/internal/handler/
   - Route registration di output/internal/router/api.go
3. Update task status di tasks/_index.md menjadi [x] setelah selesai dan teruji.
```

### 🛑 CHECKPOINT 2: Verifikasi Keselarasan Task vs Output Code
Setiap modul selesai, kirim prompt ini:

```
Lakukan audit Checkpoint 2 untuk modul yang baru dikerjakan:
1. Apakah ada fungsi di Repository/Service yang mengembalikan data dummy/fallback hardcoded?
2. Apakah semua endpoint mengembalikan JSON yang identik dengan kontrak OpenAPI?
3. Jalankan unit test di output/tests/ untuk memastikan semua acceptance criteria lolos.
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
```
Semua task sudah selesai. Lakukan validasi menyeluruh:
1. Jalankan semua unit test dan integration test di output/.
2. Cek semua checklist di context/qa-checklist.md.
3. Pastikan tidak ada link rusak atau rule di context/RULES.md yang terlewat.
```

---

## 💡 Perintah Monitoring Cepat (Gunakan Kapan Saja)

- **Cek Progress Dashboard**: `.\scripts\alih.ps1 status` (atau `bash scripts/alih.sh status`)
- **Validasi Integritas**: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`)
- **Bantuan Perintah**: `.\scripts\alih.ps1 help`
