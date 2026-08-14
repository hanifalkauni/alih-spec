# SDD Presets

Folder ini berisi template mapping siap pakai untuk berbagai conversion pair populer.

## Cara Pakai

1. Pilih preset yang sesuai dengan conversion Anda
2. Copy isi file ke `../mapping/` (overwrite)
3. Sesuaikan jika ada perbedaan spesifik di project Anda

## Presets Tersedia

| Preset | Source | Target |
|--------|--------|--------|
| [`laravel-to-go/`](./laravel-to-go/) | Laravel (PHP) | Go + Gin + GORM |
| [`laravel-to-nestjs/`](./laravel-to-nestjs/) | Laravel (PHP) | NestJS (TypeScript) |
| [`django-to-fastapi/`](./django-to-fastapi/) | Django (Python) | FastAPI (Python) |
| [`rails-to-nodejs/`](./rails-to-nodejs/) | Ruby on Rails | Node.js + Express + Prisma |
| [`spring-to-go/`](./spring-to-go/) | Spring Boot (Java) | Go + Gin + GORM |
| [`express-to-nestjs/`](./express-to-nestjs/) | Express.js (Node) | NestJS (TypeScript) |

---

## Preset Tidak Tersedia?

**Opsi A — Generate dengan AI (Paling Cepat)**
Buka [`CUSTOM-PRESET-GUIDE.md`](./CUSTOM-PRESET-GUIDE.md), copy prompt AI di dalamnya,
dan kirim ke AI agent kamu. AI akan generate semua 3 file preset secara otomatis.

**Opsi B — Isi Template Manual**
Copy folder [`_custom-template/`](./_custom-template/) dan isi sendiri:
```bash
copy _custom-template myframework-to-other
```

Lihat panduan lengkap: [`CUSTOM-PRESET-GUIDE.md`](./CUSTOM-PRESET-GUIDE.md)

## Cara Menambah Preset Baru

```bash
# Buat folder dengan format: [source]-to-[target]
mkdir .sdd/presets/myframework-to-other

# Buat dua file
touch .sdd/presets/myframework-to-other/patterns.md
touch .sdd/presets/myframework-to-other/conventions.md
```

Ikuti format yang sama dengan preset yang sudah ada.
