# 🛡️ 16 Universal Conversion Pillars Cheatsheet

Quick reference for AI Coding Agents when converting backend codebases across programming languages and frameworks.

---

### 🌐 Quadrant A: Config, Protocols & Routing
1. **Zero Environment Key Drift**: Keep `.env` keys 100% identical to source (`DB_COIN_PORT`, `SERVICE_AUTH_URI`). Never invent new variable names in the target config parser.
2. **URL Builder Resiliency**: Always use a safe URL trimmer/joiner to strip trailing slash from base URLs and leading slash from paths to prevent double-slashes (`//`).
3. **Universal Context Claims**: Use multi-key fallback extraction for user context (`tenant_id`, `business_id`, `store_id`, `user_id`, `sub`).
4. **Route Prefix Dual-Mounting**: Mount routes on both `/api/v1/...` and `/v1/...` simultaneously to support both external API clients and internal microservices.

---

### 🎯 Quadrant B: Data Contracts & Validation
5. **Domain Valuation & Localization**: Inspect external helper methods for currency multipliers (e.g. 1 coin = Rp 100) and number formatting (`Rp 2.051.600`).
6. **Smart Query Normalization**: Default optional query parameters before running struct validators (`tab = "all"`, `limit = 15`).
7. **Pointer Nullability Parity**: Always use pointer types (`*int64`, `*string`, `*bool`) or nullable unions (`T | null`) on optional JSON fields to prevent false zero-values (`0` or `""`).
8. **Flexible Payload Coercion**: Support flexible string-to-number/boolean type parsing for form submissions and legacy clients.

---

### 🗄️ Quadrant C: Database, Transactions & ACID
9. **Strict Zero Dummy Fallback**: 100% real database queries in Repository layer. Never return mock hardcoded values (`return 5000, nil` or `[]map{}`).
10. **Explicit DB Transaction Context Propagation**: Propagate `tx` context to all repository calls in a multi-step usecase to guarantee atomic rollback on failure.
11. **ORM Explicit Table & Column Binding**: Explicitly define `TableName()` and column tags (`gorm:"column:user_id"`) to prevent ORM pluralization errors.
12. **Idempotency & Safe Mutation**: Require `X-Idempotency-Key` or Redis deduplication locks on financial mutations (topup, checkout, balance deduction).

---

### ⚡ Quadrant D: Resource Safety & Observability
13. **Async & Shutdown Safety**: Use worker pools connected to Graceful Shutdown (`SIGTERM`/`SIGINT`) with a safe drain period (10-15s). Avoid uncontrolled *fire-and-forget* goroutines.
14. **HTTP Client Timeout Parity**: Always set explicit connection, response header, and total timeouts on external HTTP clients (e.g. 5-10s) to prevent resource leaks and server hangs.
15. **Safe File Upload Streaming**: Stream file uploads via `io.Copy` directly to storage/S3. Limit Max Multipart Memory and validate MIME types via Magic Bytes.
16. **Structured Observability**: Use Structured JSON logging (Zap/Zerolog) and propagate `X-Request-ID` and `context.Context` across all architectural layers.
