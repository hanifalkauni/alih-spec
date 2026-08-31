# 💎 8 Critical Enterprise Quality Standards

Master technical reference for AI Coding Agents to prevent hidden production bugs, race conditions, and contract drifts during cross-stack software conversions.

---

### 1. 🕒 DateTime, Timezone & Serialization Parity
- **Problem**: Default serialization in Go is RFC3339 (`2026-08-31T17:00:00Z`), while legacy systems (Laravel/Django) often serialize dates as `YYYY-MM-DD HH:mm:ss` in local timezone (`Asia/Jakarta (+07:00)`). Frontend apps parsing the date will fail or display shifted hours.
- **Rule**:
  1. Inspect legacy date format in source models (`protected $casts = ['created_at' => 'datetime:Y-m-d H:i:s']`).
  2. Implement custom JSON serializer for Time types when custom formatting is required:
     ```go
     type CustomTime time.Time
     func (t CustomTime) MarshalJSON() ([]byte, error) {
         stamp := fmt.Sprintf("\"%s\"", time.Time(t).Format("2006-01-02 15:04:05"))
         return []byte(stamp), nil
     }
     ```

---

### 2. 💰 Currency & Numeric Precision (Anti-Floating Point Error)
- **Problem**: Using `float32`/`float64` for financial values causes IEEE-754 precision loss (e.g. `0.1 + 0.2 = 0.30000000000000004`), causing financial discrepancies over time.
- **Rule**:
  1. **Strictly NEVER use `float64`** for monetary values, coin balances, loyalty points, or financial transactions.
  2. Use **`int64` (smallest unit basis / sen / cents)** or exact decimal libraries (`shopspring/decimal` in Go, `BigDecimal` in Java, `Decimal` in Python).

---

### 3. 📑 Pagination Envelope & Offset Computation Parity
- **Problem**: Different frameworks calculate pagination differently. Mixing up 0-indexed vs 1-indexed pages results in missing page 1 data or duplicate records.
- **Rule**:
  1. Formula: `offset = (page - 1) * per_page` (Page 1 = Offset 0).
  2. Maintain 100% envelope parity matching legacy frontend expectation:
     ```json
     {
       "current_page": 1,
       "data": [...],
       "from": 1,
       "last_page": 5,
       "per_page": 15,
       "total": 67
     }
     ```

---

### 4. ⚠️ Validation Error Envelope Parity (HTTP 422)
- **Problem**: Frontend UI form handlers expect errors formatted as an **Object of String Arrays** `{"errors": {"field": ["msg"]}}`. Returning a single string or flat array breaks form field error highlights.
- **Rule**:
  1. Return HTTP 422 Unprocessable Entity with exact error map:
     ```json
     {
       "message": "The given data was invalid.",
       "errors": {
         "email": ["The email field is required."],
         "password": ["The password must be at least 8 characters."]
       }
     }
     ```

---

### 5. 🔒 Concurrency, Row-Level Locking & Race Conditions
- **Problem**: High-concurrency checkout or balance transfers executed without row locking allow double-spending via simultaneous requests.
- **Rule**:
  1. Every balance, quota, stock, or coin deduction **MUST execute inside a DB Transaction with Pessimistic Locking (`SELECT ... FOR UPDATE`)**:
     ```go
     // GORM Pattern
     tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&wallet, "user_id = ?", userID)
     ```

---

### 6. 🗑️ Soft Delete Leakage in Manual Joins & Raw SQL
- **Problem**: In ORM manual joins or Raw SQL, soft-deleted records (`deleted_at IS NOT NULL`) are automatically included unless explicitly filtered out, corrupting sum/count queries.
- **Rule**:
  1. On every manual `JOIN` or raw query, explicitly append:
     ```sql
     AND users.deleted_at IS NULL
     AND orders.deleted_at IS NULL
     ```

---

### 7. 🔑 JWT Claims Key Parity & Token Extraction
- **Problem**: If the source authentication system issues JWT with claim key `"uid"` or `"sub"` and the target middleware looks for `"user_id"`, user context defaults to 0/empty, causing unauthorized actions.
- **Rule**:
  1. Inspect the legacy JWT payload generator (`jwt.claims`).
  2. Implement multi-key fallback extractor (`sub`, `uid`, `user_id`, `account_id`, `tenant_id`).

---

### 8. 🛡️ Empty State & Null Representation Contract
- **Problem**: Returning `null` instead of `[]` for an empty array triggers `TypeError: Cannot read properties of null (reading 'map')` on Frontend/Mobile clients.
- **Rule**:
  1. Collection endpoints must return empty slice `[]` (not `null`).
  2. Single record lookup (e.g. `GET /users/:id`) must return HTTP 404 Not Found or `null` if not found.
