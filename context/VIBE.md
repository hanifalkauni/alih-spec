# ⚡ Bank Prompt Vibe Coding (AlihSpec SDD)

> Kumpulan prompt siap pakai untuk kamu yang ingin **Vibe Coding** — biarkan AI yang menangani proses konversi dari awal sampai akhir.
> Cukup copy-paste prompt di bawah ke chat AI agent kamu (Antigravity, Cursor, Kiro, Copilot, Windsurf, dll).

---

## 🎯 DAFTAR PROMPT BERDASARKAN FASE

---

### 🔍 1. Analisis Source Project (Fase 1)

```
Saya baru setup AlihSpec framework untuk konversi project.
Source project ada di folder source/.

Tolong lakukan hal berikut secara mendalam:
1. Baca context/AGENTS.md dan evaluate/evaluation-specs-mismatch.md untuk memahami aturan konversi dan pencegahan shallow specs.
2. Baca .sdd/config.yaml untuk mengetahui source dan target tech stack.
3. Scan seluruh folder source/ dan buatkan laporan komprehensif berisi:
   - Daftar semua modul/fitur yang ada (auth, user, product, transaksi, dll)
   - Daftar semua endpoint/route (beserta HTTP method dan controller action)
   - Daftar semua model database dan relasi antar tabel
   - Dependensi penting dari package manager (composer.json / package.json / requirements.txt)

Tulis ringkasannya ke specs/overview.md.
```

---

### 📋 2. Tulis Spesifikasi Modul (Deep AST Inspection — Fase 2)

```
Tolong buatkan spesifikasi detail untuk modul [AUTH/USER/PRODUCT/nama modul] di specs/modules/[nama-modul].md.

Gunakan template di specs/modules/_template.md dan ikuti aturan DEEP CONTROLLER AST INSPECTION:
1. Bedah controller sumber baris-demi-baris:
   - Catat SEMUA query parameter (?menu=..., ?tab=..., ?filter=..., ?limit=..., ?offset=...)
   - Petakan SEMUA percabangan internal (if/switch) dan mode respon berbeda ke dalam Branching Matrix
   - Catat SEMUA kueri SQL, Table Joins (LEFT JOIN / INNER JOIN), GROUP BY, dan agregasi kalkulasi
2. Pastikan DTO Struct menggunakan tipe POINTER (*int64, *string, *bool) untuk field yang nullable/opsional.
3. Lengkapi Spec Definition of Done (DoD) Checklist di bagian atas berkas.
4. DILARANG membuat spesifikasi dangkal (shallow specs) yang menyederhanakan logika percabangan!

Tunjukkan draft spec setelah selesai untuk saya review.
```

---

### 🛑 2B. Checkpoint 1: Verifikasi Keselarasan Spec vs Source

```
Tolong lakukan audit silang (Checkpoint 1: Spec vs Source Alignment) untuk modul [nama-modul]:
1. Bandingkan controller sumber di source/ dengan specs/modules/[nama-modul].md.
2. Periksa apakah ada query param, percabangan if/switch, atau join tabel di controller sumber yang belum tercatat di spec?
3. Periksa apakah semua field opsional sudah bertipe pointer di DTO?
4. Berikan checklist konfirmasi apakah spec sudah 100% lengkap dan siap dibuatkan task breakdown.
```

---

### 🗂️ 3. Buat Task Breakdown (Fase 3)

```
Berdasarkan spesifikasi di specs/modules/[nama-modul].md yang sudah diverifikasi:
1. Buat file task terperinci di tasks/phase-2-core-modules/task-[nomor]-[nama-modul].md menggunakan template tasks/_template.md.
2. Pecah sub-task secara berlapis: DTO ➔ Domain Entity ➔ Repository (Real Queries) ➔ Service/UseCase ➔ Handler ➔ Tests.
3. Daftarkan task baru tersebut ke dalam tasks/_index.md secara rapi.
```

---

### 🚀 4. Eksekusi Konversi Modul (Strict No Dummy Data — Fase 4)

```
Tolong konversi modul [nama-modul] dari source/ ke output/ sesuai task dan spesifikasinya.

Aturan Wajib:
1. Baca specs/modules/[nama-modul].md dan tasks/.../task-[nomor]-[nama-modul].md.
2. Tulis kode target di output/:
   - DTO structs di output/internal/dto/ (wajib pointer untuk field nullable)
   - Domain model & interfaces di output/internal/domain/
   - Repository di output/internal/repository/ (WAJIB query GORM/SQL riil, DILARANG KERAS menggunakan data dummy/fallback hardcoded!)
   - Service / UseCase di output/internal/service/ (tangani semua percabangan if/switch sesuai branching matrix)
   - HTTP Handler di output/internal/handler/
   - Route registration di output/internal/router/api.go
3. Update task status di tasks/_index.md menjadi [x] setelah selesai dan teruji.
```

---

### 🛑 4B. Checkpoint 2: Verifikasi Keselarasan Task vs Output Code

```
Tolong lakukan audit silang (Checkpoint 2: Task vs Code Alignment) untuk modul [nama-modul]:
1. Periksa apakah ada fungsi di Repository atau Service yang mengembalikan data dummy hardcoded?
2. Periksa apakah semua endpoint mengembalikan struktur JSON yang identik dengan kontrak OpenAPI?
3. Jalankan unit test / integrasi di output/.
```

---

### 🗄️ 5. Konversi Database Schema

```
Tolong konversi semua database schema dari source/ ke target:

1. Baca semua migration files di source/database/migrations/ (atau setara).
2. Buat domain model structs di output/internal/domain/.
3. Buat migration files di output/migrations/.
4. Update specs/data-models/schema.md.

Perhatikan:
- Semua relasi (foreign keys, many-to-many, composite keys)
- Soft delete columns (gorm.DeletedAt / deleted_at)
- Index & Unique constraints yang ada di schema asli.
```

---

### 🧪 6. Buatkan Tests & QA

```
Tolong buatkan unit tests dan integration tests untuk modul [nama modul].

Referensi:
- Spec: specs/modules/[modul].md (bagian Test Cases & Acceptance Criteria)
- Implementation: output/internal/[handler|service|repository]/

Tulis test file di output/tests/[modul]_test.go.
Pastikan mencakup pengujian:
- Skenario request normal (Base Mode)
- Skenario percabangan query params (?menu=..., dll.)
- Skenario data relasi null (pointer null safety)
- Skenario validasi input salah (400 Bad Request)
```

---

### 🔍 7. Review & Validasi Integritas Framework

```
Tolong jalankan validasi menyeluruh terhadap framework dan output code:
1. Jalankan .\scripts\alih.ps1 validate (atau bash scripts/alih.sh validate).
2. Periksa apakah ada logic rule di context/RULES.md yang terlewat.
3. Periksa apakah semua DTO nullable sudah aman dari false zero-values.
4. Tampilkan dashboard progress via .\scripts\alih.ps1 status.
```

---

### 📊 8. Cek Progress Konversi

```
Tolong cek progress konversi saat ini:
1. Baca tasks/_index.md atau jalankan .\scripts\alih.ps1 status.
2. Berapa persen modul yang sudah selesai?
3. Apa task berikutnya yang paling direkomendasikan untuk dikerjakan?
```

---

### 🛠️ 9. Generate Custom Preset (Jika Preset Tidak Ada)

```
Saya mau konversi dari [SOURCE FRAMEWORK] ([SOURCE LANG]) ke [TARGET FRAMEWORK] ([TARGET LANG]).
Preset untuk kombinasi ini belum ada.

Tolong buat preset baru dengan membuat 3 file berikut:
1. `.sdd/presets/[source]-to-[target]/patterns.md` (Mapping arsitektur, routing, ORM, auth, validasi)
2. `.sdd/presets/[source]-to-[target]/conventions.md` (Naming rules, file layout, style guide)
3. `.sdd/presets/[source]-to-[target]/glossary.md` (Kamus istilah & path mapping)

Gunakan format dari `.sdd/presets/_custom-template/` sebagai acuan.
```

---

### 🟣 10. Konversi Menggunakan Template Target (reference-target/)

```
Saya sudah meletakkan starter kit/boilerplate target di folder reference-target/.
Saya ingin mengonversi source code dari source/ [Laravel/dll] ke output/ [Go/dll]
dengan MENIRU struktur, arsitektur, dan helper utilities yang ada di reference-target/.

Tolong:
1. Scan folder reference-target/ dan ekstrak arsitektur ke specs/architecture.md serta conventions ke context/conventions.md.
2. Setup output/ project mengikuti pola reference-target/.
3. Mulai konversi modul dari source/ ke output/ sesuai spec dan pola tersebut.
```
