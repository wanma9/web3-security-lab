# TxOriginVulnerable

## Descripción

La vulnerabilidad por uso de `tx.origin` ocurre cuando un contrato utiliza esta variable para autenticar usuarios sensibles en lugar de `msg.sender`.  
Un atacante puede engañar al propietario para que interactúe con un contrato malicioso que luego invoque funciones vulnerables, permitiendo bypass de controles de acceso.

## Contrato afectado

`contracts/vulnerable-examples/TxOriginVulnerable.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en la función `withdrawAll`.

```solidity
function withdrawAll() external {
    require(tx.origin == owner, "Not owner");
```

El contrato utiliza `tx.origin` para verificar si la transacción fue iniciada por el propietario.

El problema es que `tx.origin` representa la dirección original que inició toda la transacción, no el contrato o cuenta que llama directamente a la función.

Un atacante puede crear un contrato malicioso que invoque `withdrawAll()` internamente.

Escenario de ataque:

1. El propietario interactúa accidentalmente con el contrato malicioso.
2. El contrato malicioso llama a `withdrawAll()` del contrato vulnerable.
3. `tx.origin` sigue siendo la dirección del propietario.
4. La validación se cumple incorrectamente.

```solidity
    (bool success, ) = payable(msg.sender).call{
        value: address(this).balance
    }("");
```

Los fondos se envían a `msg.sender`, que en este caso sería el contrato malicioso controlado por el atacante.

## Impacto

Un atacante podría robar todos los fondos del contrato engañando al propietario para ejecutar una transacción aparentemente legítima.  
Este tipo de vulnerabilidad permite bypass completo de autenticación basada en privilegios.

## Cómo se podría mitigar

- Nunca utilizar `tx.origin` para controles de acceso.

- Utilizar `msg.sender` para autenticar llamadas:

```solidity
require(msg.sender == owner, "Not owner");
```

- Implementar patrones de autorización robustos usando `Ownable` de OpenZeppelin.

- Limitar interacciones con contratos externos no confiables.

## Resultado de herramientas

- **Slither** detecta este problema mediante la regla `tx-origin`, identificando el uso inseguro de `tx.origin` en validaciones críticas.

- **Slither** no puede determinar automáticamente si existe un flujo explotable real ni identificar contratos maliciosos específicos que puedan abusar de esta lógica.

## Referencias

- https://docs.soliditylang.org/en/latest/security-considerations.html#tx-origin
- https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/tx-origin/
- https://github.com/crytic/slither