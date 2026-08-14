# ✍️ Manual Guide — Konversi Project Step by Step

> Untuk kamu yang ingin **full control** atas setiap langkah.
> Cocok untuk: tim yang butuh dokumentasi detail, project enterprise,
> atau situasi di mana AI tidak tersedia.
>
> **Estimasi waktu setup**: 1–2 jam
> **Cara kerja**: Kamu isi semua file sendiri, AI hanya bantu coding

---

## 📍 Gambaran Besar

```
FASE 0    FASE 1    FASE 2    FASE 3    FASE 4    FASE 5
 Setup  → Analisis → Specs  → Tasks  → Konversi → Validasi
 Kamu     Kamu      Kamu      Kamu     Kamu+AI    Kamu
```

---

## ⚙️ FASE 0: Setup Framework

### Langkah 1 — Jalankan init script

```powershell
# Windows
.\scripts\alih.ps1 init

# Linux / macOS
bash scripts/alih.sh init
```

Script akan menanyakan:
- **Project name** — nama project kamu
- **Source language** — misal: `php`, `python`, `ruby`, `java`, `javascript`
- **Source framework** — misal: `laravel`, `django`, `rails`, `spring`, `express`
- **Target language** — misal: `go`, `typescript`, `python`
- **Target framework** — misal: `gin`, `nestjs`, `fastapi`

Script akan otomatis:
- Copy preset yang sesuai ke `.sdd/mapping/`
- Copy `conventions.md` dan `glossary.md` ke `context/`
- Update `.sdd/config.yaml`
- Partial update `context/AGENTS.md`

---

### Langkah 2 — Tambahkan source project ke `source/`

**Option A: Copy langsung**
```bash
# Windows
xcopy /E /I C:\path\to\your\project source\

# Linux/macOS
cp -r /path/to/your/project/* source/
```

**Option B: Git submodule (recommended untuk project besar)**
```bash
git submodule add https://github.com/your/project.git source
```

**Option C: Symlink**
```bash
# Windows (jalankan sebagai Administrator)
mklink /D source C:\path\to\your\project

# Linux/macOS
ln -s /path/to/your/project source
```

> ⚠️ **PENTING**: Jangan pernah modifikasi file di dalam `source/`.
> Folder ini READ-ONLY reference.

---

### Langkah 3 — Lengkapi `context/AGENTS.md`

Buka [`context/AGENTS.md`](../context/AGENTS.md) dan isi bagian berikut:

```markdown
## What Is This Project?
Converting: [nama project kamu]
From: [source framework] ([source lang] vX.x)
To: [target framework] ([target lang] vX.x)
```

Dan bagian **Source Project Notes**:
```markdown
## 📁 Source Project Notes
- Source project root: source/
- Main entry point: source/[misal: routes/api.php atau app.py]
- Key config: source/[misal: .env atau config/database.php]
- Auth method: [misal: JWT Sanctum, Session, Basic Auth]
- Database: [misal: MySQL 8.0]
```

---

### Langkah 4 — Lengkapi `context/tech-stack.md`

Buka [`context/tech-stack.md`](../context/tech-stack.md) dan isi tabel tech stack target:

```markdown
| Component | Technology | Version |
|-----------|-----------|---------|
| Language  | Go         | 1.22    |
| Framework | Gin        | v1.9    |
| ORM       | GORM       | v2      |
| Database  | PostgreSQL | 16      |
| Auth      | JWT        | v5      |
| ...       | ...        | ...     |
```

Dan isi bagian **Environment Variables** dengan semua env yang dibutuhkan.

---

### Langkah 5 — (Opsional) Cek preset yang di-apply

Buka file-file berikut dan pastikan isinya sudah relevan dengan project kamu:
- [`.sdd/mapping/patterns.md`](../.sdd/mapping/patterns.md) — pattern mapping
- [`context/conventions.md`](../context/conventions.md) — coding conventions
- [`context/glossary.md`](../context/glossary.md) — terminology mapping

Jika preset tidak cocok (preset kamu tidak tersedia), lihat:
👉 [`.sdd/presets/CUSTOM-PRESET-GUIDE.md`](../.sdd/presets/CUSTOM-PRESET-GUIDE.md)

---

## 🔍 FASE 1: Analisis Source Project

Sebelum menulis spec, pelajari dulu source project secara menyeluruh.

### Yang perlu diidentifikasi:

**A. Semua Modul / Fitur**

Buka source project dan catat semua modul yang ada:
```
Contoh:
- Auth (login, register, logout, refresh token)
- User (CRUD profile)
- Product (CRUD, search, filter)
- Order (create, list, detail, cancel)
- Payment (create, webhook, status)
- Notification (email, push)
```

**B. Semua Endpoint / Route**

```bash
# Laravel — lihat semua route
php artisan route:list

# Django
python manage.py show_urls

# Rails
rails routes

# Express — buka routes/ folder manual
```

**C. Semua Model / Tabel Database**

```bash
# Laravel — lihat migrations
ls source/database/migrations/

# Django — lihat models.py di setiap app
# Rails — lihat db/schema.rb
```

**D. Dependency Penting**

Buka file dependency project:
```
composer.json (Laravel)
requirements.txt / pyproject.toml (Python)
Gemfile (Rails)
package.json (Node)
pom.xml / build.gradle (Java)
```

---

### Catat di `specs/overview.md`

Buka [`specs/overview.md`](../specs/overview.md) dan isi:
- Bagian **Project** (nama, from, to, tanggal)
- Bagian **Background** (kenapa konversi)
- Bagian **Scope** (apa yang dikonversi, apa yang tidak)
- Bagian **Module Breakdown** (tabel semua modul)
- Bagian **Dependencies** (source dan target)

---

## 📋 FASE 2: Tulis Semua Specs

> **Aturan paling penting**: Tulis spec SEBELUM menulis kode apapun.
> Spec adalah kontrak antara kamu dan AI.

### Urutan pengerjaan specs:

#### 2.1 — Database Schema (`specs/data-models/schema.md`)

Mulai dari sini karena modul lain bergantung pada schema.

Buka [`specs/data-models/schema.md`](../specs/data-models/schema.md) dan isi:
- Semua tabel dengan kolom, tipe data, dan constraint
- Semua relasi (foreign keys, many-to-many)
- Index yang diperlukan
- Strategi migrasi

**Referensi**: Lihat migration files di `source/database/migrations/` (Laravel)
atau `source/db/migrate/` (Rails) atau `source/migrations/` (Django).

---

#### 2.2 — API Contract (`specs/api-contracts/openapi.yaml`)

Buka [`specs/api-contracts/openapi.yaml`](../specs/api-contracts/openapi.yaml) dan isi:
- Semua endpoint dengan method, path, request body, response

**Tips**: Gunakan Postman collection dari source project jika ada,
atau generate dari framework:
```bash
# Laravel — gunakan package scribe atau l5-swagger
# Django — gunakan drf-spectacular
# Spring Boot — gunakan springdoc-openapi
```

---

#### 2.3 — Module Specs (`specs/modules/`)

Untuk setiap modul, buat file spec baru:
```
specs/modules/
├── auth.md        ← sudah ada sebagai contoh
├── user.md        ← sudah ada sebagai contoh
├── product.md     ← sudah ada sebagai contoh
├── order.md       ← kamu buat
└── payment.md     ← kamu buat
```

**Cara membuat spec baru:**
1. Copy `specs/modules/_template.md`
2. Rename sesuai modul
3. Isi setiap bagian:
   - Overview
   - Source reference (file di source/ yang relevan)
   - API Endpoints (copy dari openapi.yaml)
   - Business Rules (dari source code dan requirement)
   - DTO Structs (definisi request/response)
   - Interface (method signatures)
   - Acceptance Criteria
   - Test Cases

**Lihat `specs/modules/auth.md` sebagai contoh lengkap.**

---

## ✅ FASE 3: Buat Task Breakdown

### 3.1 — Tentukan fase

Bagi task ke dalam fase logis:
- **Phase 1: Foundation** — Project setup, DB layer, auth
- **Phase 2: Core Modules** — Semua modul bisnis utama
- **Phase 3: Integration** — Route wiring, tests, CI/CD

### 3.2 — Buat task files

Untuk setiap task, copy `tasks/_template.md` dan buat file baru:

```
tasks/
├── phase-1-foundation/
│   ├── task-001-setup-project.md     ← Template: setup project scaffold
│   ├── task-002-database-layer.md    ← Template: DB + migrasi
│   └── task-003-auth-module.md       ← Template: auth
├── phase-2-core-modules/
│   ├── task-004-user-module.md
│   └── task-005-product-module.md
└── phase-3-integration/
    ├── task-006-api-gateway.md
    └── task-007-testing.md
```

**Format nama**: `task-[NNN]-[nama-kebab-case].md`

**Isi setiap task file dengan:**
- Status (Not Started)
- Priority (High/Medium/Low)
- Phase
- Estimasi waktu
- Dependencies (task lain yang harus selesai dulu)
- Description
- Source reference
- Sub-tasks (checklist detail)
- Acceptance criteria

### 3.3 — Update `tasks/_index.md`

Buka [`tasks/_index.md`](../tasks/_index.md) dan:
- Tambahkan semua task ke tabel per fase
- Update counter total task
- Cek dependency antar task sudah benar

---

## 🔨 FASE 4: Konversi

### Workflow per task:

```
1. Buka task file di tasks/phase-X/task-NNN-*.md
2. Tandai status: [/] In Progress
3. Baca spec di specs/modules/[module].md
4. Baca .sdd/mapping/patterns.md untuk concept mapping
5. Baca context/conventions.md untuk naming rules
6. Buka source file referensi di source/
7. Tulis implementasi di output/
8. Tandai sub-tasks satu per satu
9. Tandai status: [x] Done di tasks/_index.md
10. Tulis catatan jika ada keputusan teknis di docs/decisions.md
```

### Aturan coding yang wajib diikuti:

- ✅ Semua file ditulis di `output/` (JANGAN di tempat lain)
- ✅ Ikuti folder structure dari `specs/architecture.md`
- ✅ Ikuti naming dari `context/conventions.md`
- ✅ Handler → Service → Repository (jangan skip layer)
- ✅ Selalu definisikan interface sebelum implementasi
- ✅ Sertakan komentar header file dengan source reference

### Cara meminta bantuan AI untuk coding:

Meski ini manual guide, kamu tetap bisa minta AI bantu tulis kode:
```
Tolong implementasikan [nama file/fungsi] berdasarkan:
- Spec: specs/modules/[modul].md
- Source referensi: source/[path/ke/file]
- Architecture: specs/architecture.md
- Conventions: context/conventions.md

Tulis ke output/[path yang benar].
```

### Lacak progress (Gunakan CLI Status):

Jalankan script dashboard kapan saja di terminal:
```powershell
# Windows
.\scripts\alih.ps1 status

# Linux / macOS
bash scripts/alih.sh status
```

Script akan langsung menampilkan persentase pengerjaan, phase breakdown, dan rekomendasi task selanjutnya.

Catat juga milestone di `docs/progress.md`:
```markdown
### [tanggal]
- Selesai: Task-004 User Module
- Mulai: Task-005 Product Module
- Keputusan: [keputusan teknis yang dibuat]
```

Catat keputusan arsitektur di `docs/decisions.md` (ADR format).
Catat mapping gap di `docs/mapping-log.md`.

---

## 🔍 FASE 5: Validasi & QA

### 5.0 — Validasi Integritas Framework

Jalankan validator otomatis sebelum memulai QA:
```powershell
# Windows
.\scripts\alih.ps1 validate

# Linux / macOS
bash scripts/alih.sh validate
```
Pastikan menghasilkan `RESULT: Framework 100% VALID AND HEALTHY!`.

### 5.1 — Per-modul validation

Setelah setiap modul selesai, jalankan checklist:
👉 Buka [`context/qa-checklist.md`](../context/qa-checklist.md) bagian **Per-Modul Checklist**

Centang setiap item sebelum tandai task sebagai Done.

### 5.2 — Final validation

Setelah semua task selesai, jalankan:
👉 Buka `context/qa-checklist.md` bagian **Final Release Checklist**

### 5.3 — Verifikasi manual

```bash
cd output

# Install dependencies
[perintah install sesuai target language]

# Setup .env
cp .env.example .env
# Edit .env dengan kredensial lokal

# Jalankan migrations
[perintah migrate]

# Jalankan server
[perintah run]

# Test health check
curl http://localhost:8080/health
```

### 5.4 — Test semua endpoint

Gunakan Postman, curl, atau HTTP client lainnya:
- Test semua endpoint dari `specs/api-contracts/openapi.yaml`
- Verifikasi response format sesuai spec
- Test error cases (404, 401, 422)

---

## 📝 Setelah Selesai

Update dokumentasi akhir:

```
docs/progress.md   ← Catat milestone "Konversi selesai"
docs/changelog.md  ← Catat semua modul yang dikonversi
tasks/_index.md    ← Pastikan semua task [x]
```

---

## 📂 Referensi File Penting

| File | Kapan Dibuka |
|------|-------------|
| [`context/AGENTS.md`](../context/AGENTS.md) | Setup awal, isi source project notes |
| [`context/checklist-before-start.md`](../context/checklist-before-start.md) | Verifikasi sebelum mulai |
| [`.sdd/mapping/patterns.md`](../.sdd/mapping/patterns.md) | Referensi saat konversi |
| [`context/conventions.md`](../context/conventions.md) | Referensi saat coding |
| [`context/glossary.md`](../context/glossary.md) | Cek padanan istilah |
| [`specs/architecture.md`](../specs/architecture.md) | Cek path output yang benar |
| [`tasks/_index.md`](../tasks/_index.md) | Update progress setiap hari |
| [`context/qa-checklist.md`](../context/qa-checklist.md) | Validasi setiap modul |
| [`docs/decisions.md`](decisions.md) | Catat keputusan teknis |
| [`docs/mapping-log.md`](mapping-log.md) | Catat mapping gap |
