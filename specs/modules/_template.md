# Module Spec: [Module Name]

> **📋 Template** — Copy this file and rename it to create a new module spec.
> Fill in each section before starting implementation.

---

## Overview
[Brief description of what this module does]

## Source Reference
- `source/[path/to/source/controller]`
- `source/[path/to/related/files]`

## Target Output Files
- `output/internal/handler/[module]_handler.go`
- `output/internal/service/[module]_service.go`
- `output/internal/repository/[module]_repository.go`
- `output/internal/domain/[module].go`
- `output/internal/dto/[module]_dto.go`

---

## API Endpoints

### [METHOD] /api/v1/[resource]
**Description**: [What does this endpoint do?]
**Auth Required**: Yes / No

**Request Body** (if applicable):
```json
{
  "field_name": "type (required/optional, validation rules)"
}
```

**Query Params** (if applicable):
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `page` | int | No | Page number (default: 1) |
| `per_page` | int | No | Items per page (default: 15) |

**Success Response** `[Status Code]`:
```json
{
  "success": true,
  "message": "[Success message]",
  "data": { ... }
}
```

**Error Responses**:
- `[Code]` — [Description]

---

## Business Rules

- [ ] [Rule 1]
- [ ] [Rule 2]
- [ ] [Rule 3]

---

## Domain Model (Target)

```go
type [ModelName] struct {
    gorm.Model
    // Add fields here
}
```

---

## DTO Structs (Target)

```go
type [Module]Request struct {
    // Add fields with validation tags
}

type [Module]Response struct {
    // Add response fields
}
```

---

## Interface (Target)

```go
type [Module]Service interface {
    // Add method signatures
}

type [Module]Repository interface {
    // Add method signatures
}
```

---

## Acceptance Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

---

## Test Cases

| Test | Expected |
|------|---------|
| [Scenario] | [Expected result] |

---

## Notes

> Any additional context, edge cases, or decisions specific to this module.
