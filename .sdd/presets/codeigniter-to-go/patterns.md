# Pattern Mapping: CodeIgniter (PHP) ➔ Go (Gin / Fiber + GORM)

> Panduan pemetaan dari CodeIgniter (CI3/CI4) ke Golang Clean Architecture (Gin/Fiber + GORM).

---

## 1. Application Layer

| Source (CodeIgniter) | Target (Go Clean Architecture) | Notes |
|---|---|---|
| `application/controllers/` | `internal/handler/` | HTTP Handlers menerima context `*gin.Context` |
| `application/models/` | `internal/repository/` & `internal/domain/` | Entity structs di `domain/`, query di `repository/` |
| `application/libraries/` | `internal/service/` | Business logic & orchestrator |
| `application/hooks/` (CI3) / `Filters` (CI4) | `internal/middleware/` | Auth & logging middleware |
| `application/config/routes.php` | `internal/router/` | Route registration |
| `application/helpers/` | `pkg/utils/` | Utility functions |
| Input validation rules | `internal/dto/` | Request DTO dengan `validate:"..."` tags |

---

## 2. Database Operations (CI Active Record ➔ GORM)

| Source (CodeIgniter) | Target (GORM / Go) | Notes |
|---|---|---|
| `$this->db->get('users')->result_array()` | `db.Find(&users).Error` | Mengambil seluruh slice struct |
| `$this->db->get_where('users', ['id' => $id])->row_array()` | `db.First(&user, id).Error` | Mengambil satu baris |
| `$this->db->insert('users', $data)` | `db.Create(&user).Error` | Insert struct ke table |
| `$this->db->where('id', $id)->update('users', $data)` | `db.Model(&user).Updates(updates).Error` | Update kolom |
| `$this->db->where('id', $id)->delete('users')` | `db.Delete(&user, id).Error` | Delete (soft delete jika ada `gorm.DeletedAt`) |
| `$this->db->join('roles', 'roles.id = users.role_id')` | `db.Preload("Role").Find(&users)` | Preloading struct relation |
| `$this->db->trans_start(); ... trans_complete();` | `tx := db.Begin(); ... tx.Commit()` | Transaksi database eksplisit |
| `$this->db->query("SELECT ...", [$id])` | `db.Raw("SELECT ...", id).Scan(&results)` | Raw SQL query |

---

## 3. Request & Input Validation

| Source (CodeIgniter) | Target (Go) | Notes |
|---|---|---|
| `$this->input->post('email')` | `c.ShouldBindJSON(&dto)` | Binding JSON request body |
| `$this->input->get('search')` | `c.Query("search")` | Query string |
| `$this->form_validation->set_rules('email', 'Email', 'required|valid_email')` | `Email string \`json:"email" validate:"required,email"\`` | Struct validator tags |
| `$this->form_validation->run()` | `validator.New().Struct(dto)` | `go-playground/validator` |
| `$this->input->is_ajax_request()` | Header `X-Requested-With` check | Atau inspeksi `Accept: application/json` |

---

## 4. Response & Output

| Source (CodeIgniter) | Target (Go) | Notes |
|---|---|---|
| `$this->output->set_content_type('application/json')->set_output(json_encode($data));` | `c.JSON(http.StatusOK, response.Success(data))` | JSON response standar |
| `show_404()` | `c.JSON(http.StatusNotFound, response.Error("not found"))` | Error handling |
| `$this->session->set_flashdata('success', 'ok')` | DTO Response message | API stateless tidak memakai flash session |
