# PrecisionLoss

## Descripción

La pérdida de precisión ocurre cuando se realizan divisiones enteras en Solidity.  
Dado que Solidity no maneja decimales en operaciones con enteros, cualquier parte fraccionaria del resultado se descarta automáticamente, lo que puede generar errores lógicos o cálculos financieros incorrectos.

## Contrato afectado

`contracts/vulnerable-examples/PrecisionLoss.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en la función `tokensPerUser`.

```solidity
function tokensPerUser() external view returns (uint256) {
```

La función calcula cuántos tokens corresponden a cada usuario.

```solidity
    // Perdida de precision por division entera
    return totalTokens / totalUsers;
}
```

En Solidity, la división entre enteros siempre devuelve un número entero.  
Cualquier valor decimal es truncado.

Con los valores actuales:

```solidity
totalTokens = 100;
totalUsers = 3;
```

El cálculo real sería:

```text
100 / 3 = 33.333333...
```

Sin embargo, Solidity devuelve:

```solidity
33
```

El valor decimal restante se pierde completamente.

Esto puede provocar inconsistencias acumulativas en contratos financieros, sistemas de recompensas o distribución de tokens.

## Impacto

La pérdida de precisión puede generar distribuciones incorrectas de fondos o tokens, diferencias contables y errores acumulativos en cálculos financieros.  
En protocolos DeFi o contratos con lógica económica compleja, este tipo de error puede afectar balances y provocar pérdidas económicas.

## Cómo se podría mitigar

- Utilizar escalado con decimales artificiales (fixed-point arithmetic).

Ejemplo:

```solidity
uint256 precision = 1e18;
return (totalTokens * precision) / totalUsers;
```

- Utilizar librerías matemáticas especializadas para precisión decimal.

- Diseñar mecanismos de distribución que contemplen residuos o sobrantes.

- Validar cuidadosamente cualquier operación de división en lógica financiera.

## Resultado de herramientas

- **Slither** puede advertir sobre posibles pérdidas de precisión en operaciones aritméticas, especialmente divisiones enteras que afectan cálculos financieros.

- **Slither** no puede determinar automáticamente si la pérdida de precisión representa un problema real de negocio o si el truncamiento es intencional.

## Referencias

- https://docs.soliditylang.org/en/latest/types.html#division
- https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/integer-division/
- https://github.com/crytic/slither