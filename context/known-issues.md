# Known Issues & Technical Decisions

> Document any known issues, edge cases, gotchas, or important technical decisions
> discovered during the conversion. This prevents the same mistake from being made twice.

---

## Format

```markdown
### [ISSUE/DECISION] Short Title
**Date**: YYYY-MM-DD
**Category**: bug | decision | gotcha | note
**Status**: open | resolved | wont-fix

**Context**: What was the situation?
**Problem/Decision**: What was the issue or decision?
**Resolution**: How was it resolved?
**Related files**: Links to relevant files
```

---

## Log

### [DECISION] Architecture Choice: Clean Architecture
**Date**: [Date]
**Category**: decision
**Status**: resolved

**Context**: Needed to choose an architecture pattern for the Go project.
**Decision**: Adopted Clean Architecture with Handler → Service → Repository layers.
**Reason**: Matches the source project's layered structure, easy to test, and idiomatic Go.
**Related files**: [`specs/architecture.md`](../specs/architecture.md)

---

> Add new entries below this line as you discover issues or make decisions.
