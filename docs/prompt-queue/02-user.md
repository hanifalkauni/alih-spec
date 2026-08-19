# 📦 Antrean Prompt Modul 02: User

- **Source Controller**: `source/app/Http/Controllers/UserController.php`
- **Source Model**: `source/app/Models/User.php`
- **Spec Target**: `specs/modules/user.md`
- **Task Target**: `tasks/phase-2-core-modules/task-004-user-module.md`

---

## 🌟 Opsi B: Full Cycle Modul User (1 Prompt Langsung Beres)

```markdown
Saya ingin mengonversi modul User dari `source/` ke `output/` menggunakan framework AlihSpec SDD.

Controller sumber: `source/app/Http/Controllers/UserController.php`
Model sumber: `source/app/Models/User.php`
Spec target: `specs/modules/user.md`
Task target: `tasks/phase-2-core-modules/task-004-user-module.md`

Tolong eksekusi siklus konversi penuh untuk modul User secara bertahap:

1. SPESIFIKASI (Fase 2):
   - Bedah controller `source/app/Http/Controllers/UserController.php` baris-demi-baris (Deep Controller AST Inspection).
   - Tulis spesifikasi lengkap di `specs/modules/user.md` menggunakan template `specs/modules/_template.md`.
   - Terapkan 8 Standar Mutu: Pagination envelope, Validation 422 object-of-arrays, filter Soft-delete di JOIN, Pointer types untuk field nullable (phone, avatar_url, dll.), dan Empty array `[]`.
   - Lengkapi Spec Definition of Done (DoD) Checklist.

2. CHECKPOINT 1 (Audit Keselarasan Spec vs Source):
   - Pastikan seluruh endpoint (list, detail, update profile, soft delete), query params, percabangan role (Admin vs Self), dan relasi DB sudah tercatat 100%.

3. TASK BREAKDOWN (Fase 3):
   - Buat file task di `tasks/phase-2-core-modules/task-004-user-module.md` menggunakan template `tasks/_template.md` (pecah sub-tasks layer DTO ➔ Domain ➔ Repo ➔ Service ➔ Handler ➔ Tests).
   - Update `tasks/_index.md`.

4. EKSEKUSI CODING (Fase 4):
   - Tulis kode di `output/` lapis demi lapis (DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Route).
   - STRICT NO DUMMY FALLBACK: Seluruh method repository wajib kueri database riil (DILARANG hardcoded dummy).
   - Pelihara audit trail di docs/: catat ADR di `docs/decisions.md` jika ada library baru, deviasi di `docs/mapping-log.md`, riwayat di `docs/changelog.md`, dan milestone di `docs/progress.md`.

5. TESTING & CHECKPOINT 2:
   - Buat & jalankan unit test di `output/tests/`.
   - Validasi zero dummy data dan nullability parity.
   - Tandai task [x] di `tasks/_index.md`.

Tampilkan ringkasan hasil konversi modul User setelah selesai.
```

---

## 📋 Opsi A: Step-by-Step Modul User

#### 1. Tulis Spec Modul User (Fase 2 — Deep AST Inspection)
```markdown
Tolong buatkan spesifikasi detail berstandar enterprise untuk modul User di `specs/modules/user.md`.

Referensi Sumber:
- Controller: `source/app/Http/Controllers/UserController.php`
- Model: `source/app/Models/User.php`

Gunakan template di `specs/modules/_template.md` dan terapkan aturan DEEP CONTROLLER AST INSPECTION & 8 CRITICAL QUALITY STANDARDS:
1. Bedah controller sumber baris-demi-baris:
   - Catat SEMUA query parameter (`?page=...`, `?per_page=...`, `?search=...`).
   - Petakan SEMUA percabangan logika internal (`if/switch`, Admin vs Self User check) ke dalam tabel Branching Matrix.
   - Catat SEMUA kueri SQL, Table Joins, GROUP BY, dan agregasi kalkulasi.
2. Terapkan 8 Standar Mutu Enterprise pada Spesifikasi (Pagination envelope, Validation Error format, Pointer Nullability, Empty State `[]`).
3. Lengkapi Spec Definition of Done (DoD) Checklist di bagian atas berkas.

Tunjukkan draf spesifikasi yang telah selesai untuk saya tinjau.
```

#### 2. Checkpoint 1: Verifikasi Spec vs Source (Fase 2B)
```markdown
Tolong lakukan audit silang verifikasi (Checkpoint 1: Spec vs Source Alignment) untuk modul User:
1. Bandingkan controller sumber `source/app/Http/Controllers/UserController.php` baris-demi-baris dengan `specs/modules/user.md`.
2. Sajikan tabel konfirmasi audit (Endpoint, Query Params, Branching if/switch, Nullability Pointer, DB Query & Joins, 8 Standar Mutu).
3. Lengkapi spesifikasi jika ada yang terlewat, dan konfirmasi kesiapan pembuatan task.
```

#### 3. Buat Task Breakdown Modul User (Fase 3)
```markdown
Berdasarkan spesifikasi di `specs/modules/user.md` yang telah lolos Checkpoint 1:
1. Buat berkas task terperinci di `tasks/phase-2-core-modules/task-004-user-module.md` menggunakan template `tasks/_template.md`.
2. Pecah sub-task secara terisolasi dan bertingkat (Layer-by-Layer: DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Tests).
3. Daftarkan task baru tersebut ke dalam tabel antrean di `tasks/_index.md`.
```

#### 4. Eksekusi Konversi Modul User (Fase 4 — Strict Zero Dummy)
```markdown
Tolong konversi modul User dari `source/app/Http/Controllers/UserController.php` ke `output/` sesuai spesifikasi `specs/modules/user.md` dan task `tasks/phase-2-core-modules/task-004-user-module.md`.

Instruksi Wajib Eksekusi:
1. Baca `specs/modules/user.md`, `tasks/phase-2-core-modules/task-004-user-module.md`, dan `context/RULES.md`.
2. Tulis kode target di `output/` lapis demi lapis (DTO ➔ Domain ➔ Repository ➔ Service ➔ Handler ➔ Router).
3. STRICT NO DUMMY FALLBACK: Kueri database riil pada repository.
4. Pelihara audit trail di docs/ (`docs/decisions.md`, `docs/mapping-log.md`, `docs/changelog.md`, `docs/progress.md`).
5. Update status task di `tasks/_index.md` menjadi `[/]` saat mulai dan `[x]` setelah selesai dan teruji.
```

#### 5. Checkpoint 2: Audit Keselarasan Kode vs Spec Modul User (Fase 4B)
```markdown
Tolong lakukan audit verifikasi silang (Checkpoint 2: Code vs Spec Parity) untuk modul User:
1. Periksa repository di `output/internal/repository/`: Pastikan zero dummy data.
2. Periksa apakah seluruh endpoint list & detail menangani pagination dan field pointer nullability dengan aman.
3. Jalankan unit test dan integration test di `output/tests/`.
4. Pastikan audit trail di docs/ telah diperbarui.
5. Tampilkan ringkasan hasil pengujian dan konfirmasi kelayakan modul.
```
