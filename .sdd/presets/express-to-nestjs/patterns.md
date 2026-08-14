# Pattern Mapping: Express.js → NestJS (TypeScript)

## Application Layer

| Source (Express.js) | Target (NestJS) | Notes |
|--------------------|-----------------|-------|
| `router.get()` | `@Get()` decorator | |
| `router.post()` | `@Post()` decorator | |
| `router.put()` | `@Put()` decorator | |
| `router.delete()` | `@Delete()` decorator | |
| `app.use(middleware)` | `app.use()` or Guard/Interceptor | |
| Handler function | `@Controller` method | |
| `req.params.id` | `@Param('id')` | |
| `req.query.search` | `@Query('search')` | |
| `req.body` | `@Body()` | |
| `req.headers.authorization` | `@Headers('authorization')` | |
| `res.json(data)` | `return data` | NestJS auto-serializes |
| `res.status(201).json(data)` | `@HttpCode(201)` + `return data` | |
| `next(err)` | `throw new HttpException(...)` | |
| Custom middleware | Guard / Interceptor / Pipe | |
| Auth middleware | `@UseGuards(AuthGuard)` | |

## Module Structure

| Source (Express) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `routes/user.js` | `users/users.controller.ts` | |
| `controllers/user.js` | `users/users.controller.ts` | |
| `services/user.js` | `users/users.service.ts` | |
| `models/user.js` | `users/entities/user.entity.ts` | TypeORM entity |
| `middlewares/auth.js` | `auth/auth.guard.ts` | |
| `validators/user.js` | `users/dto/create-user.dto.ts` | class-validator |
| `app.js` | `app.module.ts` | |
| `server.js` | `main.ts` | |

## ORM (Sequelize/Mongoose → TypeORM)

| Source (Sequelize) | Target (TypeORM) | Notes |
|-------------------|-----------------|-------|
| `Model.findByPk(id)` | `repository.findOneBy({id})` | |
| `Model.findAll()` | `repository.find()` | |
| `Model.findOne({where:...})` | `repository.findOneBy(...)` | |
| `Model.create({...})` | `repository.save(entity)` | |
| `instance.update({...})` | `repository.save({...id, ...data})` | |
| `instance.destroy()` | `repository.remove(entity)` | |
| `Model.count()` | `repository.count()` | |
| `include: [Model]` | `relations: ['relation']` | |
| `where: { [Op.like]: '%q%' }` | `Like('%q%')` | TypeORM operator |
| `order: [['createdAt', 'DESC']]` | `order: {createdAt: 'DESC'}` | |
| `limit: 10, offset: 20` | `take: 10, skip: 20` | |

## Authentication

| Source (Express) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `passport-jwt` middleware | `@nestjs/passport` + `passport-jwt` | |
| `jwt.verify(token, secret)` | `JwtService.verify()` | `@nestjs/jwt` |
| Auth middleware on route | `@UseGuards(JwtAuthGuard)` | |
| `req.user` | `@Request() req` → `req.user` | |
| `bcryptjs.hash(pass)` | `bcryptjs.hash(pass)` | Same |

## Validation

| Source (Express + Joi/Yup) | Target (NestJS + class-validator) | Notes |
|---------------------------|----------------------------------|-------|
| `Joi.string().required()` | `@IsString() @IsNotEmpty()` | |
| `Joi.string().email()` | `@IsEmail()` | |
| `Joi.number().min(0)` | `@IsNumber() @Min(0)` | |
| `Joi.string().min(8)` | `@MinLength(8)` | |
| `Joi.string().max(100)` | `@MaxLength(100)` | |
| `Joi.boolean()` | `@IsBoolean()` | |
| `Joi.array()` | `@IsArray()` | |
| `Joi.optional()` | `@IsOptional()` | |
| Validation middleware | `ValidationPipe` (global) | |

## HTTP Exceptions

| Source (Express) | Target (NestJS) | Notes |
|-----------------|-----------------|-------|
| `res.status(404).json({msg})` | `throw new NotFoundException(msg)` | |
| `res.status(401).json({msg})` | `throw new UnauthorizedException(msg)` | |
| `res.status(403).json({msg})` | `throw new ForbiddenException(msg)` | |
| `res.status(400).json({msg})` | `throw new BadRequestException(msg)` | |
| `res.status(409).json({msg})` | `throw new ConflictException(msg)` | |
| `res.status(422).json({msg})` | `throw new UnprocessableEntityException(msg)` | |
| `res.status(500).json({msg})` | `throw new InternalServerErrorException(msg)` | |

## Testing

| Source (Express + Jest) | Target (NestJS + Jest) | Notes |
|------------------------|----------------------|-------|
| `supertest(app).get(...)` | `app.get(route).expect(200)` | e2e test |
| Manual mock | `jest.mock(...)` or NestJS Test | |
| `beforeAll(async () => {...})` | `beforeAll(async () => {...})` | Same |
| `app.listen()` | `TestingModule` | |
| Unit test service | `Test.createTestingModule(...)` | |
