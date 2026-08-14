# Convention Mapping: Django (Python) → FastAPI (Python)

## Naming

| Concept | Django | FastAPI | Example |
|---------|--------|---------|---------|
| Variables | `snake_case` | `snake_case` | Same |
| Functions | `snake_case` | `snake_case` | Same |
| Classes | `PascalCase` | `PascalCase` | Same |
| Constants | `UPPER_SNAKE` | `UPPER_SNAKE` | Same |
| Files | `snake_case.py` | `snake_case.py` | Same |
| Modules | `snake_case/` | `snake_case/` | Same |
| Views → Routers | `UserView` / `UserViewSet` | `user_router.py` | File-based |
| Serializers → Schemas | `UserSerializer` | `UserSchema`, `UserCreateSchema`, `UserResponse` | Split by purpose |
| Models → Models | `User(models.Model)` | `User(Base)` SQLAlchemy | |

## File Structure

| Django | FastAPI | Notes |
|--------|---------|-------|
| `app/views.py` | `routers/user.py` | |
| `app/serializers.py` | `schemas/user.py` | |
| `app/models.py` | `models/user.py` | SQLAlchemy model |
| `app/urls.py` | `routers/user.py` | APIRouter |
| `app/admin.py` | Omit or admin lib | |
| `app/tests.py` | `tests/test_user.py` | |
| `app/permissions.py` | `dependencies/auth.py` | |
| `app/filters.py` | Query params in schemas | |
| `project/settings.py` | `core/config.py` | |
| `project/urls.py` | `main.py` | |

## Target Project Structure

```
output/
├── main.py                     # FastAPI app entry point
├── core/
│   ├── config.py               # Pydantic Settings
│   ├── database.py             # SQLAlchemy session
│   └── security.py             # Auth utilities
├── models/                     # SQLAlchemy ORM models
│   └── user.py
├── schemas/                    # Pydantic schemas
│   └── user.py                 # CreateSchema, UpdateSchema, Response
├── routers/                    # APIRouter per module
│   └── user.py
├── services/                   # Business logic
│   └── user_service.py
├── repositories/               # Data access
│   └── user_repository.py
├── dependencies/               # FastAPI dependencies (auth, DB session)
│   └── auth.py
├── middleware/                 # Custom middleware
├── workers/                    # Background tasks (Celery/ARQ)
├── migrations/                 # Alembic migrations
│   └── alembic.ini
├── tests/
├── .env.example
└── requirements.txt
```

## Pydantic Schema Pattern

```python
# schemas/user.py

from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

# Input: Create
class UserCreateSchema(BaseModel):
    name: str
    email: EmailStr
    password: str

# Input: Update (all optional)
class UserUpdateSchema(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None

# Output: Response
class UserResponse(BaseModel):
    id: int
    name: str
    email: str
    created_at: datetime

    class Config:
        from_attributes = True  # Pydantic v2 (was orm_mode in v1)
```

## Router Pattern

```python
# routers/user.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from core.database import get_db
from schemas.user import UserCreateSchema, UserResponse
from services import user_service

router = APIRouter(prefix="/users", tags=["Users"])

@router.get("/{user_id}", response_model=UserResponse)
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = user_service.get_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
```

## Dependency Injection

```python
# dependencies/auth.py
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer

security = HTTPBearer()

def get_current_user(token = Depends(security), db = Depends(get_db)):
    user = auth_service.verify_token(db, token.credentials)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid token")
    return user
```
