# UncheckedOverflow

## Descripción

La vulnerabilidad de overflow y underflow ocurre cuando operaciones aritméticas exceden los límites permitidos para un tipo numérico.  
En Solidity versiones anteriores a 0.8.0 esto ocurría automáticamente, mientras que en versiones modernas las comprobaciones están habilitadas por defecto. Sin embargo, el uso de bloques `unchecked` desactiva estas validaciones y puede reintroducir el problema.

## Contrato afectado

`contracts/vulnerable-examples/UncheckedOverflow.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en las funciones `add` y `subtract`.

```solidity
function add(uint256 value) external {
    unchecked {
        total += value;
    }
}
```

El bloque `unchecked` desactiva las comprobaciones automáticas de overflow de Solidity.

Si `total` tiene un valor cercano al máximo permitido para `uint256` y se suma un número adicional, el valor se reiniciará desde cero debido al desbordamiento aritmético.

Por ejemplo:

```solidity
total = type(uint256).max;
total += 1;
```

El resultado sería:

```solidity
total = 0;
```

La función `subtract` presenta el mismo problema.

```solidity
function subtract(uint256 value) external {
    unchecked {
        total -= value;
    }
}
```

Si se intenta restar un valor mayor que `total`, ocurrirá un underflow y el número se convertirá en un valor extremadamente grande.

Ejemplo:

```solidity
total = 0;
total -= 1;
```

El resultado sería:

```solidity
total = 2^256 - 1;
```

## Impacto

Un atacante podría manipular valores numéricos críticos del contrato, alterando balances, contadores o límites internos.  
Esto puede provocar corrupción del estado, bypass de validaciones lógicas y pérdidas económicas dependiendo de cómo se utilice la variable afectada.

## Cómo se podría mitigar

- Evitar el uso de bloques `unchecked` salvo que exista una razón muy específica y controlada.

- Utilizar las comprobaciones automáticas de Solidity 0.8+:

```solidity
total += value;
```

```solidity
total -= value;
```

- Validar explícitamente límites antes de realizar operaciones aritméticas críticas.

- Realizar auditorías de todas las operaciones matemáticas que utilicen `unchecked`.

## Resultado de herramientas

- **Slither** puede detectar el uso de bloques `unchecked` y advertir sobre posibles riesgos de overflow o underflow.

- **Slither** no puede determinar automáticamente si el uso de `unchecked` es seguro dentro de un contexto lógico específico o si existen validaciones externas que mitiguen el problema.

## Referencias

- https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic
- https://consensys.github.io/smart-contract-best-practices/attacks/insecure-arithmetic/
- https://github.com/crytic/slither