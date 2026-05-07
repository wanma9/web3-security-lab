# SimpleReentrancy

## Descripción

La vulnerabilidad de reentrancia ocurre cuando un contrato realiza una llamada externa antes de actualizar su estado interno. Un atacante puede aprovechar esto para volver a ejecutar la función vulnerable múltiples veces antes de que el balance sea actualizado, retirando más fondos de los que realmente posee.

## Contrato afectado

`contracts/vulnerable-examples/ReentrancyExample.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en la función `withdraw`.

```solidity
function withdraw(uint256 amount) external {
    require(balances[msg.sender] >= amount, "Insufficient balance");
```

Primero se verifica que el usuario tenga saldo suficiente.

```solidity
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
```

Después se realiza una llamada externa usando `call`.  
El problema es que esta llamada transfiere Ether al `msg.sender` antes de actualizar el balance interno del contrato.

Si `msg.sender` es un contrato malicioso, su función `receive()` o `fallback()` puede volver a llamar a `withdraw()` antes de que el balance sea reducido.

```solidity
    balances[msg.sender] -= amount;
}
```

El balance se actualiza demasiado tarde, permitiendo múltiples retiros utilizando el mismo saldo.

## Impacto

Un atacante podría drenar todos los fondos del contrato mediante llamadas recursivas, incluso aunque solo tenga un pequeño balance depositado.  
Este tipo de vulnerabilidad ha provocado pérdidas millonarias en contratos reales, como ocurrió en el ataque a The DAO en Ethereum.

## Cómo se podría mitigar

- Aplicar el patrón **Checks-Effects-Interactions**:
  - Verificar condiciones.
  - Actualizar el estado.
  - Realizar llamadas externas al final.

- Actualizar el balance antes de enviar Ether:

```solidity
balances[msg.sender] -= amount;

(bool success, ) = msg.sender.call{value: amount}("");
require(success, "Transfer failed");
```

- Utilizar `ReentrancyGuard` de OpenZeppelin y el modificador `nonReentrant`.

- Evitar llamadas externas innecesarias cuando sea posible.

## Resultado de herramientas

- **Slither** detecta esta vulnerabilidad como `reentrancy-vulnerability` o `reentrancy-eth`, ya que identifica que existe una llamada externa antes de modificar el estado.

- **Slither** no puede determinar automáticamente el impacto económico real ni si existe un contrato atacante desplegado, solamente detecta el patrón inseguro en el flujo del contrato.

## Referencias

- https://docs.soliditylang.org/en/latest/security-considerations.html#reentrancy
- https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/
- https://github.com/crytic/slither