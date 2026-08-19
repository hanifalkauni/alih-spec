# 🛠️ Custom Preset — Panduan Membuat Preset Sendiri

> Tidak menemukan preset yang cocok untuk conversion pair Anda?
> Panduan ini membantu Anda membuat preset custom dari nol dalam **30–60 menit**.
>
> Preset yang Anda buat dapat digunakan kembali untuk proyek lain dengan pasangan bahasa yang sama!

---

## 📁 Struktur Berkas Preset

Setiap preset terdiri dari **3 file standar**:

```
.sdd/presets/[source]-to-[target]/
├── patterns.md      ➔ Mapping design pattern (Controller ➔ Handler, ORM ➔ ORM, dll.)
├── conventions.md   ➔ Naming rules, file structure, code style target language
└── glossary.md      ➔ Kamus istilah + file path mapping + HTTP status codes
```

---

## ⚡ Cara Cepat: Gunakan AI untuk Generate Preset

Cukup salin prompt berpresisi tinggi ini ke AI agent Anda:

```markdown
Saya ingin membuat SDD preset baru untuk konversi dari [SOURCE FRAMEWORK] ([SOURCE LANG]) ke [TARGET FRAMEWORK] ([TARGET LANG]).

Tolong buatkan 3 berkas preset lengkap dengan standar mutu enterprise:

1. `.sdd/presets/[source]-to-[target]/patterns.md`
   Isi dengan pemetaan pola desain:
   - Application layer mapping (Controller, Service, Repository, DTO, Domain)
   - Routing mapping (HTTP verbs, route groups, url params)
   - ORM / Database mapping (Find, Where, Joins, Aggregations, Transactions)
   - Concurrency & Row-level locking (SELECT ... FOR UPDATE)
   - Authentication & JWT claims key mapping
   - Validation mapping (struct tags / decorators)
   - DateTime format serialization & Nullability pointer mapping
   - Testing & Mocking framework

2. `.sdd/presets/[source]-to-[target]/conventions.md`
   Isi dengan:
   - Naming conventions (variables, functions, classes, files, database tables/columns)
   - File structure target project (Clean / Modular Architecture)
   - Code patterns (error envelope, response format, dependency injection)
   - Code examples nyata yang menunjukkan perbandingan berdampingan (source vs target)

3. `.sdd/presets/[source]-to-[target]/glossary.md`
   Isi dengan:
   - Tabel kamus istilah teknis (30+ padanan istilah source ➔ target)
   - File path mapping komprehensif
   - HTTP status codes & error envelope mapping

Gunakan konvensi yang benar-benar IDIOMATIC untuk [TARGET LANG/FRAMEWORK].
```

Setelah AI selesai, jalankan inisialisasi untuk menerapkan preset:
```powershell
# Windows
.\scripts\alih.ps1 init

# Linux / macOS
bash scripts/alih.sh init
```

---

## 📝 Cara Manual: Menggunakan Template

Gunakan folder template yang sudah disiapkan:

```bash
# 1. Buat folder preset baru
mkdir .sdd\presets\[source-framework]-to-[target-framework]

# 2. Salin template
copy .sdd\presets\_custom-template\patterns.md .sdd\presets\[source-framework]-to-[target-framework]\patterns.md
copy .sdd\presets\_custom-template\conventions.md .sdd\presets\[source-framework]-to-[target-framework]\conventions.md
copy .sdd\presets\_custom-template\glossary.md .sdd\presets\[source-framework]-to-[target-framework]\glossary.md
```

---

## 📋 Checklist Mutu Preset

Sebelum menggunakan preset buatan Anda, pastikan:

- [ ] `patterns.md` mencakup: routing, ORM, row-level locking, auth, validation, nullability pointer, datetime serialization, testing.
- [ ] `conventions.md` mencakup: naming rules, layered file structure, side-by-side code examples.
- [ ] `glossary.md` mencakup: terminology, path mapping, HTTP status code envelope.
- [ ] Lolos validasi: `.\scripts\alih.ps1 validate` menghasilkan `0 errors, 0 warnings`.
