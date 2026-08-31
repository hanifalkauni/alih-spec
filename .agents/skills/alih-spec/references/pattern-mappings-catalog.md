# 🗺️ Cross-Stack Design Pattern Mappings Catalog

Master architectural translation dictionary for AI Agents converting applications across major programming languages and web frameworks.

---

## 📑 1. Architectural Concept Mapping Matrix

| Architectural Layer | Laravel (PHP) | Django (Python) | Express / Node | Spring Boot (Java) | Target: Go (Clean Arch) | Target: NestJS (TS) | Target: FastAPI (Python) |
|---|---|---|---|---|---|---|---|
| **HTTP Delivery** | Controller | Views / ViewSets | Route Handler | `@RestController` | `internal/handler` | `*.controller.ts` | `routers/*.py` |
| **Request Validation** | FormRequest / `$request->validate()` | Django Forms / DRF Serializers | Joi / Zod / express-validator | `@Valid` DTO | DTO struct + `validator/v10` | DTO class + `class-validator` | Pydantic `BaseModel` |
| **Business Logic** | Service / Action / Job | Service / Business Layer | Service / UseCase | `@Service` Class | `internal/service` / UseCase | `*.service.ts` | `services/*.py` |
| **Data Access (ORM)** | Eloquent Model | Django ORM Models | Prisma / TypeORM / Mongoose | Spring Data JPA / Hibernate | `internal/repository` + GORM | `*.repository.ts` + Prisma | `repositories/*.py` + SQLAlchemy |
| **Domain Entities** | Model Class | Model Class | Interface / Entity Class | `@Entity` POJO | `internal/domain` (Structs) | `*.entity.ts` | `models/*.py` |
| **Routing / Middleware** | `routes/api.php` + Middleware | `urls.py` + Middleware | `app.use()` Middleware | `@Component` Filter / Interceptor | Fiber / Gin Middleware | NestJS Guards / Interceptors | FastAPI Dependencies / Middleware |
| **Database Migrations** | `database/migrations/` | `manage.py makemigrations` | `prisma migrate` / `typeorm migration` | Flyway / Liquibase | `golang-migrate` / GORM AutoMigrate | Prisma Migrate | Alembic Migrations |

---

## 🔄 2. Laravel Eloquent ➔ Go GORM Query Translation

| Laravel Eloquent / Query Builder | Go GORM Equivalent Syntax | Critical Architectural Notes |
|---|---|---|
| `$user = User::find($id);` | `db.First(&user, id)` | Check `errors.Is(err, gorm.ErrRecordNotFound)` |
| `$users = User::where('status', 'active')->get();` | `db.Where("status = ?", "active").Find(&users)` | Slices must be initialized (`users := []User{}`) |
| `$user = User::where('email', $email)->first();` | `db.Where("email = ?", email).First(&user)` | Returns single pointer or value |
| `$query->whereDate('created_at', '>=', $today);` | `db.Where("created_at >= ?", today)` | Pass formatted `"YYYY-MM-DD"` string |
| `$query->selectRaw('COALESCE(SUM(amount), 0) as total');` | `db.Select("COALESCE(SUM(amount), 0)").Scan(&total)` | Use `.Scan(&total)` for aggregates |
| `$query->groupBy('status')->having('total', '>', 10);` | `db.Group("status").Having("total > ?", 10)` | Use `.Group()` and `.Having()` |
| `$query->leftJoin('orders', 'orders.user_id', '=', 'users.id');` | `db.Joins("LEFT JOIN orders ON orders.user_id = users.id")` | Include `AND orders.deleted_at IS NULL` for soft deletes |
| `DB::transaction(function() { ... });` | `db.Transaction(func(tx *gorm.DB) error { ... })` | Atomic rollback on returned error |
| `$wallet->lockForUpdate()->first();` | `tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&wallet)` | Pessimistic locking for financial mutations |
| `$users = User::paginate(15);` | `db.Limit(limit).Offset(offset).Find(&users)` | Calculate `offset = (page - 1) * per_page` |

---

## 🐍 3. Django / DRF ➔ FastAPI SQLAlchemy Translation

| Django / DRF Pattern | FastAPI + SQLAlchemy 2.0 Equivalent | Critical Architectural Notes |
|---|---|---|
| `User.objects.filter(is_active=True)` | `select(User).where(User.is_active == True)` | SQLAlchemy 2.0 executable select statement |
| `UserSerializer(data=request.data)` | `UserCreateSchema.model_validate(payload)` | Pydantic v2 validation |
| `@transaction.atomic` | `async with session.begin():` | Async transaction context manager |
| `select_related('profile')` | `options(joinedload(User.profile))` | Eager loading to prevent N+1 query |
| `F('balance') - amount` | `User.balance - amount` (Atomic expression) | Prevents race condition in updates |

---

## 🟢 4. Express / Node.js ➔ NestJS TypeScript Translation

| Express Pattern | NestJS Equivalent | Critical Architectural Notes |
|---|---|---|
| `router.post('/login', handler)` | `@Post('login') @HttpCode(HttpStatus.OK)` | Declarative route decorators |
| `req.body` with manual Joi validate | `@Body() dto: LoginDto` with `ValidationPipe` | Class-validator decorators (`@IsEmail()`) |
| `authMiddleware(req, res, next)` | `@UseGuards(JwtAuthGuard)` | Extensible Execution Context Guard |
| `prisma.user.findUnique(...)` | Injected `UserRepository` or `PrismaService` | Dependency Injection via Constructor |
| `res.status(422).json({ errors })` | `throw new UnprocessableEntityException(errors)` | Built-in HTTP Exception filters |
