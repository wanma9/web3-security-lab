#!/usr/bin/env bash
set -euo pipefail

# Función de ayuda
usage() {
  cat << EOF
Uso: $(basename "$0") [CONTRATO] [DIRECTORIO_REPORTES] [DIRECTORIO_LOGS]

Descripción:
  Ejecuta Slither sobre un contrato Solidity y guarda el reporte y log.

Parámetros:
  CONTRATO              (Requerido) Ruta al archivo del contrato .sol
  DIRECTORIO_REPORTES   (Opcional) Directorio para guardar reportes
                        (Default: reports/slither)
  DIRECTORIO_LOGS       (Opcional) Directorio para guardar logs
                        (Default: logs/execution-logs)

Ejemplos:
  $(basename "$0") contracts/vulnerable-examples/SimpleReentrancy.sol
  $(basename "$0") contracts/vulnerable-examples/UnauthorizedAccess.sol reports/slither logs/execution-logs
  $(basename "$0") ./my-contracts/MyToken.sol

EOF
  exit 1
}

# Validar que se proporcione al menos el parámetro del contrato
if [ $# -lt 1 ]; then
  echo "[ERROR] Falta el parámetro de ruta del contrato" >&2
  usage
fi

# Asignar parámetros
CONTRACT_PATH="$1"
REPORT_DIR="${2:-reports/slither}"
LOG_DIR="${3:-logs/execution-logs}"

# Validar que el archivo del contrato existe
if [ ! -f "$CONTRACT_PATH" ]; then
  echo "[ERROR] El archivo del contrato no existe: $CONTRACT_PATH" >&2
  exit 1
fi

# Extraer nombre del contrato para mejor identificación
CONTRACT_NAME="$(basename "$CONTRACT_PATH" .sol)"

# Crear directorios necesarios
mkdir -p "$REPORT_DIR" "$LOG_DIR"

# Generar timestamp y nombres de archivos
TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
REPORT_FILE="$REPORT_DIR/slither_${CONTRACT_NAME}_${TIMESTAMP}.json"
LOG_FILE="$LOG_DIR/slither_${CONTRACT_NAME}_${TIMESTAMP}.log"

echo "[INFO] Ejecutando Slither sobre: $CONTRACT_PATH" | tee "$LOG_FILE"
echo "[INFO] Contrato: $CONTRACT_NAME" | tee -a "$LOG_FILE"
echo "[INFO] Reporte: $REPORT_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Ejecutar Slither
slither "$CONTRACT_PATH" --json "$REPORT_FILE" 2>&1 | tee -a "$LOG_FILE"

if [ ${PIPESTATUS[0]} -eq 0 ]; then
  echo "" | tee -a "$LOG_FILE"
  echo "[OK] Reporte guardado exitosamente en: $REPORT_FILE" | tee -a "$LOG_FILE"
else
  echo "" | tee -a "$LOG_FILE"
  echo "[ERROR] Slither finalizó con errores" | tee -a "$LOG_FILE"
  exit 1
fi
