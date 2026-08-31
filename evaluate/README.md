# 🔬 Evaluation & Lessons Learned Hub (`evaluate/`)

> Folder ini berfungsi sebagai **pusat evaluasi mutu, studi kasus konversi, dan standardisasi pencegahan bug lintas bahasa** dalam framework AlihSpec.

---

## 📖 Berkas Evaluasi Primer (Master Living Reference)

| Berkas | Fungsi Utama | Kapan Digunakan? |
|---|---|---|
| 📑 **[`framework-evaluation.md`](./framework-evaluation.md)** | **Master Evaluation & Precision Guide**: Berisi 7 Golden Directives, 16 Pilar Pelajaran Universal, 8 Standar Mutu Enterprise, Studi Kasus AST Cita `currentCoin`, Query Mapping, dan Checklist Self-Assessment. | **Wajib dibaca oleh seluruh AI Agent & Engineer** sebelum menganalisis source code atau menulis spesifikasi/kode target apa pun. |

---

## 🏛️ Panduan Tata Kelola & Penambahan Evaluasi Baru

Jika di masa mendatang Anda atau tim menemukan pelajaran baru, *edge case*, atau evaluasi arsitektur:

### 1. Kapan Memperbarui `framework-evaluation.md`?
- **Prinsip / Pelajaran Universal**: Jika pelajaran tersebut berlaku untuk semua konversi modul/bahasa (misal: penambahan pilar baru, standardisasi pagination, aturan sanitasi URL, penanganan timezone baru), **perbarui langsung ke dalam [`framework-evaluation.md`](./framework-evaluation.md)** agar tetap menjadi satu-satunya *Single Source of Truth* evaluasi bagi AI agent.

### 2. Kapan Membuat Berkas Baru di `evaluate/`?
- **Studi Kasus / Deep-Dive Khusus Domain**: Jika terdapat audit spesifik yang sangat mendalam pada modul atau integrasi pihak ketiga tertentu (misal: `evaluate/case-study-oauth2-migration.md`, `evaluate/case-study-payment-gateway-concurrency.md`, atau `evaluate/audit-performance-benchmark.md`), buat berkas markdown baru di folder `evaluate/` dan daftarkan tautannya di tabel bawah ini.

---

## 📚 Indeks Studi Kasus Khusus (Optional Deep-Dive Registry)

| Berkas Kasus | Domain / Topik | Status | Ringkasan |
|---|---|:---:|---|
| *Belum ada kasus khusus tambahan* | — | — | *Seluruh pelajaran universal terkonsolidasi di [`framework-evaluation.md`](./framework-evaluation.md).* |

---

## 🤖 Catatan untuk AI Agent
AI Coding Assistant (Antigravity, Cursor, Kiro, Copilot, Claude, Windsurf, Cline) **wajib merujuk ke [`framework-evaluation.md`](./framework-evaluation.md)** sebagai acuan pencegahan *Logic Drift* dan *Shallow Specs*.
