# 📦 Antrean Prompt Modul 03: Product

- **Source Controller**: `source/app/Http/Controllers/ProductController.php`
- **Source Model**: `source/app/Models/Product.php`
- **Spec Target**: `specs/modules/product.md`
- **Task Target**: `tasks/phase-2-core-modules/task-005-product-module.md`

---

## 🌟 Opsi B: Full Cycle Modul Product (1 Prompt Langsung Beres)

```markdown
Saya ingin mengonversi modul Product dari `source/` ke `output/` menggunakan framework AlihSpec SDD.

Controller sumber: `source/app/Http/Controllers/ProductController.php`
Model sumber: `source/app/Models/Product.php`
Spec target: `specs/modules/product.md`
Task target: `tasks/phase-2-core-modules/task-005-product-module.md`

Tolong eksekusi siklus konversi penuh untuk modul Product secara bertahap:

1. SPESIFIKASI (Fase 2):
   - Bedah controller `source/app/Http/Controllers/ProductController.php` baris-demi-baris (Deep Controller AST Inspection).
   - Tulis spesifikasi lengkap di `specs/modules/product.md` menggunakan template `specs/modules/_template.md`.
   - Terapkan 8 Standar Mutu: Harga berupa int64 basis sen (Anti-Floating Point), filter multi-kategori, search, pagination envelope, validasi admin, soft-delete, dan pointer nullability.
   - Lengkapi Spec Definition of Done (DoD) Checklist.

2. CHECKPOINT 1 (Audit Keselarasan Spec vs Source):
   - Pastikan seluruh filter query params (`category_id`, `search`, `min_price`, `max_price`, `sort`), perizinan Admin, dan relasi DB sudah tercatat 100%.

3. TASK BREAKDOWN (Fase 3):
   - Buat file task di `tasks/phase-2-core-modules/task-005-product-module.md` menggunakan template `tasks/_template.md` (pecah sub-tasks layer DTO ➔ Domain ➔ Repo ➔ Service ➔ Handler ➔ Tests).
   - Update `tasks/_index.md`.

4. EKSEKUSI CODING (Fase 4):
   - Tulis kode di `output/` lapis demi lapis (DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Route).
   - STRICT NO DUMMY FALLBACK: Seluruh method repository wajib kueri database riil (DILARANG hardcoded dummy).
   - Pelihara audit trail di docs/: catat ADR di `docs/decisions.md` jika ada library baru, deviasi di `docs/mapping-log.md`, riwayat di `docs/changelog.md`, dan milestone di `docs/progress.md`.

5. TESTING & CHECKPOINT 2:
   - Buat & jalankan unit test di `output/tests/`.
   - Validasi zero dummy data dan presisi int64 untuk harga.
   - Tandai task [x] di `tasks/_index.md`.

Tampilkan ringkasan hasil konversi modul Product setelah selesai.
```

---

## 📋 Opsi A: Step-by-Step Modul Product

#### 1. Tulis Spec Modul Product (Fase 2 — Deep AST Inspection)
```markdown
Tolong buatkan spesifikasi detail berstandar enterprise untuk modul Product di `specs/modules/product.md`.

Referensi Sumber:
- Controller: `source/app/Http/Controllers/ProductController.php`
- Model: `source/app/Models/Product.php`

Gunakan template di `specs/modules/_template.md` dan terapkan aturan DEEP CONTROLLER AST INSPECTION & 8 CRITICAL QUALITY STANDARDS:
1. Bedah controller sumber baris-demi-baris:
   - Catat SEMUA query parameter (`?page=...`, `?per_page=...`, `?search=...`, `?category_id=...`, `?min_price=...`, `?max_price=...`, `?sort=...`).
   - Petakan SEMUA percabangan logika internal (`if/switch`, filter stock > 0, Admin authorization) ke dalam tabel Branching Matrix.
   - Catat SEMUA kueri SQL, Table Joins (categories, product_images), GROUP BY, dan agregasi kalkulasi.
2. Terapkan 8 Standar Mutu Enterprise pada Spesifikasi (Harga `int64` basis sen / Anti-Floating Point, Pagination envelope, Validation Error format, Pointer Nullability, Empty State `[]`).
3. Lengkapi Spec Definition of Done (DoD) Checklist di bagian atas berkas.

Tunjukkan draf spesifikasi yang telah selesai untuk saya tinjau.
```

#### 2. Checkpoint 1: Verifikasi Spec vs Source (Fase 2B)
```markdown
Tolong lakukan audit silang verifikasi (Checkpoint 1: Spec vs Source Alignment) untuk modul Product:
1. Bandingkan controller sumber `source/app/Http/Controllers/ProductController.php` baris-demi-baris dengan `specs/modules/product.md`.
2. Sajikan tabel konfirmasi audit (Endpoint, Query Params, Branching if/switch, Nullability Pointer, DB Query & Joins, 8 Standar Mutu).
3. Lengkapi spesifikasi jika ada yang terlewat, dan konfirmasi kesiapan pembuatan task.
```

#### 3. Buat Task Breakdown Modul Product (Fase 3)
```markdown
Berdasarkan spesifikasi di `specs/modules/product.md` yang telah lolos Checkpoint 1:
1. Buat berkas task terperinci di `tasks/phase-2-core-modules/task-005-product-module.md` menggunakan template `tasks/_template.md`.
2. Pecah sub-task secara terisolasi dan bertingkat (Layer-by-Layer: DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Tests).
3. Daftarkan task baru tersebut ke dalam tabel antrean di `tasks/_index.md`.
```

#### 4. Eksekusi Konversi Modul Product (Fase 4 — Strict Zero Dummy)
```markdown
Tolong konversi modul Product dari `source/app/Http/Controllers/ProductController.php` ke `output/` sesuai spesifikasi `specs/modules/product.md` dan task `tasks/phase-2-core-modules/task-005-product-module.md`.

Instruksi Wajib Eksekusi:
1. Baca `specs/modules/product.md`, `tasks/phase-2-core-modules/task-005-product-module.md`, dan `context/RULES.md`.
2. Tulis kode target di `output/` lapis demi lapis (DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Router).
3. STRICT NO DUMMY FALLBACK: Kueri database riil pada repository (termasuk filter kategori & pagination).
4. Pelihara audit trail di docs/ (`docs/decisions.md`, `docs/mapping-log.md`, `docs/changelog.md`, `docs/progress.md`).
5. Update status task di `tasks/_index.md` menjadi `[/]` saat mulai dan `[x]` setelah selesai dan teruji.
```

#### 5. Checkpoint 2: Audit Keselarasan Kode vs Spec Modul Product (Fase 4B)
```markdown
Tolong lakukan audit verifikasi silang (Checkpoint 2: Code vs Spec Parity) untuk modul Product:
1. Periksa repository di `output/internal/repository/`: Pastikan zero dummy data.
2. Periksa apakah seluruh endpoint katalog menangani filtering dan field pointer nullability dengan aman.
3. Jalankan unit test dan integration test di `output/tests/`.
4. Pastikan audit trail di docs/ telah diperbarui.
5. Tampilkan ringkasan hasil pengujian dan konfirmasi kelayakan modul.
```
