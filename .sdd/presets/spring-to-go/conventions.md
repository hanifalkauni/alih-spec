# Convention Mapping: Spring Boot (Java) → Go (Gin + GORM)

## Naming

| Concept | Java/Spring | Go | Example |
|---------|------------|-----|---------|
| Variables | `camelCase` | `camelCase` | Same |
| Functions | `camelCase` | `camelCase` (unexported) | Same |
| Classes → Structs | `PascalCase` | `PascalCase` | `UserController` → `UserHandler` |
| Constants | `UPPER_SNAKE` | `PascalCase` or `UPPER_SNAKE` | `MAX_RETRY` → `MaxRetry` |
| Files | `UserController.java` | `user_handler.go` | PascalCase → snake_case |
| Packages | `com.company.module` | `handler`, `service` | Short, lowercase |
| Interfaces | `IUserService` or `UserService` | `UserService` (interface) | No `I` prefix in Go |
| DB tables | `users` | `users` | Same |
| DB columns | `created_at` | `created_at` (GORM tag) | Same |
| JSON keys | `camelCase` | `snake_case` | `"userName"` → `"user_name"` |

## Class → Struct Translation

```java
// Java (Spring Boot)
@Entity
@Data
public class User {
    @Id @GeneratedValue
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    @JsonIgnore
    private String password;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
```

```go
// Go
type User struct {
    gorm.Model                                              // id, created_at, updated_at, deleted_at
    Name     string `gorm:"size:100;not null" json:"name"`
    Email    string `gorm:"uniqueIndex;not null" json:"email"`
    Password string `gorm:"not null" json:"-"`
}
```

## Controller → Handler Translation

```java
// Java (Spring Boot)
@RestController
@RequestMapping("/api/v1/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findById(id));
    }
}
```

```go
// Go
type UserHandler struct {
    userService interfaces.UserService
}

func NewUserHandler(userService interfaces.UserService) *UserHandler {
    return &UserHandler{userService: userService}
}

func (h *UserHandler) GetUser(c *gin.Context) {
    id, _ := strconv.ParseUint(c.Param("id"), 10, 32)
    user, err := h.userService.FindByID(c.Request.Context(), uint(id))
    if err != nil {
        response.Error(c, http.StatusNotFound, "User not found", nil)
        return
    }
    response.Success(c, http.StatusOK, "User retrieved", user)
}
```

## File Structure

| Spring Boot | Go | Notes |
|------------|-----|-------|
| `UserController.java` | `user_handler.go` | |
| `UserService.java` (interface) | `interfaces/user_service.go` | |
| `UserServiceImpl.java` | `user_service.go` | |
| `UserRepository.java` | `interfaces/user_repository.go` | |
| `UserRepositoryImpl.java` | `user_repository.go` | |
| `User.java` (Entity) | `user.go` (domain) | |
| `UserDto.java` | `user_dto.go` | |
| `UserMapper.java` | Manual conversion in service | |
| `AppConfig.java` | `bootstrap/app.go` | |

## Target Project Structure

```
output/
├── cmd/server/main.go
├── internal/
│   ├── handler/user_handler.go
│   ├── service/user_service.go
│   ├── repository/user_repository.go
│   ├── domain/
│   │   ├── user.go
│   │   └── interfaces/
│   │       ├── user_service.go
│   │       └── user_repository.go
│   ├── dto/user_dto.go
│   ├── middleware/
│   │   ├── auth.go
│   │   └── cors.go
│   ├── router/
│   │   ├── router.go
│   │   └── api.go
│   └── bootstrap/
│       ├── app.go
│       └── deps.go
├── pkg/
│   ├── apperror/errors.go
│   ├── response/response.go
│   └── logger/logger.go
├── config/config.go
├── migrations/
├── .env.example
├── go.mod
└── Makefile
```
