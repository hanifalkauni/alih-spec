# Task: [TASK-ID] — [Task Title]

> **Status**: [ ] Not Started | [/] In Progress | [x] Done  
> **Module**: `[Module Name]`  
> **Spec Reference**: `[Path to module spec markdown]`  
> **Phase**: Foundation | Core Module | Integration  

---

## 🎯 Task Objective

[Clear 1-2 sentence description of what will be implemented in this atomic task.]

---

## 📁 Files to Create / Modify

- `[NEW]` `[Path to target domain/entity file]`
- `[NEW]` `[Path to target repository interface & implementation]`
- `[NEW]` `[Path to target service/usecase implementation]`
- `[NEW]` `[Path to target HTTP handler]`
- `[NEW]` `[Path to target unit/integration test]`

---

## 📋 Technical Acceptance Criteria

- [ ] **Data Contracts**: Struct DTOs match the spec, using pointer types for nullable fields.
- [ ] **Layered Boundary**: Business logic resides strictly in Service/UseCase (zero business logic in Handler).
- [ ] **Strict Zero Dummy Fallback**: Repository methods execute real database queries without hardcoded dummy data (`return 5000, nil` or `[]map{}`).
- [ ] **Transaction Safety**: Multi-table operations execute within an isolated DB transaction (`tx`).
- [ ] **Explicit Table Binding**: Domain entity implements `TableName()` explicitly matching the source database table.
- [ ] **Unit Tests**: Unit tests cover Base Mode, Query Parameter Branching, and Error Scenarios with 100% pass rate.

---

## 🧪 Verification Commands

```bash
# Run unit tests for this module
go test -v ./internal/service/...
go test -v ./internal/handler/...
```
