# Output Project

This folder contains the **converted project** — the result of the conversion.

> ✅ **WRITE HERE** — All converted code goes into this folder.
> Follow the architecture defined in `../specs/architecture.md`.

---

## Structure

See [`specs/architecture.md`](../specs/architecture.md) for the full folder structure.

## Getting Started (after initial setup)

```bash
cd output
cp .env.example .env
# Edit .env with your local settings

go mod tidy
make migrate-up
make run
```

## Useful Commands

```bash
make run          # Start dev server
make test         # Run tests
make migrate-up   # Apply migrations
make lint         # Run linter
```
