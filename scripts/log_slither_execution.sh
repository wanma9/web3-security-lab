#!/usr/bin/env bash
set -euo pipefail

CONTRACT_PATH="${1:-contracts/vulnerable-examples/SimpleReentrancy.sol}"
REPORT_DIR="${2:-reports/slither}"
LOG_DIR="${3:-logs/execution-logs}"

mkdir -p "$REPORT_DIR" "$LOG_DIR"
TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
REPORT_FILE="$REPORT_DIR/slither_${TIMESTAMP}.json"
LOG_FILE="$LOG_DIR/slither_${TIMESTAMP}.log"

echo "[INFO] Ejecutando Slither sobre $CONTRACT_PATH" | tee "$LOG_FILE"
slither "$CONTRACT_PATH" --json "$REPORT_FILE" 2>&1 | tee -a "$LOG_FILE"

if [ ${PIPESTATUS[0]} -eq 0 ]; then
  echo "[OK] Reporte guardado en $REPORT_FILE" | tee -a "$LOG_FILE"
else
  echo "[ERROR] Slither finalizó con errores" | tee -a "$LOG_FILE"
  exit 1
fi
