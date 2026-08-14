# ⚡ AlihSpec — Spec-Driven Project Conversion Framework

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue.svg?style=flat-square" alt="Version 1.0.0" />
  <img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat-square" alt="License MIT" />
  <img src="https://img.shields.io/badge/platform-Windows%20|%20Linux%20|%20macOS-orange.svg?style=flat-square" alt="Cross-Platform" />
  <img src="https://img.shields.io/badge/AI%20IDEs-Antigravity%20|%20Cursor%20|%20Kiro%20|%20Copilot-purple.svg?style=flat-square" alt="AI IDE Support" />
</p>

> **Alihkan codebase ke bahasa apa pun dengan spesifikasi hidup.**  
> *Shift any codebase across stacks through living specs.*
>
> Framework sistematis untuk mengonversi proyek perangkat lunak dari satu bahasa/framework ke bahasa/framework lain menggunakan metodologi **Spec-Driven Development (SDD)** dan AI-powered coding agents.

---

## 🌟 Mengapa Menggunakan AlihSpec?

- ⚡ **~70% Lebih Cepat (~3x Lipat)**: Memangkas siklus *trial-and-error* dan mengeliminasi 75% waktu debugging pasca-generate.
- 🛡️ **Zero Logic Drift**: Aturan bisnis, validasi, dan relasi database terkunci di `specs/` dan `context/RULES.md` sebelum coding dimulai.
- 🤖 **Multi-IDE & AI Native**: Dilengkapi guardrails otomatis untuk **Antigravity, Cursor, Kiro, Copilot, Windsurf, Claude Code**, dan lainnya.
- 📦 **6 Presets Bawaan + Custom Engine**: Dukungan siap pakai untuk Laravel, Go, NestJS, FastAPI, Django, Rails, Spring Boot, dan custom stack.
- 🟣 **Starter Template Support**: Bisa menggunakan boilerplate target pilihan Anda sendiri via `reference-target/`.

---

## 📌 Apa itu SDD (Spec-Driven Development)?

**Spec-Driven Development** berarti merumuskan *spesifikasi terlebih dahulu*, baru mengimplementasikan kodenya.  
Dalam konteks konversi proyek, spesifikasi mendefinisikan:
1. **Apa yang dikonversi**: Fitur, modul, skema database, dan endpoint API.
2. **Bagaimana memetakannya**: Konsep arsitektur dari bahasa sumber ➔ bahasa target (misal: *Eloquent ➔ GORM*, *FormRequest ➔ DTO*).
3. **Standar penerimaan (*Acceptance Criteria*)**: Kontrak JSON dan aturan bisnis yang harus dipenuhi oleh AI tanpa kompromi.

---

## 🗂️ Struktur Folder

```
alih-spec/
│
├── .sdd/                 # Konfigurasi framework, active mapping & presets
├── source/               # 🔵 Proyek asli (READ-ONLY reference)
├── reference-target/     # 🟣 Template starter target (OPSIONAL, READ-ONLY)
├── specs/                # 📋 Spesifikasi modul, arsitektur, & kontrak OpenAPI
├── tasks/                # ✅ Antrean pengerjaan modular & master progress index
├── context/              # 🧠 Context AI (AGENTS.md, conventions, rules, glossary)
├── output/               # 🟢 Hasil konversi murni (write implementation here)
├── docs/                 # 📚 Dokumentasi, panduan, ADR, & benchmark efisiensi
└── scripts/              # 🛠️ CLI automation suite ('alih')
```

---

## ⚡ Quickstart (3 Langkah Memulai)

### 1. Clone Template & Salin Proyek Lama ke `source/`
```bash
git clone https://github.com/hanifalkauni/alih-spec.git my-conversion
cd my-conversion
```
Salin source code proyek yang ingin dikonversi ke dalam folder `source/`.  
*(Opsional: jika punya template starter target, letakkan di `reference-target/`)*.

### 2. Jalankan Inisialisasi Proyek
```powershell
# Windows PowerShell
.\scripts\alih.ps1 init

# Linux / macOS Bash
bash scripts/alih.sh init
```
*Script akan memandu pemilihan bahasa asal, bahasa target, dan otomatis memasang preset mapping yang sesuai.*

### 3. Pilih Cara Kerjamu
Buka **[`docs/START-HERE.md`](./docs/START-HERE.md)** untuk memilih jalur konversi:

| Panduan | Untuk Siapa | Link |
|---|---|---|
| 🤖 **Vibe Coding Guide** | Ingin AI menangani seluruh proses (Prompt-driven) | [`docs/guide-vibe-coding.md`](./docs/guide-vibe-coding.md) |
| ✍️ **Manual Guide** | Ingin kontrol penuh dan audit trail terperinci | [`docs/guide-manual.md`](./docs/guide-manual.md) |
| ⚡ **Prompt Bank (VIBE)** | Bank 13 prompt siap pakai untuk copy-paste ke AI chat | [`context/VIBE.md`](./context/VIBE.md) |

---

## 📦 Presets Bawaan Siap Pakai (`.sdd/presets/`)

| Preset | Stack Asal | Stack Target | Arsitektur Target |
|---|---|---|---|
| `laravel-to-go` | PHP (Laravel) | Go (Gin + GORM) | Clean Architecture (Layered) |
| `laravel-to-nestjs` | PHP (Laravel) | TypeScript (NestJS) | Modular Architecture |
| `django-to-fastapi` | Python (Django) | Python (FastAPI + SQLAlchemy) | Async Clean Architecture |
| `rails-to-nodejs` | Ruby (Rails) | Node.js (Express + Prisma) | Layered MVC / Service |
| `spring-to-go` | Java (Spring Boot) | Go (Fiber / Gin) | Clean Architecture |
| `express-to-nestjs` | JavaScript (Express) | TypeScript (NestJS) | Enterprise Modular |
| `_custom-template` | *Bahasa Apapun* | *Bahasa Apapun* | [Panduan Custom Preset](./.sdd/presets/CUSTOM-PRESET-GUIDE.md) |

---

## 🛠️ CLI Automation (`alih`)

Framework ini dilengkapi CLI bawaan di folder `scripts/`:

| Perintah Terminal | Kapan Dijalankan? | Fungsi |
|---|---|---|
| `.\scripts\alih.ps1 init`<br>`bash scripts/alih.sh init` | **Awal Proyek (Fase 0)** | Inisialisasi proyek baru & auto-apply preset |
| `.\scripts\alih.ps1 status`<br>`bash scripts/alih.sh status` | **Kapan saja saat coding (Fase 4)** | Dashboard progress bar, persentase selesai & rekomendasi task |
| `.\scripts\alih.ps1 validate`<br>`bash scripts/alih.sh validate` | **Sebelum coding & saat QA (Fase 3 & 5)** | Validasi integritas framework, broken link & coverage task |
| `.\scripts\alih.ps1 help`<br>`bash scripts/alih.sh help` | **Kapan saja** | Tampilkan bantuan perintah CLI |

---

## 🧠 Instruksi untuk AI Agent

Jika Anda adalah AI Coding Assistant (Antigravity, Cursor, Kiro, Copilot, Windsurf, Claude Code) yang membaca workspace ini:
👉 **Baca [`context/AGENTS.md`](./context/AGENTS.md) terlebih dahulu sebelum menulis atau mengubah kode apa pun.**

---

## 📚 Dokumentasi Pendukung

| Dokumen | Fungsi |
|---|---|
| [`docs/START-HERE.md`](./docs/START-HERE.md) | Panduan orientasi memilih alur kerja |
| [`docs/efficiency-benchmark.md`](./docs/efficiency-benchmark.md) | Analisis efisiensi kuantitatif & scorecard KPI pengujian |
| [`docs/decisions.md`](./docs/decisions.md) | Architecture Decision Records (ADR) |
| [`docs/progress.md`](./docs/progress.md) | Log progres harian & milestone |
| [`docs/changelog.md`](./docs/changelog.md) | Catatan riwayat versi framework |
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | Panduan kontribusi komunitas & penambahan preset |

---

## 📄 Lisensi

Didistribusikan di bawah lisensi open-source **MIT License**. Lihat [`LICENSE`](./LICENSE) untuk informasi lebih lanjut.

---

<p align="center">
  <b>AlihSpec v1.0.0</b> • Dibuat untuk ekosistem AI Coding modern 🚀
</p>
