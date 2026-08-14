# Glossary: Rails (Ruby) → Node.js (Express + TypeScript + Prisma)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| Controller | Controller / Handler | `src/controllers/userController.ts` |
| Action | Controller method | `getUser`, `createUser`, etc. |
| Model | Prisma Model | Defined in `prisma/schema.prisma` |
| Serializer | DTO / Response type | Zod schema or plain TypeScript type |
| Routes | Express Router | `src/routes/user.routes.ts` |
| `before_action` | Middleware | `router.use(middleware)` |
| `after_action` | Response interceptor | Custom middleware |
| Concern | Utility / Mixin | Helper functions |
| Helper | Utility function | `src/utils/` |
| Mailer | Nodemailer wrapper | `src/mailers/` |
| Job (Sidekiq) | Bull Queue job | `src/workers/` |
| `params` | `req.params` / `req.query` / `req.body` | |
| `render json:` | `res.json(data)` | |
| `head :no_content` | `res.status(204).send()` | |
| `redirect_to` | `res.redirect(url)` | |
| ActiveRecord | Prisma Client | `prisma.user.findMany()` etc. |
| Migration | Prisma Migration | `prisma migrate dev` |
| Schema | `prisma/schema.prisma` | |
| `raise ActiveRecord::NotFound` | `res.status(404).json(...)` | |
| `current_user` | `req.user` | Set by auth middleware |
| `authenticate_user!` | Auth middleware | `router.use(authMiddleware)` |
| RSpec `describe/it` | Jest `describe/it` | Same concept |
| `expect(...).to eq(...)` | `expect(...).toBe(...)` | |
| `FactoryBot` | Fixtures or Prisma seed | |
| `ENV['KEY']` | `process.env.KEY` | |

---

## File Path Mapping

| Source (Rails) | Target (Node.js) |
|----------------|-----------------|
| `app/controllers/users_controller.rb` | `src/controllers/userController.ts` |
| `app/models/user.rb` | `prisma/schema.prisma` (model User) |
| `app/serializers/user_serializer.rb` | `src/dto/user.dto.ts` |
| `config/routes.rb` | `src/routes/user.routes.ts` |
| `app/mailers/user_mailer.rb` | `src/mailers/userMailer.ts` |
| `app/jobs/send_email_job.rb` | `src/workers/emailWorker.ts` |
| `spec/requests/users_spec.rb` | `tests/user.test.ts` |
| `config/application.rb` | `src/app.ts` |
| `config/database.yml` | `DATABASE_URL` env var |
| `db/migrate/` | `prisma/migrations/` |
| `db/seeds.rb` | `prisma/seed.ts` |

---

## HTTP Status Codes

| Scenario | Express |
|----------|---------|
| 200 OK | `res.status(200).json(data)` |
| 201 Created | `res.status(201).json(data)` |
| 204 No Content | `res.status(204).send()` |
| 400 Bad Request | `res.status(400).json({...})` |
| 401 Unauthorized | `res.status(401).json({...})` |
| 403 Forbidden | `res.status(403).json({...})` |
| 404 Not Found | `res.status(404).json({...})` |
| 409 Conflict | `res.status(409).json({...})` |
| 422 Validation | `res.status(422).json({...})` |
| 500 Server Error | `res.status(500).json({...})` |
