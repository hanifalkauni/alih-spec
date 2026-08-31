# 🛡️ QA Parity Checklist: [Module Name]

> Verify this checklist after implementing each module. All items must pass before marking the task `[x] Done`.

---

## 1. 🔍 Spec & Logic Parity (Anti-Shallow Specs)
- [ ] **Query Parameters Parity**: All parameters (`?menu=...`, `?tab=...`, `?filter=...`, `?limit=...`) are processed.
- [ ] **Internal Branching Parity**: All `if/switch` branches from the source controller are fully implemented.
- [ ] **Strict No Dummy Fallback**: Repository methods execute real database queries without hardcoded dummy data.
- [ ] **Multi-Table Joins & Aggregations**: All joins, group by, and calculations are connected to real database schemas.

---

## 2. 💎 8 Enterprise Quality Standards Verification
- [ ] **[Q1] DateTime & Timezone Parity**: Date serialization (`YYYY-MM-DD HH:mm:ss` / ISO 8601) and timezone match source.
- [ ] **[Q2] Currency & Numeric Precision**: No `float64` for financial values; strictly using `int64` (cents) or exact decimal.
- [ ] **[Q3] Pagination Envelope & Offset**: Metadata pagination and `(page - 1) * per_page` offset computation are 100% accurate.
- [ ] **[Q4] Validation Error Format**: HTTP 422 format is Object of String Arrays `{"errors": {"field": ["msg"]}}`.
- [ ] **[Q5] Concurrency & Row-Level Locking**: Balance/stock mutations use transactions and `SELECT ... FOR UPDATE`.
- [ ] **[Q6] Soft Delete Leakage Prevention**: Manual joins include `AND [table].deleted_at IS NULL`.
- [ ] **[Q7] JWT Claims Key Parity**: JWT claim keys (`sub`, `uid`, `user_id`) match authentication source token.
- [ ] **[Q8] Empty State Contract**: Empty collections return `[]` (not `null`). Single missing records return HTTP 404 / `null`.

---

## 3. 🎯 Pointer Nullability & Clean Architecture
- [ ] Optional DTO and database fields use pointer types (`*int64`, `*string`, `*bool`).
- [ ] Layered separation enforced: Handler ➔ Service / UseCase ➔ Repository ➔ Domain Entities.
- [ ] Multi-table mutations in one usecase propagate the same DB transaction (`tx`).
- [ ] Entity models declare `TableName()` explicitly.
- [ ] External HTTP clients configure explicit timeout limits.
- [ ] File uploads use streaming I/O (`io.Copy`) directly to storage.
