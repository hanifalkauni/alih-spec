# Module Spec: Product

## 🎯 Spec Definition of Done (DoD) Checklist
- [x] **Validation & Query Parity**: Query params (category_id, search, min_price, max_price, page, per_page) tercatat.
- [x] **Branching Logic Parity**: Percabangan filter multi-kategori dan stock availability dipetakan.
- [x] **SQL & Table Join Parity**: Relasi tabel categories dan product_images tercatat.
- [x] **Pointer Nullability Parity**: Field description dan discount_price bertipe pointer.
- [x] **No Dummy Fallback**: Seluruh kueri katalog terhubung ke database.

---
> **📋 Example module** — Replace this with your actual product/resource module.
> If your project doesn't have a "Product" module, rename this file accordingly.

## Overview
Handles product catalog management — CRUD for products including
listing, search, create, update, and delete.

## Source Reference
- `source/app/Http/Controllers/ProductController.php`
- `source/app/Models/Product.php`
- `source/app/Http/Requests/Product/CreateProductRequest.php`
- `source/app/Http/Requests/Product/UpdateProductRequest.php`
- `source/app/Http/Resources/ProductResource.php`

## Target Output Files
- `output/internal/handler/product_handler.go`
- `output/internal/service/product_service.go`
- `output/internal/repository/product_repository.go`
- `output/internal/domain/product.go`
- `output/internal/dto/product_dto.go`

---

## API Endpoints

### GET /api/v1/products
**Description**: List products with filtering and pagination.
**Auth Required**: No (public endpoint)

**Query Params**:
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `page` | int | No | Page (default: 1) |
| `per_page` | int | No | Per page (default: 15, max: 100) |
| `search` | string | No | Search by name |
| `category_id` | int | No | Filter by category |
| `min_price` | int | No | Minimum price filter (in cents) |
| `max_price` | int | No | Maximum price filter (in cents) |
| `sort` | string | No | `price_asc`, `price_desc`, `newest` |

**Success Response** `200 OK`:
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Product Name",
      "description": "...",
      "price": 9999,
      "stock": 100,
      "category_id": 1,
      "created_at": "..."
    }
  ],
  "meta": { "page": 1, "per_page": 15, "total": 200 }
}
```

---

### GET /api/v1/products/{id}
**Description**: Get single product detail.
**Auth Required**: No

**Success Response** `200 OK`:
```json
{ "success": true, "data": { "id": 1, "name": "...", ... } }
```

**Error Responses**:
- `404 Not Found` — Product tidak ada

---

### POST /api/v1/products
**Description**: Create new product.
**Auth Required**: Yes — Admin only

**Request Body**:
```json
{
  "name": "string (required, min:2, max:255)",
  "description": "string (optional)",
  "price": "integer (required, min:0, basis sen/cents)",
  "stock": "integer (required, min:0)",
  "category_id": "integer (required)"
}
```

**Success Response** `201 Created`:
```json
{ "success": true, "message": "Product created", "data": { ... } }
```

---

### PUT /api/v1/products/{id}
**Description**: Update product.
**Auth Required**: Yes — Admin only

**Request Body**: Same as POST, all fields optional.

**Success Response** `200 OK`:
```json
{ "success": true, "message": "Product updated", "data": { ... } }
```

---

### DELETE /api/v1/products/{id}
**Description**: Delete product (soft delete).
**Auth Required**: Yes — Admin only

**Success Response** `200 OK`:
```json
{ "success": true, "message": "Product deleted" }
```

---

## Business Rules

- [ ] Price tidak boleh negatif (disimpan dalam `int64` basis terkecil/sen)
- [ ] Stock tidak boleh negatif
- [ ] Product name harus unik per category
- [ ] Product yang dihapus adalah soft delete
- [ ] Product dengan stock 0 masih bisa ditampilkan tapi ditandai "out of stock"
- [ ] Hanya admin yang bisa create/update/delete product

---

## Domain Model (Target)

```go
type Product struct {
    gorm.Model
    Name        string   `gorm:"size:255;not null" json:"name"`
    Description *string  `gorm:"type:text" json:"description,omitempty"`
    Price       int64    `gorm:"not null;check:price >= 0" json:"price"` // int64 basis sen (Anti-Floating Point)
    Stock       int      `gorm:"not null;default:0" json:"stock"`
    CategoryID  uint     `gorm:"not null" json:"category_id"`
    Category    Category `gorm:"foreignKey:CategoryID" json:"category,omitempty"`
}
```

---

## Acceptance Criteria

- [ ] Public bisa list product dengan filter dan pagination
- [ ] Public bisa lihat detail product
- [ ] Admin bisa create product
- [ ] Admin bisa update product
- [ ] Admin bisa delete product (soft delete)
- [ ] Non-admin tidak bisa create/update/delete
- [ ] Validation berjalan (price >= 0, stock >= 0, dll)

---

## Test Cases

| Test | Expected |
|------|---------|
| GET /products | 200 + list |
| GET /products?search=keyword | 200 + filtered list |
| GET /products/:id | 200 + product |
| GET /products/:id (not found) | 404 |
| POST /products (admin) | 201 + product |
| POST /products (non-admin) | 403 |
| PUT /products/:id (admin) | 200 + updated |
| DELETE /products/:id (admin) | 200 |


