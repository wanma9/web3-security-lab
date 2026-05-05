#!/usr/bin/env bash
set -euo pipefail

INCIDENT_MESSAGE="${1:-Sin descripción de incidente proporcionada.}"
INCIDENT_DIR="logs/incident-logs"
mkdir -p "$INCIDENT_DIR"
FILE_PATH="$INCIDENT_DIR/incident_$(date +'%Y%m%d_%H%M%S').log"

cat > "$FILE_PATH" <<EOF
$(date '+%Y-%m-%d %H:%M:%S') - INCIDENTE
$INCIDENT_MESSAGE
EOF

echo "[INFO] Incidente registrado en $FILE_PATH"
