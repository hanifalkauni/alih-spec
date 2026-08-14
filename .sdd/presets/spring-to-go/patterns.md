# Pattern Mapping: Spring Boot (Java) → Go (Gin + GORM)

## Application Layer

| Source (Spring Boot) | Target (Go/Gin) | Notes |
|---------------------|-----------------|-------|
| `@RestController` | Handler struct | `internal/handler/` |
| `@Service` | Service struct | `internal/service/` |
| `@Repository` | Repository struct | `internal/repository/` |
| `@Entity` | Domain struct | `internal/domain/` |
| `@Component` | Plain struct with constructor | |
| `@Configuration` | `internal/bootstrap/` | |
| `@SpringBootApplication` | `cmd/server/main.go` | |
| `application.properties` | `.env` + config struct | |
| `application.yml` | `.env` + config struct | |
| Lombok `@Data` | Plain struct with getters | Go has no annotations |
| `@Scheduled` | `internal/worker/` | cron or ticker |
| `@Async` | goroutine | `go func()` |
| `@EventListener` | Event handler function | |

## Routing / Controller

| Source (Spring Boot) | Target (Go/Gin) | Notes |
|---------------------|-----------------|-------|
| `@RequestMapping("/users")` | `router.Group("/users")` | |
| `@GetMapping("/{id}")` | `group.GET("/:id", handler)` | |
| `@PostMapping` | `group.POST("", handler)` | |
| `@PutMapping("/{id}")` | `group.PUT("/:id", handler)` | |
| `@DeleteMapping("/{id}")` | `group.DELETE("/:id", handler)` | |
| `@PatchMapping` | `group.PATCH(...)` | |
| `@PathVariable Long id` | `c.Param("id")` | |
| `@RequestParam String q` | `c.Query("q")` | |
| `@RequestBody UserDto dto` | `c.ShouldBindJSON(&dto)` | |
| `@RequestHeader("Authorization")` | `c.GetHeader("Authorization")` | |
| `@ResponseStatus(HttpStatus.CREATED)` | `c.JSON(201, ...)` | |
| `ResponseEntity<UserDto>` | Return from handler with `c.JSON` | |

## ORM (JPA/Hibernate → GORM)

| Source (JPA) | Target (GORM) | Notes |
|-------------|----------------|-------|
| `@Entity` | `gorm.Model` embedded struct | |
| `@Id @GeneratedValue` | `gorm.Model` (auto ID) | |
| `@Column(name = "email")` | `gorm:"column:email"` | |
| `@Column(nullable = false)` | `gorm:"not null"` | |
| `@Column(unique = true)` | `gorm:"uniqueIndex"` | |
| `@ManyToOne` | `BelongsTo` in GORM | |
| `@OneToMany` | `HasMany` in GORM | |
| `@ManyToMany` | `Many2Many` in GORM | |
| `@CreationTimestamp` | `gorm.Model` (auto) | |
| `@UpdateTimestamp` | `gorm.Model` (auto) | |
| `repository.findById(id)` | `db.First(&model, id)` | |
| `repository.findAll()` | `db.Find(&models)` | |
| `repository.save(entity)` | `db.Save(&model)` | |
| `repository.deleteById(id)` | `db.Delete(&model, id)` | |
| `@Query("SELECT ...")` | `db.Raw("SELECT ...")` | |
| `Pageable` | `offset` + `limit` | |
| `Sort` | `db.Order(...)` | |
| `Specification<T>` | Builder pattern with `db.Where()` | |

## Dependency Injection

| Source (Spring DI) | Target (Go) | Notes |
|-------------------|-------------|-------|
| `@Autowired` | Constructor injection | Go has no annotations |
| `@Bean` | Return value from factory func | |
| `@Qualifier("name")` | Pass specific impl | |
| `@Primary` | Default impl | |
| ApplicationContext | Manual DI wiring in `bootstrap/` | |
| Constructor injection | `func New(dep Dep) *Service` | Preferred in Go |

## Validation

| Source (Spring/Bean Validation) | Target (Go) | Notes |
|--------------------------------|-------------|-------|
| `@NotNull` | `validate:"required"` | |
| `@NotBlank` | `validate:"required"` | |
| `@Email` | `validate:"email"` | |
| `@Size(min=2, max=100)` | `validate:"min=2,max=100"` | |
| `@Min(1)` | `validate:"min=1"` | |
| `@Max(100)` | `validate:"max=100"` | |
| `@Pattern(regexp="...")` | Custom validator | |
| `@Valid` | `validate.Struct(&dto)` | |
| `BindingResult` | Return error from validate | |

## Exception Handling

| Source (Spring) | Target (Go) | Notes |
|----------------|-------------|-------|
| `@ExceptionHandler` | Custom error middleware | |
| `@ControllerAdvice` | Gin error handler | |
| `ResponseEntityExceptionHandler` | `pkg/apperror/` + middleware | |
| `EntityNotFoundException` | `apperror.ErrNotFound` | |
| `AccessDeniedException` | `apperror.ErrForbidden` | |
| `MethodArgumentNotValidException` | Validation error struct | |
| `throw new RuntimeException(...)` | `return fmt.Errorf(...)` | |

## Security

| Source (Spring Security) | Target (Go) | Notes |
|-------------------------|-------------|-------|
| `SecurityFilterChain` | Gin middleware chain | |
| `@PreAuthorize("hasRole('ADMIN')")` | Role-check middleware | |
| `UserDetails` | `domain.User` | |
| `UserDetailsService` | `AuthService.GetCurrentUser()` | |
| `JwtAuthenticationFilter` | JWT middleware | |
| `BCryptPasswordEncoder` | `golang.org/x/crypto/bcrypt` | |
| `SecurityContextHolder.getContext().getAuthentication()` | `c.Get("user")` | |

## Configuration

| Source (Spring Boot) | Target (Go) | Notes |
|--------------------|-------------|-------|
| `application.properties` | `.env` | |
| `@Value("${key}")` | `cfg.Key` (struct field) | |
| `@ConfigurationProperties` | Config struct + envconfig | |
| `spring.datasource.url` | `DB_HOST`, `DB_NAME` env vars | |
| `spring.jpa.hibernate.ddl-auto` | GORM AutoMigrate or goose | |
| Actuator `/health` | Custom `/health` endpoint | |
| Actuator metrics | Prometheus middleware | |

## Testing

| Source (Spring Boot Test) | Target (Go) | Notes |
|--------------------------|-------------|-------|
| `@SpringBootTest` | `testing.T` + real app | |
| `@WebMvcTest` | `httptest` + handler | |
| `MockMvc` | `httptest.NewRecorder()` | |
| `@MockBean` | `testify/mock` | |
| `Mockito.when(...)` | `mock.On(...)` | |
| `@DataJpaTest` | Test DB with GORM | |
| `@BeforeEach` | `TestMain` or `t.Cleanup()` | |
| `Assertions.assertEquals` | `assert.Equal(t, ...)` | testify |
