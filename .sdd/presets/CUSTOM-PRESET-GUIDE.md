# 🛠️ Custom Preset — Panduan Membuat Preset Sendiri

> Tidak menemukan preset yang cocok untuk conversion pair kamu?
> Panduan ini membantu kamu membuat preset custom dari nol dalam **30–60 menit**.
>
> Preset yang kamu buat bisa di-reuse untuk project lain dengan conversion pair yang sama!

---

## 📋 Apa yang Perlu Dibuat?

Setiap preset terdiri dari **3 file**:

```
.sdd/presets/[source]-to-[target]/
├── patterns.md      ← Mapping design pattern (Controller → Handler, ORM → ORM, dll)
├── conventions.md   ← Naming, file structure, code style target language
└── glossary.md      ← Kamus istilah + file path mapping + HTTP status codes
```

---

## 🚀 Cara Cepat: Gunakan AI untuk Generate Preset

**Ini cara paling efisien.** Cukup copy prompt ini ke AI agent kamu:

```
Saya mau buat SDD preset untuk konversi dari [SOURCE FRAMEWORK] ([SOURCE LANG])
ke [TARGET FRAMEWORK] ([TARGET LANG]).

Tolong buat 3 file berikut dengan format yang ada di .sdd/presets/laravel-to-go/
sebagai referensi:

1. `.sdd/presets/[source]-to-[target]/patterns.md`
   Isi dengan mapping design patterns:
   - Application layer mapping (Controller → ?, Service → ?, Model → ?)
   - Routing mapping
   - ORM/Database mapping
   - Authentication mapping
   - Validation mapping
   - HTTP Response mapping
   - Testing mapping
   - DI/Dependency mapping

2. `.sdd/presets/[source]-to-[target]/conventions.md`
   Isi dengan:
   - Naming conventions (variables, functions, classes, files)
   - File structure target project
   - Code patterns (error handling, response format, DI, dll)
   - Code examples yang menunjukkan source vs target

3. `.sdd/presets/[source]-to-[target]/glossary.md`
   Isi dengan:
   - Tabel terminology source → target
   - File path mapping
   - HTTP status code mapping untuk target language/framework

Gunakan konvensi yang idiomatic untuk [TARGET LANG/FRAMEWORK].
```

Setelah AI selesai, **apply preset** dengan menjalankan:
```powershell
.\scripts\sdd-init.ps1
```

---

## ✍️ Cara Manual: Isi Template

Jika ingin mengisi sendiri, gunakan template yang sudah disiapkan:

```
.sdd/presets/_custom-template/
├── patterns.md      ← Copy dan isi
├── conventions.md   ← Copy dan isi
└── glossary.md      ← Copy dan isi
```

### Langkah-langkah:

**1. Buat folder preset baru**
```bash
mkdir .sdd\presets\[source-framework]-to-[target-framework]
```

**2. Copy template**
```bash
copy .sdd\presets\_custom-template\patterns.md .sdd\presets\[source]-to-[target]\patterns.md
copy .sdd\presets\_custom-template\conventions.md .sdd\presets\[source]-to-[target]\conventions.md
copy .sdd\presets\_custom-template\glossary.md .sdd\presets\[source]-to-[target]\glossary.md
```

**3. Isi tiap file** — panduan ada di dalam setiap template file.

**4. Apply preset**
```powershell
.\scripts\sdd-init.ps1
# Ketik nama source/target framework saat diminta
```

---

## 🔍 Referensi: Preset yang Sudah Ada

Gunakan preset yang paling mirip sebagai referensi:

| Jika source kamu... | Lihat preset ini sebagai referensi |
|--------------------|-----------------------------------|
| Framework PHP lain (Symfony, CodeIgniter) | `laravel-to-go` atau `laravel-to-nestjs` |
| Framework Python lain (Flask, Tornado) | `django-to-fastapi` |
| Framework Ruby lain (Sinatra) | `rails-to-nodejs` |
| Framework Java lain (Quarkus, Micronaut) | `spring-to-go` |
| Framework Node lain (Fastify, Hapi) | `express-to-nestjs` |
| Target Go framework lain (Echo, Fiber) | `laravel-to-go` (ganti Gin → Echo/Fiber) |
| Target lain (Rust/Axum, Kotlin/Ktor) | Buat dari scratch dengan AI prompt |

---

## ✅ Checklist Preset yang Baik

Sebelum menggunakan preset buatanmu, pastikan:

- [ ] `patterns.md` mencakup: routing, ORM, auth, validation, response, testing
- [ ] `conventions.md` mencakup: naming rules, file structure, code examples
- [ ] `glossary.md` mencakup: terminology, file path mapping, HTTP status codes
- [ ] Semua contoh kode sudah menggunakan syntax yang benar untuk target language
- [ ] File path di `conventions.md` sudah sesuai dengan `specs/architecture.md`

---

## 💡 Tips Membuat Preset yang Baik

1. **Prioritaskan yang paling sering dipakai**: routing, ORM, auth, validation
2. **Sertakan contoh kode nyata** (bukan hanya deskripsi)
3. **Fokus pada perbedaan yang tidak obvious** — hal yang sama tidak perlu didokumentasikan
4. **Tambahkan "gotchas"** — hal yang mudah salah saat konversi
5. **Ikuti idiom target language** — jangan terjemahkan kata per kata, terjemahkan konsepnya

---

## 📤 Kontribusi ke Framework

Jika preset buatanmu bagus, tambahkan ke folder `.sdd/presets/` agar bisa dipakai
oleh project lain dengan conversion pair yang sama!

Beri nama folder dengan format: `[source-framework]-to-[target-framework]`

Contoh:
- `symfony-to-go`
- `flask-to-fastapi`
- `sinatra-to-express`
- `laravel-to-fiber`
