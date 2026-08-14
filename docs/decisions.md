# Architecture Decision Records (ADR)

> Document every significant architectural decision made during the conversion.
> This creates a history of *why* things were done a certain way, not just *what* was done.

---

## ADR Format

```markdown
## ADR-XXX: [Short Title]
**Date**: YYYY-MM-DD
**Status**: proposed | accepted | rejected | deprecated | superseded

### Context
What is the situation that requires a decision?

### Decision
What was decided?

### Consequences
What are the positive and negative consequences of this decision?
```

---

## Records

## ADR-001: Use Clean Architecture
**Date**: [Date]
**Status**: accepted

### Context
We needed a consistent architectural pattern for the Go project that maps
well to the source Laravel project's structure.

### Decision
Adopted 4-layer Clean Architecture:
- Handler (HTTP) → Service (Business Logic) → Repository (Data) → Domain (Models)

### Consequences
- ✅ Clear separation of concerns
- ✅ Easy to unit test with mocked interfaces
- ✅ Mirrors Laravel's layered structure
- ⚠️ More files/interfaces to maintain vs. simpler patterns

---

## ADR-002: Use GORM over raw SQL
**Date**: [Date]
**Status**: accepted

### Context
Needed an ORM for Go that maps closest to Laravel's Eloquent.

### Decision
Use GORM v2 with `gorm.Model` embedded in domain structs.

### Consequences
- ✅ Familiar ORM pattern for team coming from Laravel/Eloquent
- ✅ Auto-handling of `created_at`, `updated_at`, `deleted_at`
- ⚠️ Slightly less control than raw SQL for complex queries
- 📌 Complex queries should use raw SQL via `db.Raw()`

---

> Add new ADRs below this line.
