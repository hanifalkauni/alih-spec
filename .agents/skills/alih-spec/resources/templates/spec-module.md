# Specification: [Module Name]

> **Status**: Draft | In Review | Approved | In Implementation | Done  
> **Source Module**: `[Path to source controller/model]`  
> **Target Module**: `[Path to target handler/domain/service/repository]`  

---

## 1. Overview & Business Scope

[Brief 1-2 paragraph description of the module's business purpose, domain boundaries, and user roles involved.]

---

## 2. Endpoints & Route Contracts

| Method | Endpoint URI | Middleware / Guards | Source Controller Action | Target Handler Method |
|---|---|---|---|---|
| `POST` | `/api/v1/[resource]` | `auth:jwt` | `[SourceController]::store` | `[TargetHandler]::Create` |
| `GET` | `/api/v1/[resource]` | `auth:jwt` | `[SourceController]::index` | `[TargetHandler]::List` |
| `GET` | `/api/v1/[resource]/:id` | `auth:jwt` | `[SourceController]::show` | `[TargetHandler]::GetByID` |
| `PUT` | `/api/v1/[resource]/:id` | `auth:jwt` | `[SourceController]::update` | `[TargetHandler]::Update` |
| `DELETE` | `/api/v1/[resource]/:id` | `auth:jwt` | `[SourceController]::destroy` | `[TargetHandler]::Delete` |

---

## 3. Data Transfer Objects (DTOs) & Pointer Nullability

> 🚨 **Pointer Nullability Rule**: All nullable/optional fields MUST use pointer types (`*int64`, `*string`, `*bool`) to prevent false zero-values in JSON.

### Request DTOs
```go
type Create[Resource]Request struct {
    Name        string  `json:"name" validate:"required,min=3"`
    Description *string `json:"description,omitempty"`
    CategoryID  uint    `json:"category_id" validate:"required"`
}

type List[Resource]QueryParam struct {
    Menu    *string `query:"menu"`
    Tab     *string `query:"tab"`
    Page    int     `query:"page"`
    PerPage int     `query:"per_page"`
}
```

### Response DTOs
```go
type [Resource]Response struct {
    ID          uint    `json:"id"`
    Name        string  `json:"name"`
    Description *string `json:"description,omitempty"`
    CreatedAt   string  `json:"created_at"`
    UpdatedAt   string  `json:"updated_at"`
}
```

---

## 4. Deep AST Branching Matrix

| Branch ID | Trigger Parameter / Condition | Source Line / Logic | Target Response Payload / State |
|:---:|---|---|---|
| `BR-01` | Base Mode (Default) | `if (!request->has('menu'))` | Returns base list / details |
| `BR-02` | `menu=mission` | `if ($request->menu == 'mission')` | Queries 5 tables and aggregates potential points |
| `BR-03` | `menu=history` | `if ($request->menu == 'history')` | Returns grouped expiration date totals |

---

## 5. SQL Queries, Joins & Concurrency Locking

### Database Tables & Relations
- Tables: `[table_1]`, `[table_2]`
- Soft Delete Filtering: `AND [table].deleted_at IS NULL`
- Concurrency Locking: `SELECT ... FOR UPDATE` on `[table]` during balance deductions.

---

## 6. Definition of Done (DoD) Checklist

Before marking this spec complete and proceeding to task breakdown, verify:
- [ ] **Validation & Query Parity**: All validation rules and query parameters (`menu`, `tab`, `filter`) are documented in Request DTOs.
- [ ] **Branching Parity**: All internal `if/switch` branching scenarios are captured in the Branching Matrix.
- [ ] **SQL Query Parity**: All table names, joins, grouping, and row-level locks are specified.
- [ ] **Pointer Nullability Parity**: All optional/nullable fields use pointer types.
- [ ] **8 Quality Standards**: DateTime formats, currency `int64`, 422 error format, and pagination envelope are aligned.
