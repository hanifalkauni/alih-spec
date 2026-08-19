# ✅ Checklist Sebelum Mulai Konversi

> Selesaikan semua item ini sebelum meminta AI mengerjakan apapun.
> Cukup butuh **10–15 menit** untuk setup awal.

---

## Step 1 — Konfigurasi Project

- [ ] **Edit `.sdd/config.yaml`**
  - Isi `project.name` dengan nama project kamu
  - Isi `conversion.source.language` dan `source.framework`
  - Isi `conversion.target.language` dan `target.framework`

- [ ] **Copy preset yang sesuai ke `mapping/`**
  ```bash
  # Contoh: laravel → go
  copy .sdd\presets\laravel-to-go\patterns.md .sdd\mapping\patterns.md
  copy .sdd\presets\laravel-to-go\conventions.md .sdd\mapping\conventions.md
  ```
  > Preset tersedia: `laravel-to-go`, `laravel-to-nestjs`, `laravel-to-fastapi`, `codeigniter-to-go`, `codeigniter-to-laravel`, `php-native-to-laravel`, `django-to-fastapi`, `rails-to-nodejs`, `spring-to-go`, `express-to-go`, `express-to-nestjs` (atau `_custom-template`).

---

## Step 2 — Tambahkan Source Project

- [ ] **Copy atau link source project ke folder `source/`**
  ```bash
  # Option A: Copy langsung
  xcopy /E /I C:\path\to\your\project source\

  # Option B: Git submodule (recommended)
  git submodule add https://github.com/your/project.git source
  ```
- [ ] Verifikasi: buka `source/` dan pastikan project ada di sana

---

## Step 3 — Isi Context untuk AI

- [ ] **Edit `context/AGENTS.md`** — isi bagian berikut:
  ```
  ## What Is This Project?
  Converting: [nama project kamu]
  From: [source lang/framework vX.x]
  To: [target lang/framework vX.x]
  ```

- [ ] **Edit `context/tech-stack.md`** — isi tabel tech stack target
- [ ] **Edit `context/AGENTS.md`** — isi bagian `📁 Source Project Notes`:
  ```
  - Main entry point: source/[entry file, e.g., routes/api.php]
  - Key config: source/[config file, e.g., .env, config/]
  ```

---

## Step 4 — Buat Specs (Jika Tidak Pakai Vibe Coding)

- [ ] **Edit `specs/overview.md`** — isi Background, Scope, dan Module Breakdown
- [ ] **Buat `specs/modules/[modul].md`** untuk setiap modul utama (wajib lolos Spec DoD Checklist):
  > Gunakan `specs/modules/_template.md` sebagai template
  > Lakukan Deep Controller AST Inspection (catat semua query param, branching `if/switch`, dan relasi join)
  > Lihat `specs/modules/auth.md` sebagai contoh lengkap
- [ ] **Verifikasi Checkpoint 1**: Cocokkan spec modul dengan controller sumber

- [ ] **Edit `specs/data-models/schema.md`** — dokumentasikan semua tabel DB
- [ ] **Edit `specs/api-contracts/openapi.yaml`** — dokumentasikan semua endpoint

---

## Step 5 — Buat Task List (Jika Tidak Pakai Vibe Coding)

- [ ] **Buat task files** di `tasks/phase-X/` untuk setiap modul (pecah layer DTO ➔ Domain ➔ Repo ➔ Service ➔ Handler)
  > Gunakan `tasks/_template.md` sebagai template
- [ ] **Verifikasi Checkpoint 2**: Pastikan task mencakup semua DTO dan kriteria spec
- [ ] **Update `tasks/_index.md`** dengan semua task dan estimasi

---

## Step 6 — Mulai Konversi

### Opsi A — Vibe Coding (Rekomendasi untuk pemula)
Buka `context/VIBE.md` dan copy-paste prompt **Quick Start** ke AI agent kamu.

### Opsi B — Manual + AI Assist
1. Buka task pertama dari `tasks/_index.md`
2. Kerjakan dengan AI: *"Tolong kerjakan [task-001]. Baca spec dan source dulu."*
3. Review hasilnya, approve, lanjut ke task berikutnya

---

## ✅ Siap Mulai Jika...

- [x] `source/` berisi project lama
- [x] `.sdd/config.yaml` sudah diisi
- [x] `.sdd/mapping/` sudah berisi preset yang sesuai
- [x] `context/AGENTS.md` sudah diisi dengan info project spesifik
- [x] Kamu bisa membuka `tasks/_index.md` dan melihat daftar task
- [x] Validator berjalan 100% tanpa error:
  ```powershell
  .\scripts\alih.ps1 validate   # atau bash scripts/alih.sh validate
  ```

**Sekarang kamu siap! 🚀**

---

## 🆘 Jika Bingung

Tanya AI agent kamu:
```
Saya baru setup AlihSpec framework. Tolong baca context/AGENTS.md
dan bantu saya memulai dari awal. Project saya di source/.
```
