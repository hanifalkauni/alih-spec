# Glossary: Express.js → NestJS (TypeScript)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| `router.get(path, handler)` | `@Get(path)` on method | Decorator-based |
| `router.post(path, handler)` | `@Post(path)` | |
| Handler function | Controller method | Inside `@Controller` class |
| `app.use(middleware)` | Guard / Interceptor / Pipe | Depends on purpose |
| Auth middleware | `@UseGuards(JwtAuthGuard)` | |
| Error-handling middleware | Exception Filter | `@Catch()` |
| `req.params.id` | `@Param('id') id: string` | |
| `req.query.search` | `@Query('search') search: string` | |
| `req.body` | `@Body() dto: CreateDto` | |
| `req.headers.authorization` | `@Headers('authorization')` | |
| `req.user` | `@Request() req` → `req.user` | Set by Guard |
| `res.json(data)` | `return data` | NestJS auto-serializes |
| `res.status(201).json(data)` | `@HttpCode(201)` + `return data` | |
| `res.status(204).send()` | `@HttpCode(204)` | |
| `next(err)` | `throw new HttpException(...)` | |
| Joi/Zod validator | `class-validator` | Struct decorators |
| Sequelize | TypeORM | `@nestjs/typeorm` |
| Mongoose | Mongoose (`@nestjs/mongoose`) | Or TypeORM |
| `process.env.KEY` | `configService.get('KEY')` | `@nestjs/config` |
| `module.exports` | `export class` / `export default` | |
| `require(...)` | `import ... from '...'` | |

---

## File Path Mapping

| Source (Express) | Target (NestJS) |
|-----------------|-----------------|
| `src/routes/user.js` | `src/users/users.controller.ts` |
| `src/controllers/user.js` | `src/users/users.controller.ts` |
| `src/services/user.js` | `src/users/users.service.ts` |
| `src/models/User.js` | `src/users/entities/user.entity.ts` |
| `src/middlewares/auth.js` | `src/auth/guards/jwt-auth.guard.ts` |
| `src/validators/user.js` | `src/users/dto/create-user.dto.ts` |
| `app.js` | `src/app.module.ts` |
| `server.js` | `src/main.ts` |
| `tests/user.test.js` | `src/users/users.service.spec.ts` (unit) |
| `tests/` | `test/` (e2e) |

---

## HTTP Status Codes

| Scenario | NestJS |
|----------|--------|
| 200 OK | Default |
| 201 Created | `@HttpCode(201)` |
| 204 No Content | `@HttpCode(204)` |
| 400 Bad Request | `throw new BadRequestException()` |
| 401 Unauthorized | `throw new UnauthorizedException()` |
| 403 Forbidden | `throw new ForbiddenException()` |
| 404 Not Found | `throw new NotFoundException()` |
| 409 Conflict | `throw new ConflictException()` |
| 422 Validation | `throw new UnprocessableEntityException()` |
| 500 Server Error | `throw new InternalServerErrorException()` |
