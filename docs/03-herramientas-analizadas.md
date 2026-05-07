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
# Herramientas analizadas

## Slither

- Qué es

- Para qué sirve

- Cómo se instala

- Cómo se ejecuta

- Qué tipo de resultados genera

- Ejemplo de finding

- Limitaciones

- Problemas encontrados

- Conclusión
```

## 5.3. Importante: no todo warning es una vulnerabilidad

Una herramienta puede avisar de cosas que no son explotables. Eso se llama **falso positivo**.

Por cada finding relevante, intentad responder:

- ¿qué dice la herramienta?
- ¿dónde está el problema?
- ¿entiendo el motivo?
- ¿es realmente grave?
- ¿cómo se arreglaría?
- ¿hay un falso positivo?
