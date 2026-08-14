# Convention Mapping: Laravel (PHP) → NestJS (TypeScript)

## Naming

| Concept | PHP/Laravel | NestJS (TypeScript) | Example |
|---------|------------|---------------------|---------|
| Variables | `$camelCase` | `camelCase` | `$userId` → `userId` |
| Functions | `camelCase` | `camelCase` | Same pattern |
| Classes | `PascalCase` | `PascalCase` | `UserController` |
| Constants | `UPPER_SNAKE` | `UPPER_SNAKE` | Same |
| Files | `UserController.php` | `users.controller.ts` | kebab-case, plural |
| Namespaces | `App\Http\Controllers` | Module-based | `UsersModule` |
| DB tables | `snake_case` | `snake_case` | `users` |
| DB columns | `snake_case` | `snake_case` | `created_at` |
| JSON keys | `snake_case` | `camelCase` | `"user_id"` → `"userId"` |

## File Naming Rules

| Laravel | NestJS | Notes |
|---------|--------|-------|
| `UserController.php` | `users.controller.ts` | plural, kebab-case |
| `UserService.php` | `users.service.ts` | |
| `User.php` (Model) | `user.entity.ts` | singular entity |
| `UserRequest.php` | `create-user.dto.ts` | action-prefixed DTO |
| `UserResource.php` | `user-response.dto.ts` | response DTO |
| `AuthController.php` | `auth.controller.ts` | |

## Target Project Structure (NestJS)

```
output/
├── src/
│   ├── main.ts
│   ├── app.module.ts
│   │
│   ├── auth/
│   │   ├── auth.module.ts
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── dto/
│   │   │   ├── login.dto.ts
│   │   │   └── register.dto.ts
│   │   └── guards/
│   │       └── jwt-auth.guard.ts
│   │
│   ├── users/
│   │   ├── users.module.ts
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   ├── entities/
│   │   │   └── user.entity.ts
│   │   └── dto/
│   │       ├── create-user.dto.ts
│   │       └── update-user.dto.ts
│   │
│   └── common/
│       ├── decorators/
│       │   └── current-user.decorator.ts
│       ├── filters/
│       │   └── http-exception.filter.ts
│       └── interceptors/
│           └── transform.interceptor.ts
│
├── test/
├── .env.example
├── nest-cli.json
├── package.json
└── tsconfig.json
```

## Entity Pattern (TypeORM)

```typescript
// users/entities/user.entity.ts
import {
  Entity, PrimaryGeneratedColumn, Column,
  CreateDateColumn, UpdateDateColumn, DeleteDateColumn
} from 'typeorm'
import { Exclude } from 'class-transformer'

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number

  @Column({ length: 100 })
  name: string

  @Column({ unique: true })
  email: string

  @Column()
  @Exclude()                          // Hidden from responses (like $hidden in Laravel)
  password: string

  @CreateDateColumn()
  createdAt: Date

  @UpdateDateColumn()
  updatedAt: Date

  @DeleteDateColumn()
  deletedAt: Date                     // Soft delete (like softDeletes() in Laravel)
}
```

## DTO Pattern

```typescript
// users/dto/create-user.dto.ts
import { IsEmail, IsString, IsNotEmpty, MinLength, MaxLength } from 'class-validator'

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

## Module Pattern

```typescript
// users/users.module.ts
import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { UsersController } from './users.controller'
import { UsersService } from './users.service'
import { User } from './entities/user.entity'

@Module({
  imports: [TypeOrmModule.forFeature([User])],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService],            // Export if other modules need it
})
export class UsersModule {}
```

## Response Format

```typescript
// common/interceptors/transform.interceptor.ts
// Wraps all responses in: { success: true, data: ... }
// Mirrors Laravel's API Resource structure
```
