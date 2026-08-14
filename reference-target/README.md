# Reference Target Project (Optional)

Folder ini bersifat **opsional**.

Gunakan folder ini jika Anda sudah memiliki **contoh starter kit, boilerplate, atau template project dalam bahasa target** yang ingin ditiru oleh AI.

---

## 🚀 Cara Penggunaan:

1. **Copy project template target Anda ke dalam folder ini**:
   ```bash
   # Contoh: letakkan starter Go/NestJS/FastAPI Anda di sini
   xcopy /E /I C:\path\to\my-go-starter reference-target\
   ```

2. **Kirim prompt ini ke AI agent:**
   ```
   Saya sudah meletakkan contoh template target di folder reference-target/.
   Tolong scan folder reference-target/ dan ekstrak:
   1. Struktur arsitektur folder -> tulis ke specs/architecture.md
   2. Coding conventions & error handling -> tulis ke context/conventions.md
   3. Tech stack & dependencies -> tulis ke context/tech-stack.md
   4. Pattern mapping -> tulis ke .sdd/mapping/patterns.md

   Lalu gunakan pola tersebut untuk mengkonversi modul dari source/ ke output/.
   ```

3. Folder ini bersifat **READ-ONLY** (hanya dibaca oleh AI sebagai referensi gaya penulisan).
