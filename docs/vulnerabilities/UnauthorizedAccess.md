# UnauthorizedAccess

## Descripción

La vulnerabilidad de acceso no autorizado ocurre cuando funciones sensibles pueden ser ejecutadas por cualquier usuario sin restricciones. Esto permite que actores maliciosos modifiquen estados críticos del contrato o accedan a funcionalidades privilegiadas.

## Contrato afectado

`contracts/vulnerable-examples/UnauthorizedAccess.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en la función `setAllowance`.

```solidity
function setAllowance(address user, uint256 amount) external {
```

La función está declarada como `external`, por lo que cualquier dirección puede llamarla.

```solidity
    // Falta control de acceso: cualquier usuario puede cambiar la asignación
    allowances[user] = amount;
}
```

No existe ninguna validación que limite el acceso al propietario del contrato ni a usuarios autorizados.  
Como resultado, cualquier atacante puede asignarse permisos arbitrarios modificando directamente el mapping `allowances`.

Por ejemplo, un atacante podría ejecutar:

```solidity
setAllowance(attackerAddress, 100 ether);
```

Después, podría retirar esos fondos usando:

```solidity
withdraw(100 ether);
```

La función `withdraw` únicamente verifica el valor almacenado en `allowances`.

```solidity
require(allowances[msg.sender] >= amount, "Allowance exceeded");
```

Debido a que el atacante puede modificar libremente su asignación, la validación pierde completamente su utilidad de seguridad.

## Impacto

Un atacante podría otorgarse permisos ilimitados y retirar todos los fondos almacenados en el contrato.  
Esto compromete completamente la integridad del sistema y provoca pérdida total de fondos si el contrato contiene Ether.

## Cómo se podría mitigar

- Restringir el acceso a funciones sensibles usando validaciones de permisos.

- Permitir únicamente al propietario modificar asignaciones:

```solidity
require(msg.sender == owner, "Not authorized");
```

- Utilizar modificadores de acceso como `onlyOwner`.

Ejemplo:

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not authorized");
    _;
}
```

Y aplicar el modificador:

```solidity
function setAllowance(address user, uint256 amount) external onlyOwner {
    allowances[user] = amount;
}
```

- Utilizar librerías auditadas como `Ownable` de OpenZeppelin.

## Resultado de herramientas

- **Slither** puede detectar este problema mediante análisis de control de acceso, identificando funciones críticas que modifican variables sensibles sin restricciones adecuadas.

- **Slither** no puede determinar automáticamente la intención lógica del desarrollador ni si la ausencia de permisos es deliberada o accidental.

## Referencias

- https://docs.soliditylang.org/en/latest/security-considerations.html
- https://consensys.github.io/smart-contract-best-practices/development-recommendations/access-control/
- https://github.com/crytic/slither