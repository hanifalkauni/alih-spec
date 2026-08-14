# ⚡ Vibe Coding Guide — SDD Project Conversion

> Untuk kamu yang mau **full vibe coding**: cukup copy-paste prompt di bawah ke AI agent
> (Antigravity, Kiro, Cursor, Claude, ChatGPT, dll) dan biarkan AI yang bekerja.
>
> Tidak perlu setup manual. Tidak perlu nulis kode sendiri. Cukup **describe, review, approve**.

---

## 🧠 Cara Kerja Vibe Coding di Framework Ini

```
Kamu ngobrol  →  AI baca context/  →  AI baca specs/  →  AI tulis ke output/
     ↑                                                           ↓
  Review hasil  ←────────────────────────────────────────────────
```

**Tiga hal yang kamu lakukan:**
1. **Describe** — ceritakan apa yang mau dikonversi
2. **Review** — cek hasil AI sebentar
3. **Approve** — bilang "lanjut" dan AI kerjakan berikutnya

---

## 🚀 QUICK START — Copy Paste Ini Pertama Kali

Ganti bagian dalam `[...]` lalu kirim ke AI agent kamu:

```
Saya punya project [Laravel/Django/Rails/Spring Boot] yang mau saya konversi ke [Go/NestJS/FastAPI/Node.js].

Project saya ada di folder source/ di workspace ini.
Framework SDD sudah disiapkan. Tolong:

1. Baca context/AGENTS.md untuk memahami aturan konversi
2. Baca .sdd/config.yaml untuk konfigurasi project
3. Baca source/ dan buat daftar semua modul yang perlu dikonversi
4. Update specs/overview.md dengan daftar modul tersebut
5. Buatkan task untuk setiap modul di tasks/_index.md

Setelah selesai, tunjukkan task list yang sudah dibuat.
```

---

## 📋 PROMPT LIBRARY — Tinggal Copy Paste

### 🔍 1. Analisis Source Project

```
Tolong analisis project di folder source/ dan berikan:
- Daftar semua controller/endpoint yang ada
- Daftar semua model/tabel database
- Daftar semua service dan logic bisnis utama
- Dependensi penting (auth, payment, email, dll)
- Estimasi jumlah task yang dibutuhkan untuk konversi

Format hasilnya sebagai tabel yang rapi.
```

---

### 📝 2. Buat Semua Spec Sekaligus

```
Berdasarkan analisis source/, tolong:
1. Buat file spec untuk setiap modul di specs/modules/
   (gunakan template dari specs/modules/_template.md)
2. Update specs/overview.md dengan daftar semua modul
3. Update specs/data-models/schema.md dengan semua tabel yang ada
4. Update specs/api-contracts/openapi.yaml dengan semua endpoint

Mulai dari modul yang paling fundamental dulu (auth, user).
```

---

### ✅ 3. Buat Semua Task Sekaligus

```
Berdasarkan specs/ yang sudah ada, tolong:
1. Buat task files untuk setiap modul di tasks/
2. Urutkan berdasarkan dependency (foundation dulu)
3. Bagi menjadi fase yang masuk akal
4. Update tasks/_index.md dengan semua task

Gunakan format dari tasks/_template.md.
```

---

### 🔨 4. Kerjakan Satu Task (yang paling umum dipakai)

```
Tolong kerjakan task berikutnya dari tasks/_index.md yang belum selesai.

Langkahnya:
1. Pilih task paling awal yang belum done dan tidak blocked
2. Baca spec yang relevan di specs/modules/
3. Lihat source code referensi di source/
4. Tulis implementasi di output/ sesuai arsitektur di specs/architecture.md
5. Ikuti konvensi di context/conventions.md
6. Update status task di tasks/_index.md jadi [x]

Tunjukkan file apa saja yang kamu tulis setelah selesai.
```

---

### 🔨 5. Kerjakan Satu Modul Spesifik

```
Tolong konversi modul [AUTH/USER/PRODUCT/nama modul] dari source/ ke output/.

Langkahnya:
1. Baca specs/modules/[modul].md
2. Lihat source/[path ke file relevan]
3. Tulis semua file yang dibutuhkan di output/:
   - Handler
   - Service
   - Repository
   - DTO
   - Domain model (jika belum ada)
4. Ikuti arsitektur di specs/architecture.md
5. Ikuti konvensi di context/conventions.md
6. Update task status di tasks/_index.md

Setelah selesai, review apakah ada yang perlu saya check?
```

---

### 🔄 6. Kerjakan Semua Task Sampai Selesai

```
Tolong kerjakan semua task di tasks/_index.md secara berurutan sampai selesai.

Untuk setiap task:
1. Baca spec yang relevan
2. Cek source code referensi
3. Tulis implementasi di output/
4. Update status task
5. Lanjut ke task berikutnya

Beri update setiap selesai 1 task. Tanya saya jika ada ambiguitas
pada business logic yang tidak jelas dari source code.
```

---

### 🗄️ 7. Konversi Database Schema

```
Tolong konversi semua database schema dari source/ ke target:

1. Baca semua migration files di source/database/migrations/ (atau setara)
2. Buat domain model structs di output/internal/domain/
3. Buat migration files di output/migrations/
4. Update specs/data-models/schema.md

Perhatikan:
- Semua relasi (foreign keys, many-to-many)
- Soft delete columns
- Index yang ada
```

---

### 🧪 8. Buatkan Tests

```
Tolong buatkan unit tests dan integration tests untuk modul [nama modul].

Referensi:
- Spec: specs/modules/[modul].md (bagian Test Cases)
- Implementation: output/internal/[handler|service|repository]/

Tulis test file di output/tests/[modul]_test.[ext].
Cover semua acceptance criteria yang ada di spec.
```

---

### 🔍 9. Review & Fix Hasil Konversi

```
Tolong review output/ yang sudah ada dan cek:
1. Apakah semua endpoint dari specs/api-contracts/openapi.yaml sudah diimplementasi?
2. Apakah ada business rule di specs/modules/ yang belum diimplementasi?
3. Apakah ada konvensi di context/conventions.md yang dilanggar?
4. Apakah ada error handling yang kurang?

Buatkan laporan dan langsung fix apa yang perlu diperbaiki.
```

---

### 📊 10. Cek Progress

```
Tolong cek progress konversi saat ini:
1. Baca tasks/_index.md
2. Hitung berapa persen yang sudah selesai
3. Identifikasi task mana yang paling kritis untuk dikerjakan selanjutnya
4. Apakah ada blocker?

Tampilkan dalam format tabel yang mudah dibaca.
```

---

### 🚀 11. Setup Output Project

```
Tolong setup project [Go/NestJS/FastAPI/Node.js] di folder output/:

1. Inisialisasi project baru dengan struktur sesuai specs/architecture.md
2. Install semua dependensi yang ada di context/tech-stack.md
3. Setup konfigurasi dasar (.env.example, config files)
4. Buat endpoint /health yang return {"status": "ok"}
5. Pastikan project bisa dijalankan

Setelah selesai tunjukkan cara menjalankannya.
```

---

## 🎯 ONE-SHOT PROMPTS — Untuk Proyek Kecil

Jika project kamu kecil (< 10 endpoint), gunakan prompt ini langsung:

### One-Shot: Analisis + Spec + Task + Implementasi

```
Saya punya project [framework] di folder source/.
Mau dikonversi ke [target framework].

Tolong lakukan SEMUA langkah berikut secara berurutan:

FASE 1 — ANALISIS:
- Baca semua source code di source/
- Identifikasi semua modul, endpoint, dan model

FASE 2 — SPEC:
- Tulis specs/overview.md
- Buat specs/modules/[nama].md untuk setiap modul
- Update specs/data-models/schema.md
- Update specs/api-contracts/openapi.yaml

FASE 3 — TASKS:
- Buat task files di tasks/
- Update tasks/_index.md

FASE 4 — IMPLEMENTASI:
- Setup output/ project
- Implementasi semua modul sesuai spec
- Mulai dari foundation, lalu core modules

FASE 5 — REVIEW:
- Verifikasi semua endpoint terimplementasi
- Cek business logic sudah benar

Update saya setiap selesai 1 fase. Tanya jika ada yang ambigu.
```

---

## 💬 Tips Ngobrol dengan AI

### Saat AI tanya clarification:
- **Business logic ambigu**: Jelaskan behavior yang diinginkan dalam bahasa natural
- **Tech stack pilihan**: Jawab langsung, AI akan update tech-stack.md
- **Naming convention**: Bilang "ikuti konvensi yang sudah ada" atau specify

### Saat hasil tidak sesuai:
```
Ini tidak sesuai dengan [spec/konvensi/behavior yang diinginkan].
Yang benar adalah: [jelaskan].
Tolong perbaiki dan pastikan tidak ada bagian lain yang sama kesalahannya.
```

### Saat mau lanjut ke modul berikutnya:
```
Bagus! Lanjut ke task berikutnya.
```

### Saat mau pause dan lanjut nanti:
```
Stop dulu. Simpan progress di docs/progress.md dan
catat di tasks/_index.md task mana yang sedang dikerjakan.
```

### 🆕 12. Generate Custom Preset (Jika Preset Tidak Ada)

Jika preset untuk conversion pair kamu tidak tersedia:

```
Saya mau konversi dari [SOURCE FRAMEWORK] ([SOURCE LANG]) ke [TARGET FRAMEWORK] ([TARGET LANG]).
Preset untuk kombinasi ini belum ada.

Tolong buat preset baru dengan membuat 3 file berikut:

1. `.sdd/presets/[source]-to-[target]/patterns.md`
   Gunakan format dari `.sdd/presets/_custom-template/patterns.md` sebagai template.
   Isi dengan mapping yang akurat dan idiomatic untuk kedua framework ini:
   - Application layer mapping
   - Routing
   - ORM/Database
   - Authentication
   - Validation
   - HTTP Response
   - Testing
   - DI/Configuration

2. `.sdd/presets/[source]-to-[target]/conventions.md`
   Gunakan format dari `.sdd/presets/_custom-template/conventions.md` sebagai template.
   Isi dengan:
   - Naming conventions target language
   - File structure target project
   - Code patterns dengan contoh kode nyata (source vs target side-by-side)

3. `.sdd/presets/[source]-to-[target]/glossary.md`
   Gunakan format dari `.sdd/presets/_custom-template/glossary.md` sebagai template.
   Isi dengan:
   - Terminology mapping (30+ istilah penting)
   - File path mapping
   - HTTP status code mapping untuk target framework

Setelah selesai, juga update:
- `context/conventions.md` — copy dari preset baru
- `context/glossary.md` — copy dari preset baru
- `.sdd/mapping/patterns.md` — copy dari preset baru
- `.sdd/config.yaml` — update source/target language dan framework

Gunakan konvensi yang benar-benar idiomatic untuk [TARGET LANG/FRAMEWORK],
bukan sekadar terjemahan literal dari source.
```

---

### 🎯 13. Konversi Menggunakan Template Target (reference-target/)

Jika kamu sudah punya contoh starter kit / boilerplate project target di folder `reference-target/`:

```
Saya sudah meletakkan contoh starter kit/template target di folder reference-target/.
Saya ingin mengkonversi source code dari source/ [Laravel/dll] ke output/ [Go/dll]
dengan MENIRU struktur, arsitektur, dan helper utilities yang ada di reference-target/.

Tolong:
1. Scan folder reference-target/ dan ekstrak:
   - Struktur arsitektur folder -> tulis ke specs/architecture.md
   - Coding conventions, response format, error handling -> tulis ke context/conventions.md
   - Tech stack & dependencies -> tulis ke context/tech-stack.md
   - Pattern mapping -> tulis ke .sdd/mapping/patterns.md
2. Setup output/ project mengikuti pola reference-target/
3. Mulai konversi modul dari source/ ke output/ sesuai spec dan pola tersebut.
```

---

## 🔧 Konfigurasi Cepat untuk Vibe Coding

Sebelum mulai, update dua hal ini:

**1. `.sdd/config.yaml`** — isi source/target:
```yaml
conversion:
  source:
    language: "php"      # ganti sesuai project kamu
    framework: "laravel"
  target:
    language: "go"       # ganti sesuai target kamu
    framework: "gin"
```

**2. `context/AGENTS.md`** — isi bagian ini:
```markdown
## What Is This Project?
Converting: [nama project kamu]
From: [source lang/framework]
To: [target lang/framework]
```

Selesai. Sisanya biarkan AI yang handle. 🚀
