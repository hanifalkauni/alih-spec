#!/usr/bin/env bash
# SDD Status Script — Linux/macOS Bash
# Menampilkan dashboard progress konversi secara instan
#
# Usage:
#   bash scripts/sdd-status.sh

INDEX_FILE="tasks/_index.md"

if [ ! -f "$INDEX_FILE" ]; then
    echo "Error: $INDEX_FILE not found. Make sure you are in the workspace root."
    exit 1
fi

TOTAL=0
DONE=0
IN_PROGRESS=0
BLOCKED=0
NOT_STARTED=0

declare -a TASKS_NAME
declare -a TASKS_STATUS
declare -a TASKS_DESC

CURRENT_PHASE="General"
declare -a PHASES
declare -A PHASE_TOTAL
declare -A PHASE_DONE

while IFS= read -r line; do
    if [[ $line =~ ^##\ Phase\ (.*) ]]; then
        CURRENT_PHASE="${BASH_REMATCH[1]}"
        if [[ -z "${PHASE_TOTAL[$CURRENT_PHASE]}" ]]; then
            PHASES+=("$CURRENT_PHASE")
            PHASE_TOTAL["$CURRENT_PHASE"]=0
            PHASE_DONE["$CURRENT_PHASE"]=0
        fi
    fi

    if [[ $line =~ ^[[:space:]]*-[[:space:]]*\[(.)\][[:space:]]*\[([^\]]+)\]\(([^)]+)\)[[:space:]]*(—|-)?(.*) ]]; then
        STATUS="${BASH_REMATCH[1]}"
        FILE="${BASH_REMATCH[2]}"
        DESC="${BASH_REMATCH[5]}"

        TOTAL=$((TOTAL + 1))
        PHASE_TOTAL["$CURRENT_PHASE"]=$(( ${PHASE_TOTAL["$CURRENT_PHASE"]} + 1 ))

        if [ "$STATUS" = "x" ]; then
            DONE=$((DONE + 1))
            PHASE_DONE["$CURRENT_PHASE"]=$(( ${PHASE_DONE["$CURRENT_PHASE"]} + 1 ))
        elif [ "$STATUS" = "/" ]; then
            IN_PROGRESS=$((IN_PROGRESS + 1))
        elif [ "$STATUS" = "!" ]; then
            BLOCKED=$((BLOCKED + 1))
        else
            NOT_STARTED=$((NOT_STARTED + 1))
        fi

        TASKS_NAME+=("$FILE")
        TASKS_STATUS+=("$STATUS")
        TASKS_DESC+=("$DESC")
    fi
done < "$INDEX_FILE"

PERCENT=0
if [ $TOTAL -gt 0 ]; then
    PERCENT=$(( (DONE * 100) / TOTAL ))
fi

BAR_WIDTH=25
FILLED=$(( (DONE * BAR_WIDTH) / (TOTAL > 0 ? TOTAL : 1) ))
EMPTY=$(( BAR_WIDTH - FILLED ))

BAR=""
for ((i=0; i<FILLED; i++)); do BAR="${BAR}="; done
for ((i=0; i<EMPTY; i++)); do BAR="${BAR}-"; done

echo ""
echo "==================================================="
echo "   ⚡ AlihSpec — Conversion Progress Dashboard"
echo "==================================================="
echo ""
echo "  Progress : [$BAR] ${PERCENT}%"
echo "  Total    : $TOTAL tasks"
echo "  Done     : $DONE"
echo "  In Prog  : $IN_PROGRESS"
echo "  Pending  : $NOT_STARTED"
[ $BLOCKED -gt 0 ] && echo "  Blocked  : $BLOCKED"
echo ""

echo "Phase Breakdown:"
for p in "${PHASES[@]}"; do
    pt=${PHASE_TOTAL["$p"]}
    pd=${PHASE_DONE["$p"]}
    pp=0
    [ $pt -gt 0 ] && pp=$(( (pd * 100) / pt ))
    echo "  - $p: $pd/$pt (${pp}%)"
done

echo ""

NEXT_IDX=-1
for i in "${!TASKS_STATUS[@]}"; do
    if [ "${TASKS_STATUS[$i]}" = "/" ]; then
        NEXT_IDX=$i
        break
    fi
done

if [ $NEXT_IDX -eq -1 ]; then
    for i in "${!TASKS_STATUS[@]}"; do
        if [ "${TASKS_STATUS[$i]}" = " " ]; then
            NEXT_IDX=$i
            break
        fi
    done
fi

if [ $NEXT_IDX -ge 0 ]; then
    echo "Next Recommended Task:"
    echo "  [${TASKS_NAME[$NEXT_IDX]}] - ${TASKS_DESC[$NEXT_IDX]}"
elif [ $TOTAL -gt 0 ] && [ $DONE -eq $TOTAL ]; then
    echo "ALL TASKS COMPLETED! Proceed to QA checklist."
fi
echo ""
