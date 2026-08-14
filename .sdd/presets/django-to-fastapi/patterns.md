# Pattern Mapping: Django (Python) → FastAPI (Python)

## Application Layer

| Source (Django) | Target (FastAPI) | Notes |
|-----------------|------------------|-------|
| `views.py` | `routers/` | APIRouter per module |
| `serializers.py` | `schemas/` | Pydantic models |
| `models.py` | `models/` (SQLAlchemy) + `schemas/` | Split into DB model + schema |
| `forms.py` | `schemas/` (Pydantic) | Input validation |
| `admin.py` | Drop or use admin panel lib | e.g., `fastapi-admin` |
| `apps/` | `modules/` or feature folders | |
| `services.py` (custom) | `services/` | Business logic layer |
| `managers.py` | Repository or service methods | |
| `signals.py` | Event system or background tasks | |
| `tasks.py` (Celery) | `workers/` (Celery or ARQ) | |
| `middleware.py` | `middleware/` | FastAPI middleware |
| `permissions.py` | `dependencies/` | FastAPI dependency injection |
| `management/commands/` | `cli/` (Typer or Click) | |

## Routing

| Source (Django) | Target (FastAPI) | Notes |
|-----------------|------------------|-------|
| `urls.py` | `routers/` + `main.py` | APIRouter |
| `path('users/', ...)` | `@router.get("/users")` | Decorator-based |
| `include('app.urls')` | `app.include_router(router)` | |
| `re_path(...)` | Path params with regex | |
| `<int:pk>` | `/{id: int}` | Path parameter |
| `<slug:slug>` | `/{slug: str}` | |
| `namespace` | APIRouter `prefix` + `tags` | |
| `reverse('name')` | `url_path_for('name')` | |

## ORM (Django ORM → SQLAlchemy)

| Source (Django ORM) | Target (SQLAlchemy) | Notes |
|--------------------|---------------------|-------|
| `Model.objects.all()` | `db.query(Model).all()` | |
| `Model.objects.get(pk=id)` | `db.query(Model).filter_by(id=id).first()` | |
| `Model.objects.filter(...)` | `db.query(Model).filter(...)` | |
| `Model.objects.create(...)` | `db.add(model); db.commit()` | |
| `obj.save()` | `db.commit()` | |
| `obj.delete()` | `db.delete(obj); db.commit()` | |
| `Model.objects.select_related()` | SQLAlchemy `joinedload()` | |
| `Model.objects.prefetch_related()` | SQLAlchemy `selectinload()` | |
| `Q` objects | `or_()`, `and_()` | |
| `annotate()` | `label()` | |
| `aggregate()` | `func.sum()`, `func.count()` | |
| `values()` | `.with_entities()` | |
| `order_by()` | `.order_by()` | |
| `exclude()` | `.filter(Model.x != val)` | |
| `get_or_create()` | Manual check-then-create | |
| `update_or_create()` | Manual upsert | |

## Authentication & Permissions

| Source (Django) | Target (FastAPI) | Notes |
|-----------------|------------------|-------|
| `@login_required` | `Depends(get_current_user)` | FastAPI dependency |
| `@permission_required` | `Depends(require_permission)` | Custom dependency |
| `request.user` | `current_user: User = Depends(...)` | Injected |
| Django session auth | JWT via `python-jose` | |
| `AbstractUser` | Custom User SQLAlchemy model | |
| `UserCreationForm` | Pydantic `UserCreateSchema` | |
| `check_password()` | `passlib.verify()` | |
| `set_password()` | `passlib.hash()` | |
| `is_authenticated` | Dependency raises 401 | |
| `is_staff` | Role-based dependency | |

## Validation (Serializers → Pydantic)

| Source (DRF Serializer) | Target (Pydantic) | Notes |
|------------------------|-------------------|-------|
| `serializers.CharField()` | `name: str` | |
| `serializers.EmailField()` | `email: EmailStr` | |
| `serializers.IntegerField()` | `age: int` | |
| `serializers.BooleanField()` | `active: bool` | |
| `required=False` | `Optional[str] = None` | |
| `validators=[...]` | `@validator(...)` or `Field(...)` | |
| `validate_<field>()` | `@validator('field')` | |
| `validate()` | `@root_validator` | |
| `read_only=True` | Separate response schema | |
| `write_only=True` | Exclude from response schema | |
| `many=True` | `List[Schema]` | |
| `source='field'` | `@property` or `alias` | |

## HTTP Response

| Source (Django/DRF) | Target (FastAPI) | Notes |
|--------------------|------------------|-------|
| `Response(data, status=200)` | `return data` (auto) | FastAPI auto-serializes |
| `Response(data, status=201)` | `return JSONResponse(status_code=201, ...)` | |
| `Response(status=204)` | `return Response(status_code=204)` | |
| `raise Http404` | `raise HTTPException(status_code=404)` | |
| `raise PermissionDenied` | `raise HTTPException(status_code=403)` | |
| `raise ValidationError` | `raise RequestValidationError(...)` | |
| `JsonResponse({...})` | `return JSONResponse({...})` | |
| `paginator.paginate_queryset()` | Custom pagination dependency | |

## Configuration

| Source (Django) | Target (FastAPI) | Notes |
|-----------------|------------------|-------|
| `settings.py` | `core/config.py` (Pydantic Settings) | |
| `os.environ.get('KEY')` | `settings.key` | Pydantic BaseSettings |
| `DATABASES = {...}` | `DATABASE_URL` env + SQLAlchemy | |
| `INSTALLED_APPS` | Not needed | |
| `MIDDLEWARE = [...]` | `app.add_middleware(...)` | |
| `STATIC_ROOT` | Static files mount | |
| `MEDIA_ROOT` | Custom file storage | |
| `django.conf.urls` | `app.include_router(...)` | |

## Testing

| Source (Django) | Target (FastAPI) | Notes |
|-----------------|------------------|-------|
| `TestCase` | `pytest` + `TestClient` | |
| `self.client.get('/api/...')` | `client.get('/api/...')` | `httpx.TestClient` |
| `self.assertEqual(...)` | `assert response.status_code == 200` | |
| `setUp()` | `@pytest.fixture` | |
| `tearDown()` | Fixture cleanup | |
| `APITestCase` | `TestClient(app)` | |
| `override_settings` | Monkeypatch or test settings | |
| Factories (factory_boy) | `pytest-factoryboy` or fixtures | |
