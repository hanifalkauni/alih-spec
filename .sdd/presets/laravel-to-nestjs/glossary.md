# Glossary: Laravel (PHP) → NestJS (TypeScript)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| Controller | Controller | `@Controller()` di `src/[module]/[module].controller.ts` |
| Service | Service | `@Injectable()` di `src/[module]/[module].service.ts` |
| Repository | Repository | TypeORM repository di service |
| Model | Entity | `@Entity()` di `src/[module]/entities/[entity].entity.ts` |
| Form Request | DTO (Create/Update) | `class-validator` DTO |
| API Resource | Response DTO | Separate response class atau `ClassSerializerInterceptor` |
| Middleware | Guard / Interceptor / Pipe | Tergantung tujuan |
| Auth Middleware | Guard (`@UseGuards()`) | |
| Job | Queue Job (Bull) | `@nestjs/bull` |
| Event | EventEmitter Event | `@nestjs/event-emitter` |
| Listener | `@OnEvent()` handler | |
| Service Provider | Module (`@Module()`) | NestJS module system |
| Service Container | NestJS DI | Built-in, otomatis |
| Eloquent ORM | TypeORM | `@nestjs/typeorm` |
| Migration | TypeORM Migration | Auto-generated |
| Seeder | Seeder class | `@nestjs/typeorm` seeder |
| `$this` | `this` | Same in TypeScript |
| `throw new Exception()` | `throw new HttpException()` | NestJS HTTP exceptions |
| `abort(404)` | `throw new NotFoundException()` | |
| `response()->json()` | `return data` (auto) | NestJS auto-serializes |
| `$request->validate()` | `@Body() dto: CreateDto` + `ValidationPipe` | |
| `Auth::user()` | `@CurrentUser()` decorator | Custom decorator |
| `config('key')` | `configService.get('key')` | `@nestjs/config` |

---

## File Path Mapping

| Source (Laravel) | Target (NestJS) |
|-----------------|-----------------|
| `app/Http/Controllers/UserController.php` | `src/users/users.controller.ts` |
| `app/Services/UserService.php` | `src/users/users.service.ts` |
| `app/Models/User.php` | `src/users/entities/user.entity.ts` |
| `app/Http/Requests/CreateUserRequest.php` | `src/users/dto/create-user.dto.ts` |
| `app/Http/Resources/UserResource.php` | `src/users/dto/user-response.dto.ts` |
| `app/Http/Middleware/AuthMiddleware.php` | `src/auth/guards/jwt-auth.guard.ts` |
| `app/Jobs/SendEmailJob.php` | `src/email/email.processor.ts` |
| `app/Events/UserCreated.php` | `src/users/events/user-created.event.ts` |
| `app/Providers/AppServiceProvider.php` | `src/app.module.ts` |
| `routes/api.php` | Routes via `@Controller` + `@Get/@Post/etc` |
| `database/migrations/` | `src/migrations/` (TypeORM) |
| `config/*.php` | `src/config/` + `@nestjs/config` |
| `tests/` | `test/` (e2e) + `*.spec.ts` (unit) |

---

## HTTP Status Codes

| Scenario | NestJS Exception |
|----------|-----------------|
| 400 Bad Request | `BadRequestException` |
| 401 Unauthorized | `UnauthorizedException` |
| 403 Forbidden | `ForbiddenException` |
| 404 Not Found | `NotFoundException` |
| 409 Conflict | `ConflictException` |
| 422 Validation Error | `UnprocessableEntityException` |
| 500 Server Error | `InternalServerErrorException` |
