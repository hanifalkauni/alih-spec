# 🤝 Contributing to AlihSpec

Terima kasih atas minatmu untuk berkontribusi pada **AlihSpec** (Spec-Driven Development Framework & AI Agent Skill)!

Framework ini tumbuh semakin tangguh berkat kontribusi komunitas dan pelajaran nyata dari berbagai kasus konversi perangkat lunak di lapangan (*real-world production post-mortems*).

---

## 🌟 Cara Berkontribusi

### 1. 🔬 Berbagi Pelajaran Lapangan & Studi Kasus Evaluasi (`evaluate/`)

Sangat dianjurkan untuk menyerap sebanyak mungkin kasus nyata dari lapangan agar seluruh AI Agent dan engineer terhindar dari *hidden production bugs* yang sama:

- **A. Pelajaran Universal / Pilar Baru**:
  - Jika kamu menemukan aturan arsitektur, bug laten, atau pola konversi yang berlaku umum untuk semua bahasa/framework (misal: sanitasi header baru, mitigasi race condition DB, penanganan timezone), **perbarui langsung ke berkas [`evaluate/framework-evaluation.md`](./evaluate/framework-evaluation.md)**.
- **B. Studi Kasus Khusus Domain / Post-Mortem Audit**:
  - Jika kamu menemukan kasus konversi yang sangat mendalam atau kompleks pada domain/modul tertentu (misal: migrasi OAuth2/SSO, Webhook concurrency, integrasi Payment Gateway, atau gRPC streaming):
    1. Buat berkas baru di dalam folder `evaluate/`: `evaluate/case-study-[nama-topik].md`.
    2. Uraikan: **Studi Kasus & Akar Masalah (Root Cause)**, **Contoh Kode Salah vs Kode Benar**, dan **Instruksi Kunci untuk AI Agent**.
    3. Daftarkan tautan berkas baru tersebut ke dalam tabel indeks di [`evaluate/README.md`](./evaluate/README.md).

---

### 2. 📦 Menambahkan Preset Baru (`.sdd/presets/`)

Jika kamu membuat mapping untuk kombinasi bahasa/framework yang belum ada:
1. Buat folder baru: `.sdd/presets/[source-framework]-to-[target-framework]/`
2. Lengkapi 3 file standar:
   - `patterns.md` (Design pattern & concept mapping)
   - `conventions.md` (Style guide & naming rules)
   - `glossary.md` (Terminology & path dictionary)
   *(Gunakan `.sdd/presets/_custom-template/` sebagai acuan)*
3. Daftarkan preset baru di `.sdd/presets/README.md` dan tabel preset di `README.md`.
4. Jalankan validasi integritas: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`).

---

### 3. ⚡ Memperbaiki / Menambah Prompt Vibe Coding & Skill AI

Jika kamu menemukan prompt atau aturan skill yang menghasilkan output lebih presisi:
- Perbarui `context/VIBE.md`, `docs/guide-vibe-coding.md`, atau `.agents/skills/alih-spec/SKILL.md`.
- Buat Pull Request dengan penjelasan skenario dan *before/after* hasil kodenya.

---

### 4. 🛠️ Meningkatkan Tooling CLI (`alih`)

- Script PowerShell (`.ps1`) dan Bash (`.sh`) harus selalu dijaga paritas fitur, parameter, dan perilakunya (1:1).

---

## 🧪 Validasi Wajib Sebelum Submit Pull Request

Sebelum membuat Pull Request (PR), **WAJIB** menjalankan validator integritas framework untuk memastikan tidak ada *broken link* atau berkas core yang hilang:

```powershell
# Windows PowerShell
.\scripts\alih.ps1 validate

# Linux / macOS Bash
bash scripts/alih.sh validate
```

Hasil wajib: `RESULT: Framework 100% VALID AND HEALTHY! (0 errors, 0 warnings)`.
