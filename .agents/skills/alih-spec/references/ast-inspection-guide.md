# 🔬 Deep Controller AST Inspection Guide

Step-by-step procedural manual for AI agents to dissect legacy controller methods and avoid *Shallow Specifications*.

---

## 🛑 The "Anti-Shallow Spec" Rule

**Never assume an endpoint is simple.** Even a seemingly trivial `GET /api/v1/coins/current` endpoint can contain multi-table aggregations, date calculations, and condition branching based on query parameters (`?menu=mission` vs `?menu=history_coin`).

---

## 🔍 The 4-Step Inspection Protocol

### Step 1: Query & Request Validation Analysis
1. Inspect `$request->validate([...])` or request schema in source code.
2. Note all query parameters:
   - Filters: `menu`, `tab`, `status`, `type`, `date_from`, `date_to`.
   - Pagination: `page`, `per_page`, `limit`, `offset`.
   - Sorting & Search: `sort_by`, `order`, `q`, `search`.

### Step 2: Internal Branching Matrix Dissection
1. Trace all `if ($param == ...)` and `switch ($menu)` blocks.
2. For each branch, identify:
   - Unique response payload structure.
   - Additional database queries triggered.
   - External service or helper calls.

### Step 3: Database Joins & Aggregation Mapping
1. Trace all Eloquent/ORM query builder calls:
   - Joins: `leftJoin('table_b', ...)`
   - Where clauses: `whereDate()`, `whereNull('deleted_at')`
   - Aggregations: `SUM()`, `COUNT()`, `COALESCE()`, `HAVING`
   - Grouping: `groupBy('date')`
   - Locking: `lockForUpdate()` / `SELECT ... FOR UPDATE`

### Step 4: DTO & Pointer Nullability Construction
1. Create request & response DTOs for the target stack.
2. Any field that can be omitted or null in database **MUST** use pointer types:
   ```go
   type ModuleResponse struct {
       BaseField     int64   `json:"base_field"`
       OptionalField *string `json:"optional_field,omitempty"`
   }
   ```
