# Glossary: Spring Boot (Java) → Go (Gin + GORM)

## Terminology Mapping

| Source Term | Target Term | Notes |
|-------------|------------|-------|
| `@RestController` | Handler struct | `internal/handler/` |
| `@Service` | Service struct | `internal/service/` |
| `@Repository` | Repository struct | `internal/repository/` |
| `@Entity` | Domain struct | `internal/domain/` |
| `@Component` | Plain struct | |
| `@Autowired` | Constructor parameter | Explicit DI |
| `@Bean` | Factory function return | |
| `@Configuration` | `internal/bootstrap/app.go` | |
| `@RequestMapping` | `router.Group(...)` | |
| `@GetMapping` | `group.GET(...)` | |
| `@PostMapping` | `group.POST(...)` | |
| `@PathVariable` | `c.Param("id")` | |
| `@RequestParam` | `c.Query("param")` | |
| `@RequestBody` | `c.ShouldBindJSON(&dto)` | |
| `@Valid` | `validate.Struct(&dto)` | |
| `ResponseEntity<T>` | `c.JSON(statusCode, data)` | |
| `Optional<T>` | `*T` (pointer) or `(T, error)` | |
| `@PreAuthorize` | Role-check middleware | |
| JPA/Hibernate | GORM | `gorm.io/gorm` |
| `@GeneratedValue` | `gorm:"primaryKey;autoIncrement"` | |
| `@Column` | GORM struct tag | `gorm:"column:name"` |
| `@ManyToOne` | GORM BelongsTo | |
| `@OneToMany` | GORM HasMany | |
| `@CreationTimestamp` | `gorm.Model` (auto) | |
| `throw new RuntimeException()` | `return fmt.Errorf(...)` | |
| `@ExceptionHandler` | Global error middleware | |
| `BCryptPasswordEncoder` | `golang.org/x/crypto/bcrypt` | |
| `application.properties` | `.env` + config struct | |
| `@Value("${key}")` | `cfg.Key` | Struct field |
| JUnit `@Test` | Go `func TestXxx(t *testing.T)` | |
| Mockito | `testify/mock` | |

---

## File Path Mapping

| Source (Spring Boot) | Target (Go) |
|---------------------|-------------|
| `src/main/java/.../controller/UserController.java` | `internal/handler/user_handler.go` |
| `src/main/java/.../service/UserService.java` | `internal/domain/interfaces/user_service.go` |
| `src/main/java/.../service/UserServiceImpl.java` | `internal/service/user_service.go` |
| `src/main/java/.../repository/UserRepository.java` | `internal/domain/interfaces/user_repository.go` |
| `src/main/java/.../entity/User.java` | `internal/domain/user.go` |
| `src/main/java/.../dto/UserDto.java` | `internal/dto/user_dto.go` |
| `src/main/java/.../config/AppConfig.java` | `internal/bootstrap/app.go` |
| `src/main/resources/application.properties` | `.env` + `config/config.go` |
| `src/test/java/` | `tests/` |

---

## HTTP Status Codes

| Scenario | Go Constant |
|----------|-------------|
| `HttpStatus.OK` | `http.StatusOK` |
| `HttpStatus.CREATED` | `http.StatusCreated` |
| `HttpStatus.NO_CONTENT` | `http.StatusNoContent` |
| `HttpStatus.BAD_REQUEST` | `http.StatusBadRequest` |
| `HttpStatus.UNAUTHORIZED` | `http.StatusUnauthorized` |
| `HttpStatus.FORBIDDEN` | `http.StatusForbidden` |
| `HttpStatus.NOT_FOUND` | `http.StatusNotFound` |
| `HttpStatus.CONFLICT` | `http.StatusConflict` |
| `HttpStatus.UNPROCESSABLE_ENTITY` | `http.StatusUnprocessableEntity` |
| `HttpStatus.INTERNAL_SERVER_ERROR` | `http.StatusInternalServerError` |
