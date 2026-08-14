# Convention Mapping: Express.js → NestJS (TypeScript)

## Naming

| Concept | Express.js | NestJS | Example |
|---------|-----------|--------|---------|
| Variables | `camelCase` | `camelCase` | Same |
| Functions | `camelCase` | `camelCase` | Same |
| Classes | `PascalCase` | `PascalCase` | Same |
| Files | `camelCase.js` or `kebab-case.js` | `kebab-case.module.ts` | NestJS uses kebab-case |
| Controllers | `userController.js` | `users.controller.ts` | plural module name |
| Services | `userService.js` | `users.service.ts` | |
| Modules | — | `users.module.ts` | NestJS specific |
| DTOs | `userValidator.js` | `create-user.dto.ts` | |
| Entities | `User.js` (Sequelize) | `user.entity.ts` | |
| Guards | `authMiddleware.js` | `auth.guard.ts` | |
| Interceptors | `responseMiddleware.js` | `transform.interceptor.ts` | |

## File Structure

| Express.js | NestJS | Notes |
|-----------|--------|-------|
| `routes/user.js` | `users/users.controller.ts` | |
| `services/user.js` | `users/users.service.ts` | |
| `models/User.js` | `users/entities/user.entity.ts` | |
| `middlewares/auth.js` | `auth/guards/auth.guard.ts` | |
| `app.js` | `app.module.ts` | |
| `server.js` | `main.ts` | |

## Target Project Structure (NestJS)

```
output/
├── src/
│   ├── main.ts                         # Bootstrap
│   ├── app.module.ts                   # Root module
│   ├── app.controller.ts
│   │
│   ├── auth/                           # Auth module
│   │   ├── auth.module.ts
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── guards/
│   │   │   └── jwt-auth.guard.ts
│   │   └── strategies/
│   │       └── jwt.strategy.ts
│   │
│   ├── users/                          # Users module (feature module pattern)
│   │   ├── users.module.ts
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   ├── entities/
│   │   │   └── user.entity.ts
│   │   └── dto/
│   │       ├── create-user.dto.ts
│   │       └── update-user.dto.ts
│   │
│   ├── common/                         # Shared utilities
│   │   ├── decorators/
│   │   ├── filters/
│   │   │   └── http-exception.filter.ts
│   │   ├── interceptors/
│   │   │   └── transform.interceptor.ts
│   │   └── pipes/
│   │
│   └── config/                         # Config module
│       └── config.module.ts
│
├── test/
├── .env.example
├── nest-cli.json
├── package.json
└── tsconfig.json
```

## Controller Pattern (NestJS)

```typescript
// users/users.controller.ts
import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common'
import { UsersService } from './users.service'
import { CreateUserDto } from './dto/create-user.dto'
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard'

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(+id)
  }

  @Post()
  create(@Body() dto: CreateUserDto) {
    return this.usersService.create(dto)
  }
}
```

## DTO Pattern (class-validator)

```typescript
// users/dto/create-user.dto.ts
import { IsEmail, IsString, MinLength, MaxLength, IsNotEmpty } from 'class-validator'

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(2)
  @MaxLength(100)
  name: string

  @IsEmail()
  email: string

  @IsString()
  @MinLength(8)
  password: string
}
```

## Response Transform Interceptor

```typescript
// common/interceptors/transform.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common'
import { Observable } from 'rxjs'
import { map } from 'rxjs/operators'

@Injectable()
export class TransformInterceptor<T> implements NestInterceptor<T, any> {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      map(data => ({ success: true, data }))
    )
  }
}
```
