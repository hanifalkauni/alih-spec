# Glossary: Express.js ➔ Go (Gin / Fiber + GORM)

## 1. Padanan Istilah & Konsep

| Express.js / Node.js Term | Go (Gin / GORM) Term | Penjelasan |
|---|---|---|
| Controller (`req, res`) | Handler (`c *gin.Context`) | Fungsi penerima HTTP request |
| `app.use()` | `r.Use()` | Pemasangan middleware global atau group |
| `req.params` | `c.Param()` | URL parameter path |
| `req.query` | `c.Query()` | URL query parameter |
| `req.body` | `c.ShouldBindJSON(&dto)` | Parsing payload request body |
| `res.status(200).json(...)` | `c.JSON(200, ...)` | Response payload JSON |
| `res.status(404).send(...)` | `c.AbortWithStatusJSON(404, ...)` | Error response |
| Zod / Joi Schema | Struct Tag `validate:"..."` | Validasi input data |
| Prisma / Sequelize / TypeORM | GORM / SQLX | Abstraksi interaksi database |
| `package.json` & `npm` / `pnpm` | `go.mod` & `go mod tidy` | Package & dependency manager |
| `npm run dev` (`nodemon` / `tsx`) | `air` / `go run cmd/server/main.go` | Hot-reloading & dev server |
