# 🟣 Reference Target Project (Optional)

Folder ini bersifat **opsional**.

Gunakan folder ini jika Anda sudah memiliki **contoh starter kit, boilerplate, atau template project dalam bahasa target** (misal: Go Clean Architecture starter, NestJS template perusahaan, FastAPI async boilerplate) yang ingin ditiru struktur dan gayanya oleh AI.

---

## 🚀 Cara Penggunaan:

### 1. Salin Template Starter Target ke Folder Ini:

**Opsi A: Windows PowerShell / CMD**
```powershell
xcopy /E /I C:\path\to\your-starter-template reference-target\
```

**Opsi B: Linux / macOS Bash**
```bash
cp -r /path/to/your-starter-template/* reference-target/
```

**Opsi C: Git Submodule (Rekomendasi jika dari Git)**
```bash
git submodule add https://github.com/your-org/your-starter-template.git reference-target
```

---

### 2. Kirim Prompt Ini ke AI Coding Agent:

```markdown
Saya telah meletakkan contoh starter template target di folder `reference-target/`.

Tolong lakukan analisis mendalam terhadap `reference-target/` dan selaraskan framework AlihSpec ini:
1. Bedah struktur arsitektur folder & layering -> perbarui `specs/architecture.md`
2. Ekstrak konvensi koding, standard JSON response, error handling, & context propagation -> perbarui `context/conventions.md`
3. Ekstrak daftar pustaka pihak ketiga & database driver -> perbarui `context/tech-stack.md`
4. Petakan padanan pola sumber ke pola starter ini -> perbarui `.sdd/mapping/patterns.md`
5. Salin pustaka pembantu dasar (seperti `pkg/`, `config/`, `.env.example`, `Makefile`, `Dockerfile`) dari `reference-target/` ke `output/` sebagai pondasi dasar
6. Catat keputusan pemilihan arsitektur starter ini ke dalam `docs/decisions.md` (ADR)

Setelah pondasi siap, gunakan standar ini untuk mengonversi seluruh modul bisnis dari `source/` ke `output/`.
```

---

## ⚠️ Aturan Penting:

- **READ-ONLY Reference**: Folder ini hanya dibaca oleh AI sebagai acuan pola dan konvensi penulisan.
- **Seluruh Kode Target Ditulis di `output/`**: Dilarang mengedit atau menulis kode hasil konversi di dalam `reference-target/`.

