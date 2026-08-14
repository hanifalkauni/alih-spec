# Convention Mapping: [Source Framework] ([Source Lang]) → [Target Framework] ([Target Lang])

> **📋 Custom Template** — Isi dengan konvensi yang berlaku di target language/framework kamu.
> Lihat contoh di `.sdd/presets/laravel-to-go/conventions.md` sebagai referensi.

---

## Naming Conventions

> Isi tabel ini sesuai konvensi target language.

| Concept | Source ([Source Lang]) | Target ([Target Lang]) | Example |
|---------|----------------------|----------------------|---------|
| Local variables | [e.g., camelCase] | [target convention] | |
| Functions/methods | | | |
| Classes/Structs | | | |
| Constants | | | |
| Source files | [e.g., UserController.php] | [e.g., user_handler.go] | |
| Folders/packages | | | |
| DB table names | | | |
| DB column names | | | |
| JSON keys | | | |

---

## File Structure

> Mapping dari folder source ke folder target.

| Source | Target | Notes |
|--------|--------|-------|
| [Source controller path] | [Target handler path] | |
| [Source service path] | [Target service path] | |
| [Source model path] | [Target domain path] | |
| [Source test path] | [Target test path] | |

### Target Project Folder Structure

```
output/
├── [folder 1]/          # [Deskripsi]
│   ├── [subfolder]/
│   └── [file]
├── [folder 2]/          # [Deskripsi]
└── ...
```

---

## Error Handling Pattern

> Tunjukkan bagaimana error di-handle di target language.

```
// Source ([Source Lang])
[contoh error di source]

// Target ([Target Lang])
[contoh error di target]
```

**Aturan:**
- [ ] [Aturan 1, misal: always wrap errors]
- [ ] [Aturan 2]

---

## HTTP Response Pattern

> Format response yang konsisten di semua endpoint.

```
// Contoh response sukses
[contoh kode di target]

// Contoh response error
[contoh kode di target]
```

---

## Dependency Injection Pattern

```
// Cara membuat dan inject dependency di target

[contoh constructor injection di target]
```

---

## Struct / Class / Model Pattern

```
// Contoh domain model di target language

[contoh kode]
```

---

## DTO / Request-Response Pattern

```
// Contoh request DTO

[contoh kode dengan validation tags]

// Contoh response DTO

[contoh kode]
```

---

## Test Convention

```
// Naming pattern untuk test functions
[contoh: TestFunctionName_Scenario di Go]
[contoh: describe / it di Jest]

// Contoh test
[contoh kode test]
```

---

## Code File Header

> Convention header komentar di setiap file (jika ada).

```
[contoh header file di target language]
// Source reference: source/[path/to/original/file]
// Spec: specs/modules/[module].md
```

---

## Import / Module Convention

> Bagaimana mengorganisir import di target language.

```
[contoh import grouping yang benar]
```

---

## Additional Notes

> Tambahkan hal-hal spesifik untuk target language/framework yang penting diketahui.
> Misal: pitfalls umum, best practices, hal yang berbeda dari kebanyakan framework.

- [Catatan 1]
- [Catatan 2]
