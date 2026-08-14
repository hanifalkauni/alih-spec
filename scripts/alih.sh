#!/usr/bin/env bash
# ⚡ AlihSpec CLI Runner — Linux/macOS Bash
#
# Usage:
#   bash scripts/alih.sh init      -> Inisialisasi proyek baru & auto-apply preset
#   bash scripts/alih.sh status    -> Dashboard progres konversi live
#   bash scripts/alih.sh validate  -> Validasi kelengkapan dokumen, spec, dan link
#   bash scripts/alih.sh help      -> Tampilkan panduan perintah

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMAND="${1:-help}"
shift || true

case "${COMMAND,,}" in
    init)
        bash "${SCRIPT_DIR}/sdd-init.sh" "$@"
        ;;
    status)
        bash "${SCRIPT_DIR}/sdd-status.sh" "$@"
        ;;
    validate)
        bash "${SCRIPT_DIR}/sdd-validate.sh" "$@"
        ;;
    *)
        echo ""
        echo "==================================================="
        echo "   ⚡ AlihSpec CLI (alih) — Spec-Driven Conversion"
        echo "==================================================="
        echo ""
        echo "Usage: bash scripts/alih.sh <command>"
        echo ""
        echo "Available Commands:"
        echo "  init      Inisialisasi proyek baru & pasang preset"
        echo "  status    Tampilkan dashboard progres konversi secara live"
        echo "  validate  Uji integritas framework, broken link & coverage task"
        echo "  help      Tampilkan panduan ini"
        echo ""
        echo "Contoh:"
        echo "  bash scripts/alih.sh status"
        echo ""
        ;;
esac
