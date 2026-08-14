# Mapping Log — Deviasi & Keputusan Konversi

> Log ini mencatat setiap kali ada perbedaan antara source dan target
> yang tidak bisa di-map 1:1, atau ada keputusan yang dibuat saat konversi.
>
> Penting untuk: debugging, onboarding anggota tim baru, dan audit.

---

## Format Entry

```markdown
### [YYYY-MM-DD] — [Singkat: apa yang berbeda]

**Modul**: [auth / user / product / dll]
**Source**: `[path/ke/file/source]`
**Target**: `[path/ke/file/output]`
**Tipe**: mapping-gap | behavior-change | dropped | redesigned | workaround

**Deskripsi**:
Apa yang berbeda dan mengapa tidak bisa di-map langsung?

**Keputusan**:
Apa yang dilakukan dan mengapa?

**Dampak**:
Apakah ada perilaku yang berubah untuk end-user/client?
```

---

## Log Entries

### [Date] — Contoh: Eloquent `paginate()` tidak ada di GORM

**Modul**: Semua modul dengan list endpoint
**Source**: `app/Http/Controllers/UserController.php` → `paginate(15)`
**Target**: `output/internal/repository/user_repository.go`
**Tipe**: mapping-gap

**Deskripsi**:
Laravel Eloquent punya method `paginate($n)` yang otomatis handle offset, limit, dan meta pagination.
GORM tidak punya built-in pagination, harus manual.

**Keputusan**:
Buat helper function `pagination.Paginate(page, perPage int)` di `pkg/pagination/`
yang return `offset`, `limit` dan generate `meta` response.

**Dampak**:
Response format sama dari sisi API client. Tidak ada perubahan perilaku yang terlihat.

---

> Tambahkan entry baru di bawah ini saat menemukan mapping gap atau membuat keputusan konversi.
