# Diseño del laboratorio

## 1. Objetivo del laboratorio

El objetivo principal del laboratorio es instalar y configurar la herramienta Slither para el análisis de seguridad en contratos inteligentes de Solidity, y documentar el proceso completo de instalación y uso. Esto permitirá a los usuarios del laboratorio realizar análisis estáticos de vulnerabilidades en contratos inteligentes de manera efectiva, contribuyendo al aprendizaje y práctica de seguridad en el ecosistema Web3, el ejemplo de prueba del laboratorio se realizará en el sistema Ubuntu 24.04.

## 2. Herramientas seleccionadas

- **Python**: Lenguaje de programación requerido para ejecutar Slither, ya que está desarrollado en Python.
  - **Comandos de instalación**:
    ```
    sudo apt update;
    sudo apt install python3 python3-pip pipx;
    ```

- **Slither**: Analizador estático de seguridad para contratos inteligentes en Solidity. Es la herramienta principal para detectar vulnerabilidades comunes como reentrancy, overflow/underflow, y otros problemas de seguridad.
  - **Comandos de instalación**:
    ```
    sudo apt update;
    sudo apt install python3 python3-pip pipx;
    sudo snap install solc;
    pipx install slither-analyzer
    ```

- **Docker**: Utilizado para contenerizar el entorno de ejecución de Slither, facilitando la instalación y evitando conflictos de dependencias.
  - **Comandos de instalación** (para Ubuntu/Debian):
    ```
    sudo apt update;
    sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release;
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
    sudo apt install docker-ce docker-ce-cli containerd.io;
    sudo usermod -aG docker $USER
    ```

- **Git**: Para clonar repositorios y gestionar versiones de contratos de ejemplo.
  - **Comandos de instalación**:
    ```
    sudo apt update;
    sudo apt install git
    ```

- **Herramientas de logging**: Scripts internos para guardar logs de ejecución en `logs/execution-logs/`, reportes en `reports/slither/` y registros de incidentes en `logs/incident-logs/`.
  - Scripts:
    - `scripts/log_slither_execution.sh`
    - `scripts/save_incident_log.sh`
  - Uso típico:
    ```
    bash scripts/log_slither_execution.sh <Ruta_del_contrato>
    bash scripts/save_incident_log.sh <"Mensaje_de_error">
    ```

## 3. Contratos o proyectos de ejemplo

Se utilizarán los contratos inteligentes ubicados en la carpeta `contracts/vulnerable-examples/`. Estos contratos contienen ejemplos intencionalmente vulnerables para demostrar las capacidades de detección de Slither. Los contratos incluyen casos como:
- Contratos con vulnerabilidades de reentrancy.
- Ejemplos de overflow/underflow.
- Contratos con problemas de acceso no autorizado.

Contratos de prueba incluidos:
- `contracts/vulnerable-examples/SimpleReentrancy.sol`
- `contracts/vulnerable-examples/UncheckedOverflow.sol`
- `contracts/vulnerable-examples/UnauthorizedAccess.sol`

## 4. Flujo de uso previsto

El flujo de uso para una persona usuaria del laboratorio será el siguiente:
1. Revisar la documentación oficial de Slither.
2. Instalar las dependencias necesarias (Python, Docker, etc.).
3. Ejecutar Slither sobre un contrato de prueba seleccionado de `contracts/vulnerable-examples/`.
4. Guardar la salida del análisis en la carpeta `reports/slither/`.
5. Documentar cualquier error encontrado durante el proceso en `logs/execution-logs/` o `logs/incident-logs/`.
6. Actualizar la documentación en `docs/01-instalacion-entorno.md` con lecciones aprendidas o mejoras.

## 5. Resultados esperados

- Una instalación funcional de Slither que permita ejecutar análisis sin errores.
- Reportes de análisis guardados en `reports/slither/` con detección de vulnerabilidades en contratos de ejemplo.
- Documentación actualizada y clara que permita a otra persona replicar el proceso sin dificultades.
- Logs de ejecución que registren el proceso y cualquier incidente para análisis posterior.
- Criterio de finalización: Otra persona puede seguir la guía y ejecutar Slither correctamente sobre contratos de ejemplo.

## 6. Riesgos técnicos

- **Problemas de compatibilidad**: Versiones incompatibles de Python o Docker pueden causar errores durante la instalación o ejecución.
- **Dependencias faltantes**: Falta de bibliotecas requeridas (como solc para compilación de Solidity) puede impedir el funcionamiento de Slither.
- **Errores en contratos**: Los contratos de ejemplo pueden tener sintaxis incorrecta o incompatibilidades que generen falsos positivos/negativos en el análisis.
- **Limitaciones de Docker**: En entornos Windows, Docker puede tener problemas de configuración o permisos.
- **Cambios en herramientas**: Actualizaciones de Slither o sus dependencias pueden romper la compatibilidad con la guía documentada.
- **Rendimiento**: Análisis de contratos grandes pueden consumir recursos significativos, potencialmente causando timeouts o errores de memoria.

## 7. Decisiones tomadas

- **Selección de Slither**: Elegido por ser la herramienta estándar y más utilizada en la comunidad de seguridad de contratos inteligentes, con soporte activo y amplia documentación.
- **Uso de Docker**: Para simplificar la instalación y evitar conflictos de entorno, especialmente en sistemas Windows.
- **Contratos de ejemplo**: Utilizar contratos vulnerables internos en lugar de externos para mantener el control y la consistencia del laboratorio.
- **Estructura de carpetas**: Organizar outputs en `reports/slither/`, `logs/execution-logs/`, y `logs/incident-logs/` para una separación clara de resultados y debugging.
- **Documentación en español**: Dado que el proyecto está en español, mantener la documentación en este idioma para accesibilidad.
- **Enfoque en instalación**: Priorizar la documentación del proceso de instalación sobre análisis avanzados, ya que es el primer paso para usuarios principiantes.

## Objetivo

Instalar Slither y documentar el proceso.

## Tareas

- [ ] Revisar documentación oficial.
- [ ] Instalar dependencias.
- [ ] Ejecutar Slither sobre un contrato de prueba.
- [ ] Guardar salida en `reports/slither/`.
- [ ] Documentar errores encontrados.
- [ ] Actualizar `docs/01-instalacion-entorno.md`.

## Criterio de finalización

Otra persona puede seguir la guía y ejecutar Slither correctamente.