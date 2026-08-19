#!/usr/bin/env bash
# AlihSpec Framework Integrity Validator — Linux/macOS/Git-Bash
# Memvalidasi kelengkapan spesifikasi, tugas, DoD, dan link internal
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

# 1. Check Core Files
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

# 2. Check Spec to Task Coverage & DoD
echo ""
echo "2. Checking Spec-to-Task Coverage & Spec DoD..."
TASK_INDEX="tasks/_index.md"

if [ -f "$TASK_INDEX" ]; then
    TASK_CONTENT=$(cat "$TASK_INDEX")
    for spec in specs/modules/*.md; do
        [ -e "$spec" ] || continue
        spec_name=$(basename "$spec")
        [ "$spec_name" = "_template.md" ] && continue
        module_name="${spec_name%.md}"

        if echo "$TASK_CONTENT" | grep -q "$module_name"; then
            echo "  [OK] Spec '$spec_name' has matching task entry in tasks/_index.md"
        else
            echo "  [WARNING] Spec '$spec_name' might not have a task in tasks/_index.md"
            WARNINGS=$((WARNINGS + 1))
        fi

        if grep -qi "DoD\|Definition of Done" "$spec"; then
            echo "  [OK] Spec '$spec_name' includes Definition of Done (DoD) Checklist"
        else
            echo "  [WARNING] Spec '$spec_name' is missing Definition of Done (DoD) Checklist"
            WARNINGS=$((WARNINGS + 1))
        fi
    done
fi

# Summary
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
