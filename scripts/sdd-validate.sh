#!/usr/bin/env bash
# AlihSpec Framework Integrity Validator — Linux/macOS Bash
# Memvalidasi kelengkapan spesifikasi, tugas, dan link internal
#
# Usage:
#   bash scripts/sdd-validate.sh

echo ""
echo "==================================================="
echo "   ⚡ AlihSpec — Framework Integrity Validation"
echo "==================================================="
echo ""

ERRORS=0
WARNINGS=0

echo "1. Checking Core Files..."
CORE_FILES=(
    "README.md"
    "AGENTS.md"
    ".sdd/config.yaml"
    ".sdd/mapping/patterns.md"
    "context/AGENTS.md"
    "context/conventions.md"
    "context/glossary.md"
    "context/tech-stack.md"
    "context/RULES.md"
    "context/qa-checklist.md"
    "specs/overview.md"
    "specs/architecture.md"
    "specs/data-models/schema.md"
    "specs/api-contracts/openapi.yaml"
    "tasks/_index.md"
)

for file in "${CORE_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  [OK] $file"
    else
        echo "  [MISSING] $file"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "2. Checking Spec-to-Task Coverage..."
if [ -f "tasks/_index.md" ]; then
    for spec in specs/modules/*.md; do
        b=$(basename "$spec")
        [ "$b" = "_template.md" ] && continue
        mod="${b%.md}"
        if grep -q "$mod" tasks/_index.md; then
            echo "  [OK] Spec '$b' has matching task entry in tasks/_index.md"
        else
            echo "  [WARNING] Spec '$b' might not have a task in tasks/_index.md"
            WARNINGS=$((WARNINGS + 1))
        fi
    done
fi

echo ""
echo "==================================================="
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "   RESULT: Framework 100% VALID & HEALTHY! (0 errors, 0 warnings)"
elif [ $ERRORS -eq 0 ]; then
    echo "   RESULT: VALID with $WARNINGS warning(s)."
else
    echo "   RESULT: FAILED with $ERRORS error(s) and $WARNINGS warning(s)."
fi
echo "==================================================="
echo ""
