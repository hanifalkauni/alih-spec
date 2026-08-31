# 🛑 Dual-Validation Checkpoints Protocol

Protocol for AI Agents to validate conversion accuracy at critical phase gates before proceeding to the next phase.

---

## 🚦 Checkpoint 1: Spec vs Source Alignment
**When**: After writing `specs/modules/[module].md`, BEFORE creating any task files in `tasks/`.

### Validation Criteria:
- [ ] **Endpoint Coverage**: Are all HTTP routes and controller actions mapped?
- [ ] **Query Parameters Parity**: Are all query params (`menu`, `tab`, `filter`, `limit`, `offset`) included in the Request DTO?
- [ ] **Branching Parity**: Are all internal `if/switch` response structures captured in the Response DTO?
- [ ] **SQL Query Parity**: Are table names, joins, where clauses, and locking requirements recorded in the repository spec?
- [ ] **Definition of Done (DoD)**: Is the DoD checklist included at the bottom of the spec file?

> ❌ **Action on Failure**: Do NOT proceed to task breakdown. Re-inspect the source controller and update the spec file.

---

## 🚦 Checkpoint 2: Task vs Spec Alignment
**When**: After creating task breakdown files in `tasks/`, BEFORE writing any target code in `output/`.

### Validation Criteria:
- [ ] **DTO & Interface Alignment**: Does the task detail all DTO structs, entity definitions, and repository interfaces matching the spec?
- [ ] **Dependency Ordering**: Are database schemas, migrations, and repository tasks ordered before service and handler tasks?
- [ ] **Acceptance Criteria**: Does each task have testable acceptance criteria matching business logic?
- [ ] **Zero Dummy Fallback Requirement**: Is the zero dummy fallback rule emphasized in the task description?

> ❌ **Action on Failure**: Do NOT write target code. Adjust task files until all acceptance criteria and interfaces are 100% aligned with the spec.
