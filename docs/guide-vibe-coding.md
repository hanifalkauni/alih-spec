# 🤖 Vibe Coding Guide — Konversi Project dengan AI

> Untuk kamu yang ingin **zero manual work**.
> Cukup copy-paste prompt ke AI agent dan review hasilnya.
>
> **Estimasi waktu setup**: 5 menit
> **Cara kerja**: Kamu describe → AI eksekusi → Kamu review → Repeat

---

## 📍 Gambaran Besar

```
FASE 0 ──► FASE 1 ──► FASE 2 ──► FASE 3 ──► FASE 4 ──► FASE 5
 Setup     Analisis    Specs      Tasks     Konversi    Validasi
 5 menit   AI          AI         AI         AI         AI + Kamu
```

Kamu hanya **aktif** di Fase 0 (setup minimal) dan bagian review setiap fase.

---

## ⚡ FASE 0: Setup Awal (5 Menit, Manual)

Ini satu-satunya bagian yang benar-benar manual. Hanya 3 langkah:

### Langkah 1 — Jalankan init script

```powershell
# Windows
.\scripts\alih.ps1 init

# Linux / macOS
bash scripts/alih.sh init
```

Ikuti pertanyaan yang muncul:
- Nama project
- Source language & framework (misal: `php`, `laravel`)
- Target language & framework (misal: `go`, `gin`)

### Langkah 2 — Tambahkan source project

```bash
# Copy project lama ke folder source/
xcopy /E /I C:\path\to\your\project source\

# Atau git submodule
git submodule add https://github.com/your/project.git source
```

### Langkah 3 — Buka AI agent favoritmu

Buka Antigravity / Kiro / Cursor / Claude / ChatGPT.
Pastikan workspace sudah terbuka di folder `spec-drive-development/`.

**Selesai setup. Sisanya AI yang handle.** 🚀

---

## 🤖 FASE 1: Analisis Source Project

### Kirim prompt ini ke AI:

```
Saya baru setup AlihSpec framework untuk konversi project.
Source project ada di folder source/.

Tolong lakukan hal berikut:
1. Baca context/AGENTS.md untuk memahami aturan framework ini
2. Baca .sdd/config.yaml untuk tau source/target tech stack
3. Scan semua file di source/ dan buat laporan berisi:
   - Daftar semua modul/fitur yang ada (misal: auth, user, product, dll)
   - Daftar semua endpoint/route
   - Daftar semua model/tabel database
   - Daftar semua dependency utama (auth, payment, email, storage, dll)
   - Bagian yang kompleks atau perlu perhatian khusus
4. Perkirakan jumlah task yang dibutuhkan

Tampilkan hasil dalam format tabel yang rapi.
Jangan tulis kode dulu, hanya analisis.
```

### Yang perlu kamu review:
- Apakah semua modul utama terdeteksi?
- Apakah ada fitur yang mau di-drop (tidak perlu dikonversi)?

---

## 📋 FASE 2: Generate Semua Specs

### Kirim prompt ini ke AI:

```
Berdasarkan analisis source/ yang sudah kita lakukan, sekarang buat semua specs.

Lakukan secara berurutan:

STEP 1 — Update specs/overview.md:
- Isi bagian Project (nama, source, target)
- Isi Background (alasan konversi)
- Isi Scope (in scope dan out of scope)
- Isi Module Breakdown (tabel semua modul)
- Isi Key Decisions (tech stack choices)

STEP 2 — Buat specs/modules/[nama].md untuk setiap modul:
- Gunakan specs/modules/_template.md sebagai template
- Lihat specs/modules/auth.md sebagai contoh lengkap
- Tulis spec untuk SETIAP modul yang ditemukan di source/
- Sertakan: semua endpoint, business rules, DTOs, acceptance criteria

STEP 3 — Update specs/data-models/schema.md:
- Dokumentasikan semua tabel dari source/
- Sertakan semua kolom, tipe data, relasi, dan index

STEP 4 — Update specs/api-contracts/openapi.yaml:
- Dokumentasikan semua endpoint dari source/
- Ikuti format OpenAPI 3.1 yang sudah ada

Beri update setelah selesai tiap STEP. Tanya jika ada business logic
yang tidak jelas dari source code.
```

### Yang perlu kamu review:
- Apakah business rules sudah benar?
- Apakah ada endpoint yang berbeda dari implementasi source?
- Konfirmasi jika ada yang AI tanyakan

---

## ✅ FASE 3: Generate Semua Tasks

### Kirim prompt ini ke AI:

```
Specs sudah selesai. Sekarang buat task breakdown lengkap.

Lakukan:

1. Buat task files di tasks/ untuk setiap modul:
   - Gunakan tasks/_template.md sebagai template
   - Bagi menjadi fase yang logis:
     * Phase 1: Foundation (setup project, DB layer, auth)
     * Phase 2: Core Modules (semua modul utama)
     * Phase 3: Integration (route wiring, tests, CI)
   - Urut berdasarkan dependency (prerequisite dulu)
   - Isi sub-tasks, source reference, dan acceptance criteria

2. Update tasks/_index.md:
   - Tambahkan semua task ke tabel progress
   - Update counter (total tasks per phase)

Setelah selesai, tampilkan tasks/_index.md yang sudah diupdate.
```

### Yang perlu kamu review:
- Apakah urutan fase sudah masuk akal?
- Apakah ada task yang hilang?

---

## 🔨 FASE 4: Mulai Konversi

Ada 3 sub-opsi tergantung kecepatan yang kamu inginkan:

### Opsi A — AI Jalan Sampai Selesai (Paling Hands-off)

```
Kerjakan SEMUA task di tasks/_index.md secara berurutan sampai selesai.

Untuk setiap task:
1. Baca spec yang relevan di specs/modules/
2. Baca context/AGENTS.md untuk aturan
3. Lihat source/ untuk referensi logic
4. Implementasi di output/ sesuai specs/architecture.md
5. Ikuti konvensi di context/conventions.md
6. Update task status di tasks/_index.md

Beri laporan singkat setiap selesai 1 task.
Tanya saya jika ada business logic yang ambigu.
Stop dan tanya jika ada keputusan teknis penting.
```

### Opsi B — Satu Task per Sesi (Lebih Terkontrol)

```
Kerjakan 1 task berikutnya dari tasks/_index.md.
Pilih task paling awal yang belum selesai dan tidak blocked.

Setelah selesai, tampilkan:
- File apa saja yang dibuat/diubah
- Apakah ada keputusan teknis yang dibuat
- Task mana yang akan dikerjakan berikutnya
```

### Opsi C — Satu Modul Spesifik

```
Tolong kerjakan modul [AUTH/USER/PRODUCT/nama modul].

1. Baca specs/modules/[modul].md
2. Lihat source/[path ke file relevan]
3. Implementasi semua file yang dibutuhkan di output/
4. Update task status di tasks/_index.md

Setelah selesai, tunjukkan file apa saja yang dibuat.
```

---

## 🔍 FASE 5: Validasi & QA

### Kirim prompt ini ke AI:

```
Semua task sudah selesai. Lakukan validasi menyeluruh.

Gunakan checklist di context/qa-checklist.md dan verifikasi:

1. FEATURE PARITY — Cek semua endpoint dari openapi.yaml sudah ada di output/
2. BUSINESS RULES — Cek semua rules dari specs/modules/ sudah diimplementasi
3. CODE QUALITY — Cek semua file ikuti konvensi di context/conventions.md
4. ARCHITECTURE — Cek semua file ada di path yang benar sesuai specs/architecture.md
5. ERROR HANDLING — Cek semua endpoint punya proper error handling

Buat laporan:
- ✅ Yang sudah benar
- ❌ Yang kurang atau salah
- Langsung perbaiki semua yang kurang
```

### Setelah validasi selesai:

```
Update dokumentasi:
1. docs/progress.md — catat milestone "Konversi selesai"
2. docs/changelog.md — catat semua modul yang sudah dikonversi
3. tasks/_index.md — pastikan semua task sudah [x]

Lalu tampilkan cara menjalankan project di output/.
```

---

## 💬 Prompt Situasional

### Jika AI salah / tidak sesuai spec:
```
Ini tidak sesuai dengan spec di specs/modules/[modul].md.
Yang benar adalah: [jelaskan].
Perbaiki dan pastikan tidak ada bagian lain yang sama kesalahannya.
```

### Jika AI bingung dengan source code:
```
File [nama file] di source/ susah dibaca karena [alasan].
Yang ingin dikonversi adalah behavior ini: [jelaskan behavior yang diinginkan].
```

### Jika mau pause dan lanjut besok:
```
Stop dulu. Simpan state dengan:
1. Update tasks/_index.md — tandai task yang sedang dikerjakan sebagai [/]
2. Tulis catatan di docs/progress.md tentang progress hari ini
```

### Jika ada bug di output:
```
Ada bug: [deskripsi bug].
File yang relevan: output/[path].
Tolong debug dan fix. Cek juga apakah spec di specs/modules/ sudah jelas
atau perlu diupdate.
```

### Cek progress kapan saja (CLI atau Prompt):
- **Opsi Cepat (Terminal)**:
  ```powershell
  .\scripts\alih.ps1 status   # atau bash scripts/alih.sh status
  ```
- **Opsi Chat**:
  ```
  Berapa persen progress konversi saat ini?
  Tampilkan tasks/_index.md dalam format yang mudah dibaca.
  Rekomendasikan task berikutnya yang harus dikerjakan.
  ```

### Validasi integritas framework:
- **Jalankan kapan saja**:
  ```powershell
  .\scripts\alih.ps1 validate   # atau bash scripts/alih.sh validate
  ```
  Memvalidasi tidak ada link rusak dan semua spec terdaftar di tasks.

---

## ✅ Checklist Akhir (Kamu yang Cek)

Sebelum menggunakan project hasil konversi:

- [ ] Jalankan project: `cd output && [perintah run]`
- [ ] Test endpoint utama (auth, health check)
- [ ] Cek response format sesuai yang diharapkan client
- [ ] Review sekilas 2-3 modul hasil konversi untuk sanity check

---

> 💡 **Tips**: Untuk project besar, gunakan **Opsi B** (satu task per sesi)
> agar kamu tetap punya kontrol dan bisa review setiap bagian sebelum lanjut.
