# Fase 4: Primer proyecto Solidity

En esta fase crearéis o incorporaréis contratos sencillos para probar el entorno.

## 4.1. Opción recomendada

Crear una carpeta:

```text
contracts/vulnerable-examples/
```

Dentro, añadid contratos pequeños que representen vulnerabilidades básicas.

Ejemplos:

- contrato con control de acceso incorrecto;
- contrato con posible reentrancy;
- contrato que usa `tx.origin`;
- contrato con pérdida de precisión;
- contrato con una llamada externa insegura.

Cada contrato debe ir acompañado de una explicación sencilla.

Ejemplo:

```text
contracts/vulnerable-examples/
├── AccessControlBug.sol
├── ReentrancyExample.sol
├── TxOriginExample.sol
└── PrecisionLossExample.sol
```

## 4.2. Documentación de cada ejemplo

Para cada contrato vulnerable, cread una ficha en:

```text
docs/vulnerabilities/
```

Ejemplo:

```text
docs/vulnerabilities/reentrancy.md
```

Plantilla:

```markdown
# Reentrancy

## Descripción

Explicación sencilla de la vulnerabilidad.

## Contrato afectado

`contracts/vulnerable-examples/ReentrancyExample.sol`

## Por qué es vulnerable

Explicación línea a línea o por bloques.

## Impacto

Qué podría pasar si esto estuviera en producción.

## Cómo se podría mitigar

Recomendaciones básicas.

## Resultado de herramientas

Qué detecta Slither y qué no detecta.

## Referencias

Enlaces utilizados.
```

# Fase 5: Análisis con Slither

Slither será la herramienta principal de análisis estático.

## 5.1. Objetivo

Conseguir ejecutar Slither sobre los contratos del laboratorio y guardar los resultados.

Ejemplo de comandos:

```bash
slither contracts/vulnerable-examples/
```

O, si se usa un proyecto Foundry:

```bash
slither .
```

Salida en JSON:

```bash
mkdir -p reports/slither
slither . --json reports/slither/slither-results.json
```

Salida en texto:

```bash
slither . > reports/slither/slither-results.txt
```

## 5.2. Qué debéis documentar

En:

```text
docs/03-herramientas-analizadas.md
```

Incluid:

```markdown
# Herramienta analizada: Slither

## Qué es

Slither es una herramienta de análisis estático para contratos inteligentes escritos en Solidity.  
Permite detectar errores, vulnerabilidades y malas prácticas sin necesidad de ejecutar el contrato.

---

## Para qué sirve

Se utiliza para revisar la seguridad del código y encontrar posibles problemas antes de desplegar un smart contract.

Algunas cosas que puede detectar:

- Reentrancy
- Uso inseguro de `tx.origin`
- Variables sin inicializar
- Dependencia de timestamps
- Problemas de visibilidad
- Llamadas externas peligrosas

---

## Cómo se instala

```bash
pip install slither-analyzer
```

Comprobar instalación:

```bash
slither --version
```

---

## Cómo se ejecuta

Analizar un contrato:

```bash
slither contrato.sol
```

Analizar un proyecto completo:

```bash
slither .
```

Ejecutar un detector concreto:

```bash
slither contrato.sol --detect reentrancy
```

---

## Qué tipo de resultados genera

Slither genera warnings e información sobre posibles vulnerabilidades.

Ejemplo:

```text
Reentrancy in withdraw(uint256)
Severity: High
Confidence: Medium
```

También puede exportar resultados en JSON y mostrar métricas del contrato.

---

## Ejemplo de finding

Código vulnerable:

```solidity
function withdraw(uint amount) public {
    require(balance[msg.sender] >= amount);

    (bool success,) = msg.sender.call{value: amount}("");
    require(success);

    balance[msg.sender] -= amount;
}
```

Problema detectado:

La llamada externa ocurre antes de actualizar el balance, lo que puede provocar una vulnerabilidad de reentrancy.

Posible solución:

Actualizar primero el balance y después realizar la llamada externa.

---

## Limitaciones

- No detecta todas las vulnerabilidades.
- Puede generar falsos positivos.
- No sustituye una auditoría manual.
- Algunos warnings no son realmente explotables.

---

## Problemas encontrados

- Errores con versiones de Solidity.
- Dependencias faltantes de `solc`.
- Muchos warnings en proyectos grandes.
- Resultados difíciles de interpretar al principio.

---

## 5.3. Importante: no todo warning es una vulnerabilidad

Una herramienta puede avisar de cosas que no son explotables. Eso se llama **falso positivo**.

Por cada finding relevante, intentad responder:

- ¿qué dice la herramienta?
- ¿dónde está el problema?
- ¿entiendo el motivo?
- ¿es realmente grave?
- ¿cómo se arreglaría?
- ¿hay un falso positivo?

---

## Conclusión

Slither es una herramienta muy útil para analizar contratos inteligentes en Solidity y detectar posibles problemas de seguridad de forma rápida.

Aun así, los resultados deben revisarse manualmente porque no todos los warnings representan vulnerabilidades reales.
