# 🤝 Contributing to AlihSpec

Terima kasih atas minatmu untuk berkontribusi pada **AlihSpec** (Spec-Driven Development Framework)!

---

## 🌟 Cara Berkontribusi

### 1. Menambahkan Preset Baru (`.sdd/presets/`)

Jika kamu membuat mapping untuk kombinasi bahasa/framework yang belum ada:
1. Buat folder baru: `.sdd/presets/[source-framework]-to-[target-framework]/`
2. Lengkapi 3 file standar:
   - `patterns.md` (Design pattern & concept mapping)
   - `conventions.md` (Style guide & naming rules)
   - `glossary.md` (Terminology & path dictionary)
   *(Gunakan `.sdd/presets/_custom-template/` sebagai acuan)*
3. Daftarkan preset baru di `.sdd/presets/README.md`
4. Jalankan validasi: `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`)

### 2. Memperbaiki / Menambah Prompt Vibe Coding

Jika kamu menemukan prompt yang menghasilkan output lebih baik:
- Edit `context/VIBE.md` atau `docs/guide-vibe-coding.md`
- Buat Pull Request dengan penjelasan use case-nya

### 3. Meningkatkan Tooling CLI (`alih`)

- Script PowerShell (`.ps1`) dan Bash (`.sh`) harus selalu dijaga paritas fitur dan perilakunya.

---

## 🧪 Validasi Sebelum Submit PR

Pastikan validator integritas lolos 100%:
```powershell
# Windows
.\scripts\alih.ps1 validate

# Linux / macOS
bash scripts/alih.sh validate
```

Hasil harus: `RESULT: Framework 100% VALID AND HEALTHY! (0 errors, 0 warnings)`.
