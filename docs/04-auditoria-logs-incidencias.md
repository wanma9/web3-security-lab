# Auditoría de logs e incidencias

## 1. Fuentes de logs revisadas

- GitHub Actions
- Docker
- Slither
- Foundry
- Scripts propios
- Logs generados por Bash
- Errores de compilación Solidity

---

## 2. Incidencias detectadas

| ID | Fecha | Fuente | Descripción | Causa | Solución | Estado |
|---|---|---|---|---|---|---|
| INC-001 | 2026-05-07 | Slither | Error al analizar contrato Solidity | El archivo `.sol` no existía en la ruta indicada | Verificar la ruta antes de ejecutar el script | Resuelta |
| INC-002 | 2026-05-07 | Slither | Error de compilación del contrato | Versión de Solidity incompatible | Configurar versión correcta de `solc` | Resuelta |
| INC-003 | 2026-05-07 | Script Bash | El script terminaba inmediatamente | `set -euo pipefail` detenía la ejecución ante errores | Revisar variables y comandos antes de ejecutar | Resuelta |
| INC-004 | 2026-05-07 | Logs | No existían directorios de salida | Carpetas `reports/` y `logs/` no creadas | Uso de `mkdir -p` en el script | Resuelta |
| INC-005 | 2026-05-07 | Slither | Warning de posible reentrancy | Llamada externa antes de actualizar balance | Aplicar patrón Checks-Effects-Interactions | Revisada |

---

## 3. Ejemplos de logs

### Ejemplo de ejecución correcta

```text
[INFO] Ejecutando Slither sobre: contracts/SimpleReentrancy.sol
[INFO] Contrato: SimpleReentrancy
[INFO] Reporte: reports/slither/slither_SimpleReentrancy_20260507_120000.json
```

### Ejemplo de error por contrato inexistente

```text
[ERROR] El archivo del contrato no existe: contracts/Test.sol
```

### Ejemplo de warning detectado por Slither

```text
Reentrancy in withdraw(uint256)
Severity: High
Confidence: Medium
```

### Ejemplo de error de compilación

```text
Error: Source file requires different compiler version
```

---

## 4. Análisis del script utilizado

El script automatiza la ejecución de Slither sobre contratos Solidity y almacena tanto el reporte JSON como los logs de ejecución.

Características principales:

- Validación de parámetros.
- Verificación de existencia del contrato.
- Creación automática de directorios.
- Generación de logs con timestamp.
- Exportación de reportes JSON.
- Manejo básico de errores.

También utiliza:

```bash
set -euo pipefail
```

Esto mejora la seguridad del script porque:

- `-e` detiene el script si ocurre un error.
- `-u` evita variables no definidas.
- `pipefail` detecta errores dentro de pipes.

---

## 5. Buenas prácticas aplicadas

- No eliminar errores sin documentarlos.
- Guardar logs de cada ejecución.
- Separar reportes y logs.
- Añadir timestamps para trazabilidad.
- Revisar warnings antes de considerarlos vulnerabilidades reales.

---

## 6. Conclusiones

La revisión de logs permitió identificar errores de configuración, problemas de compilación y warnings de seguridad detectados por Slither.

Además, el uso de logs facilita:

- Depuración de errores.
- Repetición de pruebas.
- Auditoría de ejecuciones.
- Seguimiento de incidencias.

Se comprobó que no todos los warnings detectados representan vulnerabilidades reales, por lo que es necesario revisar manualmente cada finding antes de considerarlo crítico.