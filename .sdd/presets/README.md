# 📦 AlihSpec Presets

Folder ini berisi template mapping arsitektur dan pola desain siap pakai untuk berbagai kombinasi konversi stack populer.

## 🚀 Cara Pakai

1. Jalankan `.\scripts\alih.ps1 init` (atau `bash scripts/alih.sh init`) untuk auto-apply preset saat inisialisasi project.
2. Atau copy manual isi folder preset ke `.sdd/mapping/` dan `context/`.

---

## 📋 Daftar Presets Tersedia (11 Presets Bawaan)

### 🇮🇩 Preset Populer di Ekosistem Indonesia
| Preset | Source Stack | Target Stack | Arsitektur Target |
|---|---|---|---|
| [`codeigniter-to-laravel/`](./codeigniter-to-laravel/) | CodeIgniter (CI3 / CI4) | PHP (Laravel 11) | Modern MVC & Eloquent ORM |
| [`codeigniter-to-go/`](./codeigniter-to-go/) | CodeIgniter (CI3 / CI4) | Go (Gin / Fiber + GORM) | Clean Architecture (Layered) |
| [`php-native-to-laravel/`](./php-native-to-laravel/) | PHP Native (Prosedural) | PHP (Laravel 11) | Secure Clean MVC |
| [`express-to-go/`](./express-to-go/) | Node.js (Express / TS) | Go (Gin / Fiber + GORM) | High-Performance Microservices |
| [`laravel-to-fastapi/`](./laravel-to-fastapi/) | PHP (Laravel 11) | Python (FastAPI + SQLAlchemy) | Async Clean Architecture (AI/ML) |

### 🌐 Preset Global Lainnya
| Preset | Source Stack | Target Stack | Arsitektur Target |
|---|---|---|---|
| [`laravel-to-go/`](./laravel-to-go/) | Laravel (PHP) | Go (Gin + GORM) | Clean Architecture |
| [`laravel-to-nestjs/`](./laravel-to-nestjs/) | Laravel (PHP) | TypeScript (NestJS) | Enterprise Modular Architecture |
| [`django-to-fastapi/`](./django-to-fastapi/) | Django (Python) | FastAPI (Python) | Async Clean Architecture |
| [`rails-to-nodejs/`](./rails-to-nodejs/) | Ruby on Rails | Node.js (Express + Prisma) | Layered MVC / Service |
| [`spring-to-go/`](./spring-to-go/) | Spring Boot (Java) | Go (Gin / Fiber + GORM) | Clean Architecture |
| [`express-to-nestjs/`](./express-to-nestjs/) | Express.js (Node) | TypeScript (NestJS) | Enterprise Modular Architecture |

---

## 🛠️ Preset Belum Tersedia?

- **Opsi A — Buat Otomatis dengan AI (Direkomendasikan)**:  
  Buka [`CUSTOM-PRESET-GUIDE.md`](./CUSTOM-PRESET-GUIDE.md), copy prompt AI di dalamnya, dan kirim ke AI agent Anda.
- **Opsi B — Gunakan Template Kosong**:  
  Copy folder [`_custom-template/`](./_custom-template/) dan lengkapi 3 file standar (`patterns.md`, `conventions.md`, `glossary.md`).
