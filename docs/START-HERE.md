# 🚪 Pilih Cara Kerjamu

> Halaman ini membantumu memilih guide yang paling sesuai.

---

## Kamu termasuk tipe mana?

---

### 🤖 Tipe A — "Saya mau AI yang handle semua"

**Vibe Coder**: Ingin nol setup manual, cukup copy-paste prompt ke AI dan review hasilnya.

- ⏱️ Setup: ~5 menit
- 🎯 Cocok untuk: project yang tidak terlalu kritikal, eksperimen, prototyping cepat
- 📖 **Buka**: [`docs/guide-vibe-coding.md`](./guide-vibe-coding.md)

---

### ✍️ Tipe B — "Saya mau kontrol penuh"

**Manual**: Ingin menulis semua spec, task, dan keputusan teknis sendiri.

- ⏱️ Setup: ~1-2 jam
- 🎯 Cocok untuk: project enterprise, tim besar, butuh audit trail lengkap
- 📖 **Buka**: [`docs/guide-manual.md`](./guide-manual.md)

---

### 🔀 Tidak Yakin? — Rekomendasi Hybrid

Kombinasi terbaik untuk kebanyakan project:

| Fase | Pendekatan | Mengapa |
|------|-----------|---------|
| Setup (Fase 0) | Manual | Hanya 5 menit, wajib |
| Analisis source | AI | AI lebih cepat scan code |
| Tulis specs | **Kamu + AI** | Kamu review, AI yang nulis |
| Buat tasks | AI | Otomatis dari specs |
| Konversi kode | AI | Task per task, kamu review tiap selesai |
| Validasi | **Kamu + AI** | AI cek, kamu konfirmasi |

Gunakan [`docs/guide-vibe-coding.md`](./guide-vibe-coding.md) tapi
pause di setiap fase untuk review sebelum lanjut.

---

## 📚 Referensi Cepat

| Kebutuhan | File / Command |
|-----------|----------------|
| Inisialisasi awal | `.\scripts\alih.ps1 init` (atau `bash scripts/alih.sh init`) |
| Cek progress & task aktif | `.\scripts\alih.ps1 status` (atau `bash scripts/alih.sh status`) |
| Validasi integritas & link | `.\scripts\alih.ps1 validate` (atau `bash scripts/alih.sh validate`) |
| Preset tidak tersedia | [`.sdd/presets/CUSTOM-PRESET-GUIDE.md`](../.sdd/presets/CUSTOM-PRESET-GUIDE.md) |
| Benchmark & KPI Efisiensi | [`docs/efficiency-benchmark.md`](./efficiency-benchmark.md) |
| Prompt siap pakai | [`context/VIBE.md`](../context/VIBE.md) |
| Checklist sebelum mulai | [`context/checklist-before-start.md`](../context/checklist-before-start.md) |
| Validasi hasil QA | [`context/qa-checklist.md`](../context/qa-checklist.md) |
| Template modul baru | [`specs/modules/_template.md`](../specs/modules/_template.md) |
| Template task baru | [`tasks/_template.md`](../tasks/_template.md) |
