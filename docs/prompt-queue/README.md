# ⚡ Antrean Prompt Konversi (Prompt Queue Master Index)

> 📌 **Direktori ini dibuat / diperbarui secara otomatis oleh AI pada FASE 1 (Analisis Sumber).**  
> Setiap file di dalam folder ini memuat kumpulan prompt siap copy-paste berstandar enterprise yang **sudah terisi otomatis (*pre-filled*)** dengan nama modul, file controller sumber, dan path task-nya.

---

## 🧭 Cara Menggunakan Antrean Ini:

1. **Buka file modul yang ingin dikerjakan** (mulai dari `01-auth.md`, lalu `02-user.md`, dst.).
2. Di dalam setiap file modul, tersedia 2 pilihan alur:
   - **🌟 Opsi B (Single-Module Full Cycle)**: 1 prompt langsung untuk menyelesaikan modul dari spec sampai coding & test (*Rekomendasi Vibe Coding*).
   - **📋 Opsi A (Step-by-Step)**: Prompt per fase (Spec ➔ Checkpoint 1 ➔ Task ➔ Code ➔ Checkpoint 2) untuk kontrol audit presisi.
3. Copy-paste prompt ke AI chat, review hasil, lalu lanjut ke file modul berikutnya!

---

## 📋 Daftar Modul & Antrean Pengerjaan

| Urutan | Modul | Controller Sumber | Berkas Prompt | Status |
|:---:|---|---|---|:---:|
| 01 | **Auth** | `source/app/Http/Controllers/AuthController.php` | [`01-auth.md`](./01-auth.md) | [ ] Antrean |
| 02 | **User** | `source/app/Http/Controllers/UserController.php` | [`02-user.md`](./02-user.md) | [ ] Antrean |
| 03 | **Product** | `source/app/Http/Controllers/ProductController.php` | [`03-product.md`](./03-product.md) | [ ] Antrean |

---

> 💡 *Saat menjalankan Fase 1 pada proyek riil Anda, AI akan otomatis membuat file `.md` baru untuk setiap modul bisnis yang ditemukan di `source/` dan mendaftarkannya ke tabel di atas.*
