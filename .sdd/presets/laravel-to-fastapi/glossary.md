# Glossary: Laravel ➔ FastAPI (Python)

## 1. Padanan Konsep & Istilah

| Laravel Term | FastAPI (Python) Term | Penjelasan |
|---|---|---|
| Controller | Router Endpoint Function | Handler fungsi pemroses HTTP request |
| Eloquent Model | SQLAlchemy Declarative Model | Model pemetaan tabel database |
| FormRequest / Validation Rule | Pydantic Schema (`BaseModel`) | Skema validasi tipe data input request |
| API Resource (`JsonResource`) | Pydantic Response Model (`response_model`) | Serializer output JSON |
| Middleware | Middleware / `Depends()` Function | Interceptor & dependency injection handler |
| Artisan Migration | Alembic Migration (`alembic revision --autogenerate`) | Versioning skema database |
| Service Provider / Container | FastAPI Dependency Injection (`Depends`) | Penyedia instance service & DB session |
| `composer.json` | `requirements.txt` / `pyproject.toml` (Poetry/Uv) | Manajemen dependensi paket |
| `php artisan serve` | `uvicorn app.main:app --reload` | Development server |
