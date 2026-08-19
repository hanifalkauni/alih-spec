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
| Antrean prompt terisi otomatis | [`docs/prompt-queue.md`](./prompt-queue.md) |
| Prompt siap pakai (Bank) | [`context/VIBE.md`](../context/VIBE.md) |
| Checklist sebelum mulai | [`context/checklist-before-start.md`](../context/checklist-before-start.md) |
| Validasi hasil QA | [`context/qa-checklist.md`](../context/qa-checklist.md) |
| Template modul baru | [`specs/modules/_template.md`](../specs/modules/_template.md) |
| Template task baru | [`tasks/_template.md`](../tasks/_template.md) |

---

## 📚 Panduan Berkas Dokumentasi & Audit Trail (docs/)

Folder docs/ berfungsi sebagai buku catatan, antrean prompt, dan audit trail selama proses migrasi:

| Berkas | Kapan Harus Diisi / Dilihat? | Fungsi Utama |
|---|---|---|
| ⚡ [docs/prompt-queue.md](./prompt-queue.md) | **Saat Eksekusi Vibe Coding (Fase 2-4)** | Antrean prompt siap copy-paste yang sudah terisi nama modul dan controller sumber. |
| 📈 [docs/progress.md](./progress.md) | **Setiap Selesai Fase Besar / Pause Sesi** | Log pencapaian milestone dan ringkasan status sesi untuk AI/developer berikutnya. |
| 🏛️ [docs/decisions.md](./decisions.md) | **Saat Membuat Keputusan Arsitektural (ADR)** | Mencatat alasan (*WHY*) di balik pemilihan teknologi, library, atau arsitektur tertentu. |
| 🗺️ [docs/mapping-log.md](./mapping-log.md) | **Saat Ada Fitur Sumber yang Tidak Bisa 1:1** | Log deviasi teknis saat fitur di bahasa sumber tidak memiliki padanan langsung di target. |
| 📝 [docs/changelog.md](./changelog.md) | **Setiap Selesai Mengonversi Modul / Rilis** | Riwayat penambahan fitur (Added), perubahan (Changed), dan perbaikan bug (Fixed). |
| ⚡ [docs/efficiency-benchmark.md](./efficiency-benchmark.md) | **Saat Evaluasi KPI & Pengujian Efisiensi** | Metrik kuantitatif efisiensi waktu (~70%), penghematan token, dan scorecard pengujian. |
