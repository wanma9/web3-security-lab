# UnsafeExternalCall

## Descripción

La vulnerabilidad de llamadas externas inseguras ocurre cuando un contrato ejecuta llamadas arbitrarias hacia otro contrato sin validar adecuadamente el destino, los datos enviados o los permisos del usuario.  
Esto puede permitir la ejecución de código malicioso, manipulación del flujo del contrato o comportamientos inesperados.

## Contrato afectado

`contracts/vulnerable-examples/UnsafeExternalCall.sol`

## Por qué es vulnerable

La vulnerabilidad se encuentra en la función `execute`.

```solidity
function execute(bytes calldata data) external {
```

La función permite que cualquier usuario envíe datos arbitrarios para ejecutar una llamada externa.

```solidity
    // Llamada externa insegura
    (bool success, ) = target.call(data);
```

El contrato utiliza `call` para ejecutar directamente cualquier payload sobre la dirección almacenada en `target`.

El problema es que:

- No existe control de acceso.
- No se validan los datos enviados.
- Se permite ejecución arbitraria de funciones en el contrato externo.

Un atacante podría invocar funciones sensibles del contrato objetivo si este posee privilegios, fondos o lógica crítica.

Además, `call` transfiere completamente el control de ejecución al contrato externo, lo que puede introducir riesgos adicionales como:

- Reentrancia.
- Ejecución inesperada.
- Manipulación de estado.
- Denegación de servicio.

```solidity
    require(success, "Call failed");
}
```

La única validación realizada es comprobar si la llamada no falló técnicamente, pero no existe ninguna restricción de seguridad sobre qué función puede ejecutarse.

## Impacto

Un atacante podría ejecutar funciones arbitrarias sobre contratos externos utilizando este contrato como intermediario.  
Dependiendo del privilegio del contrato objetivo, esto podría provocar robo de fondos, modificación de estados críticos o ejecución de lógica maliciosa.

## Cómo se podría mitigar

- Restringir el acceso a la función mediante controles de permisos.

```solidity
require(msg.sender == owner, "Not authorized");
```

- Evitar el uso de `call` arbitrario siempre que sea posible.

- Utilizar interfaces explícitas en lugar de llamadas dinámicas.

Ejemplo:

```solidity
ITarget(target).safeFunction();
```

- Validar funciones permitidas mediante listas blancas.

- Minimizar privilegios y revisar cuidadosamente cualquier interacción externa.

## Resultado de herramientas

- **Slither** puede detectar el uso de llamadas de bajo nivel (`call`) y advertir sobre posibles riesgos de ejecución arbitraria o llamadas externas inseguras.

- **Slither** no puede determinar automáticamente si el contrato objetivo es malicioso ni evaluar completamente el impacto lógico de las funciones invocadas.

## Referencias

- https://docs.soliditylang.org/en/latest/security-considerations.html#external-calls
- https://consensys.github.io/smart-contract-best-practices/development-recommendations/general/external-calls/
- https://github.com/crytic/slither