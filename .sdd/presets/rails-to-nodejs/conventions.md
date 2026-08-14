# Convention Mapping: Ruby on Rails → Node.js (Express + TypeScript + Prisma)

## Naming

| Concept | Rails (Ruby) | Node.js (TypeScript) | Example |
|---------|-------------|----------------------|---------|
| Variables | `snake_case` | `camelCase` | `user_name` → `userName` |
| Functions | `snake_case` | `camelCase` | `get_user_by_id` → `getUserById` |
| Classes | `PascalCase` | `PascalCase` | `UserController` |
| Constants | `UPPER_SNAKE` | `UPPER_SNAKE` | `MAX_RETRY` |
| Files | `snake_case.rb` | `camelCase.ts` or `kebab-case.ts` | `user_controller.rb` → `userController.ts` |
| DB tables | `snake_case` (plural) | `snake_case` (Prisma auto) | `users` |
| DB columns | `snake_case` | `camelCase` (Prisma maps) | `created_at` → `createdAt` |
| JSON keys | `snake_case` | `camelCase` | `"user_id"` → `"userId"` |

## File Structure

| Rails | Node.js + Express | Notes |
|-------|------------------|-------|
| `app/controllers/users_controller.rb` | `src/controllers/userController.ts` | |
| `app/models/user.rb` | `prisma/schema.prisma` (model User) | |
| `app/serializers/user_serializer.rb` | `src/dto/user.dto.ts` | |
| `config/routes.rb` | `src/routes/user.routes.ts` | |
| `spec/requests/users_spec.rb` | `tests/user.test.ts` | |

## Target Project Structure

```
output/
├── src/
│   ├── app.ts                  # Express app setup
│   ├── server.ts               # Entry point
│   ├── routes/                 # Express routers
│   │   ├── index.ts
│   │   └── user.routes.ts
│   ├── controllers/            # Request handlers
│   │   └── user.controller.ts
│   ├── services/               # Business logic
│   │   └── user.service.ts
│   ├── repositories/           # Data access (Prisma)
│   │   └── user.repository.ts
│   ├── dto/                    # Request/Response types (Zod)
│   │   └── user.dto.ts
│   ├── middleware/             # Express middleware
│   │   ├── auth.ts
│   │   └── errorHandler.ts
│   ├── utils/                  # Utilities
│   └── types/                  # TypeScript type definitions
├── prisma/
│   ├── schema.prisma           # Database schema
│   └── migrations/             # Auto-generated migrations
├── tests/
├── .env.example
├── package.json
└── tsconfig.json
```

## Controller Pattern

```typescript
// src/controllers/user.controller.ts
import { Request, Response, NextFunction } from 'express'
import { userService } from '../services/user.service'
import { createUserSchema } from '../dto/user.dto'

export const getUser = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const user = await userService.getById(Number(req.params.id))
    if (!user) return res.status(404).json({ success: false, message: 'User not found' })
    res.json({ success: true, data: user })
  } catch (err) {
    next(err)
  }
}
```

## DTO Pattern (Zod)

```typescript
// src/dto/user.dto.ts
import { z } from 'zod'

export const createUserSchema = z.object({
  name: z.string().min(2).max(100),
  email: z.string().email(),
  password: z.string().min(8),
})

export type CreateUserDto = z.infer<typeof createUserSchema>

export type UserResponse = {
  id: number
  name: string
  email: string
  createdAt: Date
}
```

## Prisma Schema Convention

```prisma
model User {
  id        Int       @id @default(autoincrement())
  name      String    @db.VarChar(100)
  email     String    @unique
  password  String
  createdAt DateTime  @default(now())
  updatedAt DateTime  @updatedAt
  deletedAt DateTime? // Soft delete

  posts Post[]
}
```
