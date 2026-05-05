# Estudio inicial

## 1. Resumen de Ethereum

- qué es Ethereum;
   **Ethereum es básicamente una blockchain que funciona como un gran ordenador global.**
   **Todos los participantes de la red comparten ese “ordenador” (llamado EVM) y están de acuerdo en su estado.**

   **Esto permite que cualquiera pueda pedir que se ejecute código, y el resultado se guarda y se comparte con toda la red.**

- qué es una cuenta;
   **Una cuenta es donde se guarda información dentro de Ethereum, como el saldo de ETH.**

**Forman parte del estado global del sistema, y desde ellas se pueden enviar o recibir fondos y hacer operaciones.**

- qué es una transacción;
   **Una transacción es, en esencia, una petición para ejecutar algo en ese “ordenador global”.**

   **Por ejemplo:**
   **enviar dinero,**
   **desplegar un contrato,**
  **o ejecutar una función de un contrato.**

   **Cuando esa petición se valida y se ejecuta, cambia el estado del sistema y queda registrada para siempre.**



## 2. Resumen de contratos inteligentes

- qué es un contrato inteligente;
  **Un contrato inteligente es simplemente un programa que corre en la blockchain de Ethereum.**

- qué significa que un contrato viva en una dirección;
   **Significa que ese programa está almacenado en un lugar concreto de la blockchain (una dirección).**

   **Esa dirección funciona como su “identidad”:**
   **cuando alguien quiere usar el contrato, envía una transacción a esa dirección para ejecutar su código.**

- qué diferencia hay entre ejecutar código localmente y ejecutar código en blockchain;
   **Localmente: el código se ejecuta en tu ordenador y tú decides el resultado.**
   **En Ethereum: el código se ejecuta en ese “ordenador global” (EVM) y todos los nodos verifican y acuerdan el resultado.**

- por qué un error en un contrato inteligente puede ser grave.
   **Porque:**

   **los contratos no se pueden borrar ni modificar fácilmente,**
   **sus ejecuciones son irreversibles,**

   **Eso significa que si hay un fallo, el sistema lo ejecutará igual… y no hay forma sencilla de deshacerlo.**

## 3. Resumen de Solidity

Contrato

**Un contrato en Solidity es como una clase en programación orientada a objetos.**
**Puede contener variables, funciones, eventos, errores y más, y además puede heredar de otros contratos.**

Función

**Las funciones son bloques de código dentro del contrato que definen lo que el contrato puede hacer (por ejemplo, cambiar datos o devolver valores).**

Variable de estado

**Son variables cuyo valor se guarda en el almacenamiento del contrato, es decir, persisten en la blockchain entre llamadas.**

public, private, internal, external

**Son modificadores de visibilidad que indican quién puede acceder a funciones o variables dentro o fuera del contrato.**
**Forman parte de la definición de funciones y del acceso a ellas.**

view y pure

**Son tipos de funciones:**

**view: no modifica el estado, solo lo lee.**
**pure: no lee ni modifica el estado.**

**Sirven para indicar cómo interactúa la función con los datos del contrato.**

msg.sender

**Es una variable global que representa quién está llamando a la función (la dirección que envía la transacción).**

msg.value

**Es la cantidad de ether que se envía junto con la llamada a la función.**
**require**
**Es una forma de validar condiciones.**
**Si la condición no se cumple, la ejecución se detiene y se revierte la transacción.**

Eventos

**Los eventos son una forma de registrar información en los logs de la blockchain.**
**Las aplicaciones externas pueden escuchar esos eventos para reaccionar a lo que ocurre en el contrato.**

Constructor

**Es una función especial que se ejecuta solo una vez al desplegar el contrato y sirve para inicializar su estado.**

Mappings

**Son estructuras tipo clave → valor (como un diccionario).**
**No almacenan las claves directamente, sino que usan un hash para acceder a los valores.**

Arrays

**Son listas de elementos que pueden ser:**

**de tamaño fijo**
**o dinámico**

**Se accede a sus elementos por índice (empezando en 0).**

Structs

**Son tipos de datos que permiten agrupar varias variables bajo una sola estructura.**

Herencia

**Los contratos pueden heredar de otros contratos, reutilizando su código y extendiendo funcionalidades.**

Llamadas externas

**Son llamadas a funciones de otros contratos.**
**Solidity incluso permite manejar errores en estas llamadas con try/catch.**

Transferencias de ether

**Los contratos pueden enviar ether a otras direcciones durante su ejecución, como parte de las operaciones del contrato.**

Errores y revert

**Cuando ocurre un error:**

**se puede usar revert o require,**
**y se deshacen todos los cambios de la transacción.**

**No hace falta dominar Solidity para hacer el proyecto, pero sí entender el código básico que vais a analizar.**

## 4. Herramientas de desarrollo

¿Qué es un framework de desarrollo de smart contracts?

**Es un conjunto de herramientas que te ayudan a desarrollar contratos inteligentes de principio a fin.**

**Por ejemplo, tanto Foundry como Hardhat permiten:**

**compilar,**
**testear,**
**desplegar,**
**y depurar contratos.**

**Es decir, te dan todo lo necesario para trabajar sin hacerlo todo manualmente.**

¿Para qué sirve compilar?

**Compilar significa convertir el código Solidity en algo que la blockchain puede ejecutar (bytecode).**

**Además:**

**verifica que el código no tenga errores,**
**y genera archivos necesarios como el ABI.**

**Sin compilar, el contrato no se puede desplegar ni ejecutar.**

¿Para qué sirven los tests?

**Los tests sirven para comprobar que el contrato funciona correctamente y detectar errores antes de usarlo en producción.**

**Permiten:**

**probar funciones concretas,**
**asegurar que el comportamiento es el esperado,**
**y evitar bugs antes de desplegar.**

**En Foundry, por ejemplo, puedes ejecutar tests directamente con forge test.**

¿Qué diferencia hay entre Foundry y Hardhat?

**Ambos hacen cosas muy parecidas (compilar, testear, desplegar), pero tienen enfoques distintos:**

Foundry:
toolkit en Rust,
   muy rápido,
   permite testear directamente en Solidity,
   incluye herramientas como forge, cast y anvil.
Hardhat:
   entorno basado en JavaScript/TypeScript,
   muy extensible con plugins,
   usa herramientas externas para tests (como Mocha),
   integra todo en un flujo automatizado.

¿Qué es una red local de pruebas?

**Es una blockchain que corre en tu propio ordenador para probar contratos sin usar la red real.**

¿Por qué es útil automatizar comandos?

**Porque muchas tareas se repiten constantemente:**

**compilar,**
**testear,**
**desplegar…**

**Herramientas como Hardhat permiten automatizar estos procesos y ejecutarlos con comandos, ahorrando tiempo y evitando errores manuales.**

## 5. Herramientas de análisis de seguridad

- vulnerabilidad
  
   **Es un fallo o debilidad en un contrato inteligente que puede ser explotado para producir un comportamiento no deseado o inseguro.**



- auditoría
  
   **Es el proceso de revisar contratos inteligentes para identificar vulnerabilidades, problemas de lógica o malas prácticas antes de su despliegue.**



- análisis estático
  
   **Es el análisis del código sin ejecutarlo, para detectar patrones de vulnerabilidades y errores directamente en el código fuente.**



- análisis dinámico
  
   **Es el análisis del comportamiento del contrato durante su ejecución, observando cómo responde en diferentes escenarios o inputs.**



- falso positivo
  
   **Es un resultado de una herramienta que indica un problema que en realidad no es una vulnerabilidad real.**



- severidad
  
   **Es una medida de la gravedad de una vulnerabilidad, normalmente basada en su impacto y probabilidad de explotación.**



- impacto
  
   **Es el efecto o consecuencia que puede tener una vulnerabilidad si es explotada, como pérdida de fondos o control del contrato.**



- recomendación
  
   **Es la sugerencia de cómo corregir o mitigar una vulnerabilidad detectada en el contrato.**



- prueba de concepto
  
   **Es un ejemplo práctico que demuestra que una vulnerabilidad puede ser explotada.**

## 6. Vulnerabilidades comunes

| Vulnerabilidad | Explicación | Ejemplo | Posible impacto |
|---------------|-------------|---------|-----------------|
| Reentrancy | Es una vulnerabilidad en la que un contrato externo vuelve a llamar a una función antes de que la ejecución anterior haya terminado, pudiendo alterar el estado de forma inesperada. | Un contrato de billetera permite retiros, pero un atacante llama recursivamente al retiro antes de actualizar el saldo, drenando fondos. | Pérdida total de fondos del contrato, ya que el atacante puede extraer más ether del esperado. |
| Control de acceso | Es el mecanismo que restringe qué direcciones o usuarios pueden ejecutar ciertas funciones del contrato. | Una función administrativa no verifica si el llamante es el propietario, permitiendo a cualquiera cambiar configuraciones críticas. | Toma de control del contrato, modificación no autorizada de estado o ejecución de funciones privilegiadas. |
| Integer precision / pérdida de precisión | Es un problema derivado del manejo de números enteros, donde pueden ocurrir errores de precisión o redondeo en operaciones matemáticas. | En una operación de división, el resultado se trunca, causando cálculos incorrectos en balances o porcentajes. | Pérdida financiera para usuarios, como recibir menos tokens de lo esperado o cálculos erróneos en contratos financieros. |
| Uso incorrecto de tx.origin | Es una mala práctica de seguridad donde se utiliza `tx.origin` para autenticación, lo que puede ser explotado mediante llamadas intermedias. | Un contrato usa `tx.origin` para verificar el propietario, pero un contrato malicioso llama a través de un intermediario, pasando la verificación. | Acceso no autorizado a funciones restringidas, permitiendo a atacantes impersonar usuarios legítimos. |
| Llamadas externas | Son interacciones con otros contratos que pueden introducir riesgos, especialmente si el contrato externo ejecuta código inesperado. | Un contrato llama a una función externa sin manejar fallos, y el contrato externo revierte, dejando el estado inconsistente. | Revertir transacciones inesperadas, pérdida de gas o exposición a ataques si el contrato externo es malicioso. |
| Oráculos | Son fuentes externas de datos que los contratos utilizan para obtener información fuera de la blockchain, lo que puede introducir riesgos si no son fiables. | Un contrato de apuestas usa un oráculo manipulado para obtener precios, permitiendo a un atacante influir en los resultados. | Manipulación de datos, resultados injustos en contratos dependientes de datos externos, como pérdidas financieras. |
| Dependencias inseguras | Son librerías o contratos externos utilizados que pueden contener vulnerabilidades o comportamientos no seguros. | Un contrato importa una librería con una función vulnerable a overflow, exponiendo el contrato principal. | Herencia de vulnerabilidades, compromisos de seguridad en todo el contrato que depende de la librería insegura. |

## 7. Glosario

Lista de términos nuevos aprendidos.

- EVM (Ethereum Virtual Machine): Máquina virtual que ejecuta contratos en Ethereum.
- ABI (Application Binary Interface): Interfaz para interactuar con contratos inteligentes.
- tx.origin: Dirección que inició la transacción original.
- msg.sender: Dirección del llamante de la función actual.
- msg.value: Cantidad de ether enviada con la llamada.

## 8. Dudas abiertas

Preguntas que todavía no sabemos responder.

- ¿Cómo se puede lograr una escalabilidad en blockchains públicas sin comprometer la seguridad y descentralización?
- ¿Cuáles son las principales barreras para integrar tecnologías blockchain con sistemas tradicionales, como bases de datos centralizadas?

## 9. Recursos consultados

Lista de enlaces consultados.

1. https://ethereum.org/developers/docs/ - Documentación general de Ethereum para desarrolladores.
2. https://ethereum.org/developers/docs/smart-contracts/ - Guía sobre contratos inteligentes en Ethereum.
3. https://ethereum.org/developers/docs/smart-contracts/anatomy/ - Anatomía de contratos inteligentes.
4. https://soliditylang.org/ - Sitio oficial de Solidity.
5. https://docs.soliditylang.org/ - Documentación completa de Solidity.
6. https://solidity-by-example.org/ - Ejemplos prácticos de Solidity.
7. https://docs.soliditylang.org/en/latest/solidity-by-example.html - Más ejemplos en la documentación de Solidity.
8. https://getfoundry.sh/ - Sitio oficial de Foundry.
9. https://getfoundry.sh/introduction/installation - Instalación de Foundry.
10. https://getfoundry.sh/projects/creating-a-new-project - Creación de proyectos con Foundry.
11. https://getfoundry.sh/forge/writing-tests - Escritura de tests con Forge.
12. https://hardhat.org/docs/getting-started - Inicio con Hardhat.
13. https://hardhat.org/docs/tutorial - Tutorial de Hardhat.
14. https://hardhat.org/docs/tutorial/setup - Configuración de Hardhat.
15. https://github.com/crytic/building-secure-contracts - Guía para construir contratos seguros.
16. https://crytic.github.io/slither/slither.html - Documentación de Slither.
17. https://github.com/crytic/slither - Repositorio de Slither en GitHub.
18. https://ethernaut.openzeppelin.com/ - Ethernaut para aprender seguridad en contratos.
19. https://www.damnvulnerabledefi.xyz/ - Damn Vulnerable DeFi para prácticas de seguridad.
20. https://docs.openzeppelin.com/contracts/ - Documentación de contratos de OpenZeppelin.