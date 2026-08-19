# Pattern Mapping: Express.js (Node.js) ➔ Go (Gin / Fiber + GORM)

> Panduan migrasi backend microservices & REST API dari Express.js (JavaScript/TypeScript) ke Golang (Gin/Fiber + GORM Clean Architecture).

---

## 1. Application Layer & Router

| Source (Express.js) | Target (Go / Gin) | Notes |
|---|---|---|
| `const app = express()` | `r := gin.Default()` | Router instance initialization |
| `app.use(express.json())` | Built-in di Gin (`c.ShouldBindJSON`) | Parsing request body |
| `app.use(cors())` | `r.Use(cors.New(...))` | CORS middleware |
| `app.use('/api/v1/users', userRoutes)` | `v1 := r.Group("/api/v1/users")` | Route group grouping |
| `router.get('/', getUser)` | `v1.GET("", h.GetUser)` | Route registration |
| `router.post('/', createUser)` | `v1.POST("", h.CreateUser)` | |
| `router.put('/:id', updateUser)` | `v1.PUT("/:id", h.UpdateUser)` | URL param `:id` |
| `router.delete('/:id', deleteUser)` | `v1.DELETE("/:id", h.DeleteUser)` | |
| `req.params.id` | `c.Param("id")` | Ambil URL param |
| `req.query.search` | `c.Query("search")` | Ambil query string |
| `req.body` | `c.ShouldBindJSON(&dto)` | Unmarshal JSON payload ke struct |
| `req.headers['authorization']` | `c.GetHeader("Authorization")` | Header inspection |

---

## 2. Middleware & Error Handling

| Source (Express.js) | Target (Go) | Notes |
|---|---|---|
| `const authMiddleware = (req, res, next) => { ... next() }` | `func AuthMiddleware() gin.HandlerFunc { return func(c *gin.Context) { ... c.Next() } }` | Gin Middleware closure pattern |
| `next(error)` | `c.Error(err)` & `c.AbortWithStatusJSON(500, ...)` | Abort execution chain |
| `req.user = decodedUser; next();` | `c.Set("user", decodedUser); c.Next()` | Simpan context value antar middleware |
| Global error handler `(err, req, res, next) => { ... }` | Custom Error Middleware / Recovery wrapper | Tangkap error terpusat |

---

## 3. ORM & Data Layer (Prisma / Mongoose / Sequelize ➔ GORM)

| Source (Prisma / Sequelize) | Target (GORM) | Notes |
|---|---|---|
| `prisma.user.findMany()` | `db.Find(&users)` | Ambil semua baris |
| `prisma.user.findUnique({ where: { id } })` | `db.First(&user, id)` | Single record by primary key |
| `prisma.user.create({ data: { ... } })` | `db.Create(&user)` | Insert record baru |
| `prisma.user.update({ where: { id }, data })` | `db.Model(&user).Updates(data)` | Update record |
| `prisma.user.delete({ where: { id } })` | `db.Delete(&user, id)` | Delete record |
| `prisma.user.findMany({ include: { posts: true } })` | `db.Preload("Posts").Find(&users)` | Eager loading relasi |
| `prisma.$transaction([ ... ])` | `tx := db.Begin(); ... tx.Commit()` | Database transaction |
| Async/Await (`await db...`) | Synchronous Goroutines | Go menggunakan blocking I/O di goroutine ringan |

---

## 4. Validasi Data (Zod / Joi ➔ `go-playground/validator`)

| Source (Zod / Joi) | Target (Go Struct Tags) | Notes |
|---|---|---|
| `z.string().min(3).max(50)` | `Name string \`json:"name" validate:"required,min=3,max=50"\`` | Struct tags deklaratif |
| `z.string().email()` | `Email string \`json:"email" validate:"required,email"\`` | Validasi format email |
| `z.number().int().positive()` | `Age int \`json:"age" validate:"gte=0"\`` | Validasi numerik |
| `z.enum(['admin', 'user'])` | `Role string \`json:"role" validate:"oneof=admin user"\`` | Validasi pilihan enum |
| `z.string().optional()` | `Bio *string \`json:"bio,omitempty"\`` | Pointer type untuk field opsional |

---

## 5. Autentikasi & Token (jsonwebtoken / bcrypt)

| Source (Node.js) | Target (Go) | Library Target |
|---|---|---|
| `jwt.sign(payload, secret, { expiresIn: '1h' })` | `token.SignedString([]byte(secret))` | `github.com/golang-jwt/jwt/v5` |
| `jwt.verify(token, secret)` | `jwt.ParseWithClaims(tokenStr, claims, ...)` | Parse & validate signature |
| `bcrypt.hash(password, 10)` | `bcrypt.GenerateFromPassword([]byte(pass), 10)` | `golang.org/x/crypto/bcrypt` |
| `bcrypt.compare(password, hash)` | `bcrypt.CompareHashAndPassword([]byte(hash), []byte(pass))` | Verifikasi password |
