# Glossary: Django (Python) → FastAPI (Python)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| View / ViewSet | Router function | `@router.get()`, `@router.post()` |
| Serializer | Pydantic Schema | `BaseModel` subclass |
| Model | SQLAlchemy Model | `Base` subclass |
| Form | Pydantic Schema | Input validation |
| URL conf | APIRouter | `APIRouter(prefix="/users")` |
| Middleware | Middleware | `app.add_middleware()` |
| Permission class | Dependency | `Depends(require_permission)` |
| Authentication | Dependency | `Depends(get_current_user)` |
| Signal | Event / Background task | |
| Celery task | ARQ / Celery task | `@app.task` or `arq` |
| Management command | CLI (Typer) | `typer.command()` |
| `request.user` | `current_user: User = Depends(...)` | |
| `request.data` | `body: CreateSchema` | Pydantic auto-parse |
| `request.query_params` | `query: str = Query(...)` | FastAPI Query param |
| `ModelSerializer` | Pydantic `from_orm()` | `model_validate(orm_obj)` |
| `validate_data()` | Pydantic `@validator` | |
| `perform_create()` | Service function | Business logic layer |
| `get_queryset()` | Repository function | Data access layer |
| `paginator` | `skip: int, limit: int` | Manual pagination |
| `Response(data, status=200)` | `return data` | FastAPI auto-serializes |
| `raise Http404` | `raise HTTPException(status_code=404)` | |
| Django ORM | SQLAlchemy ORM | `db.query(Model).filter(...)` |
| `settings.py` | `core/config.py` | Pydantic `BaseSettings` |
| `pytest` + `TestCase` | `pytest` + `TestClient` | |

---

## File Path Mapping

| Source (Django) | Target (FastAPI) |
|-----------------|------------------|
| `app/views.py` | `routers/[module].py` |
| `app/serializers.py` | `schemas/[module].py` |
| `app/models.py` | `models/[module].py` |
| `app/urls.py` | `routers/[module].py` (APIRouter) |
| `app/permissions.py` | `dependencies/auth.py` |
| `app/filters.py` | Query params in router |
| `app/tests.py` | `tests/test_[module].py` |
| `project/settings.py` | `core/config.py` |
| `project/urls.py` | `main.py` |
| `manage.py` | `main.py` + CLI scripts |
| `migrations/` | `migrations/` (Alembic) |

---

## HTTP Status Codes

| Scenario | FastAPI |
|----------|---------|
| 200 OK | Default return |
| 201 Created | `status_code=201` in decorator |
| 204 No Content | `Response(status_code=204)` |
| 400 Bad Request | `HTTPException(status_code=400)` |
| 401 Unauthorized | `HTTPException(status_code=401)` |
| 403 Forbidden | `HTTPException(status_code=403)` |
| 404 Not Found | `HTTPException(status_code=404)` |
| 422 Validation Error | Automatic by FastAPI + Pydantic |
| 500 Server Error | `HTTPException(status_code=500)` |
