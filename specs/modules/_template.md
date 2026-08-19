# Module Spec: [Module Name]

> **📋 Template Spesifikasi Modul (AlihSpec SDD)**  
> Salin berkas ini dan lengkapi setiap bagian sebelum membuat berkas `tasks/` dan menulis kode di `output/`.
> 
> ⚠️ **PENTING**: Bedah controller sumber secara baris-demi-baris (*Deep Controller AST Inspection*). Jangan membuat spesifikasi dangkal (*Shallow Specs*)!

---

## 🎯 Spec Definition of Done (DoD) Checklist

Sebelum spesifikasi ini dinyatakan selesai dan siap dibuatkan task:
- [ ] **Validation & Query Parity**: Seluruh query parameters (`?menu=...`, `?filter=...`, `?tab=...`, `?page=...`) dan validasi input telah tercatat.
- [ ] **Branching Logic Parity**: Seluruh percabangan logika internal controller (`if/switch` dan mode respons berbeda) telah dipetakan.
- [ ] **SQL & Table Join Parity**: Seluruh relasi tabel, JOIN, GROUP BY, aggregasi, dan kueri raw telah didokumentasikan.
- [ ] **Pointer Nullability Parity**: Seluruh field DTO opsional/nullable menggunakan tipe pointer (`*string`, `*int64`, `*bool`).
- [ ] **No Dummy Fallback**: Seluruh skenario data memiliki sumber query riil tanpa hardcoded fallback.

---

## 📌 1. Overview & Source Reference

- **Modul**: [Nama Modul]
- **Deskripsi**: [Deskripsi singkat fungsi bisnis modul]
- **Source Controller**: `source/[path/to/Controller.php]`
- **Source Model / Entities**: `source/[path/to/Models/]`
- **Target Output Files**:
  - `output/internal/handler/[module]_handler.go`
  - `output/internal/service/[module]_service.go`
  - `output/internal/repository/[module]_repository.go`
  - `output/internal/domain/[module].go`
  - `output/internal/dto/[module]_dto.go`

---

## 🌐 2. API Endpoints & Branching Matrix

### Endpoint: `[METHOD] /api/v1/[resource-path]`

- **Auth Required**: `Yes (Bearer JWT)` / `No`
- **Controller Action**: `[ControllerName]@[methodName]`

#### A. Query Parameters & Headers
| Param / Header | Type | Required | Default | Deskripsi & Efek Logika |
|---|---|---|---|---|
| `menu` | string | No | `""` | Percabangan mode (`mission`, `history_coin`, dll.) |
| `limit` | int | No | `10` | Jumlah data per halaman |
| `offset` | int | No | `0` | Offset pagination |

#### B. Percabangan Logika Internal (Internal Branching Matrix)
> *Petakan seluruh kondisi `if/switch` di dalam controller sumber.*

| Kondisi Parameter / State | Aksi Bisnis / Query yang Dijalankan | Struktur Payload Response |
|---|---|---|
| **Base Mode** (default) | Ambil data dasar user dari tabel utama | `[Module]BaseResponseDTO` |
| **Mode A** (`menu=mission`) | Join 5 tabel untuk hitung akumulasi poin/koin | `[Module]MissionResponseDTO` |
| **Mode B** (`menu=history`) | Group by tanggal kedaluwarsa terdekat | `[Module]HistoryResponseDTO` |

#### C. Request Body (jika POST / PUT / PATCH)
```json
{
  "field_name": "string (required, min:3)",
  "optional_field": "integer (optional, nullable)"
}
```

#### D. Success Response DTO Structure
```json
{
  "status": "success",
  "message": "Data retrieved successfully",
  "data": {
    "field_a": "value",
    "optional_field": null
  }
}
```

#### E. Error Responses
| HTTP Status | Error Code / Message | Kondisi Terjadinya |
|---|---|---|
| `400 Bad Request` | `VALIDATION_ERROR` | Format input tidak valid |
| `401 Unauthorized` | `UNAUTHORIZED` | Token JWT tidak valid atau kedaluwarsa |
| `404 Not Found` | `DATA_NOT_FOUND` | Data ID tidak ditemukan di DB |

---

## 🗄️ 3. Database Schema, Relations & Queries

### A. Tabel Terkait (Source Tables)
- `users` (tabel utama)
- `[table_b]` (relasi: `users.id = table_b.user_id`)
- `[table_c]` (relasi: `...`)

### B. Query & Calculation Logic (GORM Equivalent)
```go
// Catat query spesifik termasuk Join, Group By, dan Aggregate
// Contoh:
// db.Table("users").
//    Joins("LEFT JOIN user_coins ON users.id = user_coins.user_id").
//    Where("users.id = ?", userID).
//    Select("COALESCE(SUM(user_coins.amount), 0)")
```

---

## 📜 4. Central Business Rules

- [ ] **Rule 1**: [Aturan bisnis detail, rumus kalkulasi, atau validasi khusus]
- [ ] **Rule 2**: [Aturan penanganan nilai null atau fallback saat relasi kosong]
- [ ] **Rule 3**: [Aturan batasan kuota, otorisasi role, atau hak akses]

---

## 🧱 5. Target DTO Structs (Strict Pointer Nullability)

```go
// Request DTO
type [Module]RequestDTO struct {
	FieldA        string  `json:"field_a" validate:"required,min=3"`
	OptionalField *string `json:"optional_field,omitempty" validate:"omitempty"`
}

// Response DTO
type [Module]ResponseDTO struct {
	ID            int64   `json:"id"`
	FieldA        string  `json:"field_a"`
	OptionalField *string `json:"optional_field,omitempty"` // Pointer untuk nullability parity
}
```

---

## 🔌 6. Domain Interface & Contracts

```go
type [Module]Repository interface {
	GetByID(ctx context.Context, id int64) (*domain.[Module], error)
	GetCustomAggregate(ctx context.Context, userID int64, mode string) (*dto.[CustomDTO], error)
}

type [Module]UseCase interface {
	Execute(ctx context.Context, req *dto.[Module]RequestDTO) (*dto.[Module]ResponseDTO, error)
}
```

---

## 🧪 7. Acceptance Criteria & Test Cases

| Skenario Pengujian | Input / Parameter | Expected Result & HTTP Status |
|---|---|---|
| Base Scenario | Request valid tanpa query params | HTTP 200, payload data dasar lengkap |
| Mode Branching | `?menu=mission` | HTTP 200, payload kalkulasi poin termuat |
| Null Safety | Record relasi kosong di DB | HTTP 200, field pointer bernilai `null` (bukan 0/default) |
| Invalid Input | Field wajib dikosongkan | HTTP 400, pesan validasi terperinci |
