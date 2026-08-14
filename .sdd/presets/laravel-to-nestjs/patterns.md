# Pattern Mapping: Laravel (PHP) → NestJS (TypeScript)

## Application Layer

| Source (Laravel) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `app/Http/Controllers/` | `src/[module]/[module].controller.ts` | |
| `app/Services/` | `src/[module]/[module].service.ts` | |
| `app/Repositories/` | `src/[module]/[module].repository.ts` | |
| `app/Models/` | `src/[module]/entities/[entity].entity.ts` | TypeORM entity |
| `app/Http/Requests/` | `src/[module]/dto/create-[module].dto.ts` | class-validator |
| `app/Http/Resources/` | Response DTOs or Serializer | |
| `app/Http/Middleware/` | Guards / Interceptors | |
| `app/Jobs/` | `src/[module]/workers/` | Bull queue |
| `app/Events/` | NestJS EventEmitter | |
| `app/Listeners/` | `@OnEvent(...)` handlers | |
| `app/Providers/` | NestJS Modules | |
| `app/Exceptions/` | Custom exception filters | |
| `routes/api.php` | `src/[module]/[module].controller.ts` routes | Via decorators |

## Routing

| Source (Laravel) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `Route::get('/users', ...)` | `@Get()` on controller method | |
| `Route::post('/users', ...)` | `@Post()` | |
| `Route::put('/users/{id}', ...)` | `@Put(':id')` | |
| `Route::delete('/users/{id}', ...)` | `@Delete(':id')` | |
| `Route::group(['prefix'=>'v1'], ...)` | `@Controller('v1/users')` | |
| `Route::middleware(['auth:sanctum'])` | `@UseGuards(JwtAuthGuard)` | |
| `Route::resource('users', ...)` | Full controller with all methods | |
| `{id}` parameter | `@Param('id') id: string` | |

## ORM (Eloquent → TypeORM)

| Source (Eloquent) | Target (TypeORM) | Notes |
|------------------|------------------|-------|
| `Model::find($id)` | `repository.findOneBy({id})` | |
| `Model::all()` | `repository.find()` | |
| `Model::where(...)->get()` | `repository.find({where: {...}})` | |
| `Model::where(...)->first()` | `repository.findOne({where: {...}})` | |
| `Model::create($data)` | `repository.save(repository.create(data))` | |
| `$model->update($data)` | `repository.save({...model, ...data})` | |
| `$model->delete()` | `repository.remove(model)` | |
| `Model::with('relation')` | `relations: ['relation']` | |
| `$table->timestamps()` | `@CreateDateColumn()` + `@UpdateDateColumn()` | |
| `$table->softDeletes()` | `@DeleteDateColumn()` + `@SoftDelete()` | |
| `protected $fillable` | TypeORM uses DTOs + `create()` | |
| `protected $hidden` | `@Exclude()` from class-transformer | |
| `paginate($n)` | Manual skip/take | |

## Authentication

| Source (Laravel/Sanctum) | Target (NestJS) | Notes |
|------------------------|-----------------|-------|
| `Auth::user()` | `@CurrentUser()` custom decorator | |
| `auth('sanctum')` middleware | `@UseGuards(JwtAuthGuard)` | |
| `bcrypt($password)` | `bcryptjs.hash(password, 10)` | |
| `Hash::check($pass, $hash)` | `bcryptjs.compare(pass, hash)` | |
| `request()->user()` | `@Request() req` → `req.user` | |
| Token generation | `JwtService.sign(payload)` | `@nestjs/jwt` |

## Validation

| Source (Laravel) | Target (NestJS + class-validator) | Notes |
|-----------------|----------------------------------|-------|
| `required` | `@IsNotEmpty()` | |
| `string` | `@IsString()` | |
| `email` | `@IsEmail()` | |
| `min:8` | `@MinLength(8)` | |
| `max:255` | `@MaxLength(255)` | |
| `nullable` | `@IsOptional()` + `T \| null` | |
| `confirmed` | `@Match('password')` custom | |
| `in:a,b,c` | `@IsIn(['a','b','c'])` | |
| `integer` | `@IsInt()` | |
| `boolean` | `@IsBoolean()` | |
| `array` | `@IsArray()` | |
| `unique:table,col` | Custom validator + DB check | |

## HTTP Response

| Source (Laravel) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `response()->json($data, 200)` | `return data` (auto 200) | |
| `response()->json($data, 201)` | `@HttpCode(201)` + `return data` | |
| `response()->noContent()` | `@HttpCode(204)` | |
| `abort(404)` | `throw new NotFoundException()` | |
| `abort(401)` | `throw new UnauthorizedException()` | |
| `abort(403)` | `throw new ForbiddenException()` | |
| `abort(409)` | `throw new ConflictException()` | |
| `abort(422)` | `throw new UnprocessableEntityException()` | |

## Dependency Injection

| Source (Laravel) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| Service Container | NestJS DI (built-in) | Both use DI |
| `__construct(UserService $svc)` | `constructor(private userService: UsersService)` | |
| Service Providers | `@Module({ providers: [...] })` | |
| Singleton binding | Default NestJS behavior | |
| `app()->make(Class::class)` | NestJS auto-resolves via module | |

## Testing

| Source (Laravel) | Target (NestJS + Jest) | Notes |
|-----------------|----------------------|-------|
| PHPUnit | Jest | |
| `$this->get('/api/users')` | `request(app.getHttpServer()).get('/users')` | supertest |
| `$this->assertStatus(200)` | `.expect(200)` | |
| `$this->assertJson([...])` | `.expect(res => expect(res.body).toMatchObject(...))` | |
| Factories | Fixtures or `TypeORM Factory` | |
| `RefreshDatabase` | `beforeEach` cleanup | |
| Mockery | `jest.fn()` / `Test.createTestingModule` | |
