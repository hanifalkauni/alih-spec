# Pattern Mapping: Laravel (PHP) ➔ FastAPI (Python)

> Panduan pemetaan arsitektur dan sintaks dari PHP (Laravel) ke Python (FastAPI + Pydantic v2 + SQLAlchemy 2.0 Async).

---

## 1. Application Layer

| Source (Laravel) | Target (FastAPI) | Notes |
|---|---|---|
| `app/Http/Controllers/` | `app/api/v1/endpoints/` atau `app/routers/` | FastAPI APIRouter endpoints |
| `app/Services/` | `app/services/` | Business logic functions / classes |
| `app/Models/` | `app/models/` | SQLAlchemy Base Models (`mapped_column`) |
| `app/Http/Requests/` | `app/schemas/` | Pydantic Request Models (`BaseModel`) |
| `app/Http/Resources/` | `app/schemas/` | Pydantic Response Models (`model_validate`) |
| `app/Http/Middleware/` | `app/core/middleware.py` atau `Depends()` | Dependency Injection / Middleware |
| `routes/api.php` | `app/api/v1/api.py` | Router aggregation |
| `.env` & `config/` | `app/core/config.py` | `pydantic-settings` (`BaseSettings`) |
| `database/migrations/` | `alembic/versions/` | Alembic DB migrations |

---

## 2. Routing & Controllers

| Source (Laravel) | Target (FastAPI) | Notes |
|---|---|---|
| `Route::get('/users', [UserController::class, 'index'])` | `@router.get("/users", response_model=list[UserResponse])` | Explicit response schema |
| `Route::post('/users', [UserController::class, 'store'])` | `@router.post("/users", status_code=status.HTTP_201_CREATED)` | Status code deklaratif |
| `Route::get('/users/{id}', ...)` | `@router.get("/users/{user_id}")` | Path parameter |
| `Route::put('/users/{id}', ...)` | `@router.put("/users/{user_id}")` | Update endpoint |
| `Route::delete('/users/{id}', ...)` | `@router.delete("/users/{user_id}", status_code=204)` | Delete endpoint |
| `Route::prefix('api/v1')->group(...)` | `api_router.include_router(users_router, prefix="/users", tags=["users"])` | Nested APIRouter |
| `$request->query('page', 1)` | `page: int = Query(default=1, ge=1)` | FastAPI `Query()` parameters |
| `$request->input('name')` | `data: UserCreateSchema` | Request body parsing via Pydantic |

---

## 3. ORM & Database (Eloquent ➔ SQLAlchemy 2.0 Async)

| Source (Eloquent) | Target (SQLAlchemy 2.0 Async) | Notes |
|---|---|---|
| `User::all()` | `result = await db.execute(select(User)); result.scalars().all()` | Async query |
| `User::find($id)` | `await db.get(User, user_id)` | Get by Primary Key |
| `User::where('email', $email)->first()` | `result = await db.execute(select(User).where(User.email == email)); result.scalar_one_or_none()` | Filter single record |
| `User::create($data)` | `user = User(**data); db.add(user); await db.commit(); await db.refresh(user)` | Insert new entity |
| `$user->update($data)` | `for k, v in data.items(): setattr(user, k, v); await db.commit()` | Update entity |
| `$user->delete()` | `await db.delete(user); await db.commit()` | Delete record |
| `$user->posts` (Relationship) | `select(User).options(selectinload(User.posts))` | Eager loading relasi |
| `DB::transaction(function() { ... })` | `async with db.begin(): ...` | Async transaction block |
| `User::paginate(15)` | `offset = (page - 1) * limit; select(User).offset(offset).limit(limit)` | Pagination query |

---

## 4. Validasi Data (FormRequest ➔ Pydantic v2)

| Source (Laravel Validation) | Target (Pydantic v2) | Notes |
|---|---|---|
| `'email' => 'required|email'` | `email: EmailStr` | Built-in email validation |
| `'name' => 'required|min:3|max:100'` | `name: str = Field(min_length=3, max_length=100)` | Field constraint |
| `'age' => 'nullable|integer|min:18'` | `age: int | None = Field(default=None, ge=18)` | Nullable int |
| `'role' => 'in:admin,user'` | `role: Literal["admin", "user"]` atau `Enum` | Enum restriction |
| Custom Validation Rule | `@field_validator('phone')` | Pydantic field validator decorator |

---

## 5. Autentikasi & Authorization (Sanctum ➔ FastAPI Security + PyJWT)

| Source (Laravel) | Target (FastAPI) | Notes |
|---|---|---|
| `auth('sanctum')->user()` | `current_user: User = Depends(get_current_user)` | Injeksi user via FastAPI `Depends()` |
| `Auth::id()` | `current_user.id` | User ID dari JWT payload |
| `Hash::make($password)` | `pwd_context.hash(password)` | `passlib[bcrypt]` / `pwdlib` |
| `Hash::check($pass, $hash)` | `pwd_context.verify(plain, hashed)` | Verifikasi hash password |
| `auth:sanctum` middleware | `OAuth2PasswordBearer` + JWT Decoder | Dependency-based security |
