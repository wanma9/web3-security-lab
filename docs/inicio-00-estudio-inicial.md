# Proyecto: Laboratorio online de seguridad Web3

## 1. Contexto del proyecto

Durante las prácticas trabajaréis en la creación de un **laboratorio online de seguridad Web3**. El objetivo no es trabajar con proyectos reales de clientes ni con infraestructura interna de la empresa, sino construir un entorno de aprendizaje técnico, reproducible y documentado que permita:

- instalar herramientas habituales del ecosistema Ethereum/Solidity;
- ejecutar análisis básicos sobre contratos inteligentes vulnerables de ejemplo;
- automatizar esas ejecuciones;
- recoger resultados, logs e incidencias;
- almacenar parte de la información en una base de datos;
- generar documentación clara para que otra persona pueda repetir vuestro trabajo.

Este proyecto está pensado para hacerse **100% online**, usando GitHub para el trabajo técnico y la documentación, y Teams/Meet para la comunicación y revisiones puntuales.

El proyecto combina administración de sistemas, documentación técnica, automatización, bases de datos, análisis de logs y una introducción guiada a seguridad en contratos inteligentes.



## 2. Objetivo general

Crear un repositorio llamado, por ejemplo:

```text
web3-security-lab
```

Ese repositorio deberá contener un laboratorio reproducible que permita analizar contratos inteligentes vulnerables de ejemplo mediante herramientas de desarrollo y análisis de seguridad.

Al finalizar las prácticas, una persona externa debería poder entrar en vuestro repositorio, leer el `README.md`, seguir los pasos y conseguir ejecutar el laboratorio sin depender de vosotros.



## 3. En qué consiste

El proyecto **consiste en**:

- consolidar los fundamentos mínimos de Ethereum, Solidity y seguridad Web3;
- montar un entorno técnico reproducible;
- ejecutar herramientas de análisis sobre ejemplos controlados;
- documentar lo aprendido;
- registrar errores e incidencias;
- automatizar tareas básicas;
- generar informes técnicos comprensibles.



## 4. Resultado esperado

Al terminar, el repositorio debería incluir, como mínimo, algo del estilo:

```text
web3-security-lab/
├── README.md
├── docs/
│   ├── 00-estudio-inicial.md
│   ├── 01-instalacion-entorno.md
│   ├── 02-guia-uso-laboratorio.md
│   ├── 03-herramientas-analizadas.md
│   ├── 04-auditoria-logs-incidencias.md
│   ├── 05-modelo-datos.md
│   └── 06-informe-final.md
├── contracts/
│   └── vulnerable-examples/
├── scripts/
│   ├── run-analysis.sh
│   ├── parse-results.py
│   └── generate-report.py
├── reports/
│   ├── slither/
│   ├── manual-analysis/
│   └── final/
├── database/
│   ├── schema.sql
│   ├── sample-data.sql
│   └── queries.sql
├── logs/
│   ├── execution-logs/
│   └── incident-logs/
├── .github/
│   └── workflows/
│       └── security-analysis.yml
└── docker/
    └── Dockerfile
```

No pasa nada si la estructura final cambia, pero debe ser clara, ordenada y fácil de entender.



## 5. Forma de trabajo recomendada

El equipo puede organizarse como prefiera. Lo importante es que todo el trabajo quede trazado y documentado.

Se recomienda trabajar así:

1. Crear issues en GitHub para cada tarea.
2. Crear ramas pequeñas para cambios concretos.
3. Hacer pull requests, aunque sean sencillas.
4. Revisar el trabajo antes de mezclarlo a `main`.
5. Mantener un diario de trabajo semanal.
6. Documentar errores y decisiones.
7. No dejar conocimiento importante solo en mensajes de chat.

Ejemplo de nombres de ramas:

```text
docs/fase-estudio-inicial
setup/docker-foundry
feature/slither-analysis
feature/sqlite-results
docs/informe-final
```

Ejemplo de issue:

```markdown
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
```



# Fase 1: Investigación y estudio

La primera fase de las prácticas será una fase de **lectura, investigación y preparación conceptual**.

Antes de construir el laboratorio, tenéis que entender el contexto. ( Lo tenéis fácil porque venís del curso :) )

El objetivo de esta fase es responder a tres preguntas:

1. ¿Qué es Ethereum y qué papel tienen los contratos inteligentes?
2. ¿Qué herramientas se usan para desarrollar y probar contratos en Solidity?
3. ¿Qué significa analizar la seguridad de un contrato inteligente?

El entregable principal de esta fase será:

```text
docs/00-estudio-inicial.md
```

Ese documento debe explicar, con vuestras propias palabras, lo que habéis aprendido. El objetivo del documento es que os sirva para refrescar, no os lo toméis como un entregable, sino como un documento de apuntes para vosotros.



## 5.1. Recursos de estudio

### A. Ethereum y contratos inteligentes

Leed estos recursos en este orden:

1. **Ethereum Developer Documentation**  
   https://ethereum.org/developers/docs/

2. **Introduction to smart contracts**  
   https://ethereum.org/developers/docs/smart-contracts/

3. **Anatomy of smart contracts**  
   https://ethereum.org/developers/docs/smart-contracts/anatomy/

Después de leerlos, deberíais poder explicar:

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


### B. Solidity

Solidity es el lenguaje más usado para escribir contratos inteligentes en Ethereum y redes compatibles con EVM.

Recursos:

1. **Página oficial de Solidity**  
   https://soliditylang.org/

2. **Documentación oficial de Solidity**  
   https://docs.soliditylang.org/

3. **Solidity by Example**  
   https://solidity-by-example.org/

4. **Solidity by Example dentro de la documentación oficial**  
   https://docs.soliditylang.org/en/latest/solidity-by-example.html

Conceptos mínimos que debéis estudiar:

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



### C. Desarrollo de contratos: Foundry y Hardhat

En este proyecto se recomienda usar **Foundry** como herramienta principal, porque es rápida, sencilla de automatizar y muy usada en seguridad. Aun así, también conviene conocer Hardhat porque es muy común en proyectos Ethereum.

Recursos sobre Foundry:

1. **Foundry Book / documentación oficial**  
   https://getfoundry.sh/

2. **Foundry: instalación**  
   https://getfoundry.sh/introduction/installation

3. **Foundry: crear un proyecto**  
   https://getfoundry.sh/projects/creating-a-new-project

4. **Foundry: tests**  
   https://getfoundry.sh/forge/writing-tests

Recursos sobre Hardhat:

1. **Hardhat 3: Getting started**  
   https://hardhat.org/docs/getting-started

2. **Hardhat 3 Tutorial**  
   https://hardhat.org/docs/tutorial

3. **Hardhat: Setting up a project**  
   https://hardhat.org/docs/tutorial/setup

Después de revisar estos recursos, deberíais poder explicar:

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



### D. Seguridad en contratos inteligentes

Esta parte es la más relacionada con Decentralized Security.

Recursos:

1. **Trail of Bits - Building Secure Contracts**  
   https://github.com/crytic/building-secure-contracts

2. **Slither: documentación oficial**  
   https://crytic.github.io/slither/slither.html

3. **Slither: repositorio oficial**  
   https://github.com/crytic/slither

4. **OpenZeppelin Ethernaut**  
   https://ethernaut.openzeppelin.com/

5. **Damn Vulnerable DeFi**  
   https://www.damnvulnerabledefi.xyz/

6. **OpenZeppelin Contracts Documentation**  
   https://docs.openzeppelin.com/contracts/

Conceptos mínimos que debéis estudiar:

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



- reentrancy
  
   **Es una vulnerabilidad en la que un contrato externo vuelve a llamar a una función antes de que la ejecución anterior haya terminado, pudiendo alterar el estado de forma inesperada.**



- control de acceso
  
   **Es el mecanismo que restringe qué direcciones o usuarios pueden ejecutar ciertas funciones del contrato.**



- integer precision / pérdida de precisión
  
   **Es un problema derivado del manejo de números enteros, donde pueden ocurrir errores de precisión o redondeo en operaciones matemáticas.**



- uso incorrecto de tx.origin
  
   **Es una mala práctica de seguridad donde se utiliza `tx.origin` para autenticación, lo que puede ser explotado mediante llamadas intermedias.**



- llamadas externas
  
   **Son interacciones con otros contratos que pueden introducir riesgos, especialmente si el contrato externo ejecuta código inesperado.**



- oráculos
  
   **Son fuentes externas de datos que los contratos utilizan para obtener información fuera de la blockchain, lo que puede introducir riesgos si no son fiables.**



- dependencias inseguras
  
   **Son librerías o contratos externos utilizados que pueden contener vulnerabilidades o comportamientos no seguros.**

No es necesario resolver Damn Vulnerable DeFi entero. Es avanzado. Se puede usar como referencia para ver cómo se estructuran laboratorios de seguridad.



### E. Git, GitHub y documentación

Recursos:

1. **GitHub Docs**  
   https://docs.github.com/

2. **Pro Git Book**  
   https://git-scm.com/book/en/v2

3. **Markdown Guide: Basic Syntax**  
   https://www.markdownguide.org/basic-syntax/

4. **Markdown Cheat Sheet**  
   https://www.markdownguide.org/cheat-sheet/

Conceptos mínimos:

- repositorio
 
   **Es un lugar donde se almacena un proyecto junto con todos sus archivos y su historial de cambios.**



- commit
  
   **Es un registro de cambios realizados en el repositorio en un momento concreto.**



- branch
  
   **Es una línea de desarrollo independiente dentro de un repositorio que permite trabajar en cambios sin afectar la versión principal.**



- pull request
  
   **Es una solicitud para fusionar cambios de una rama a otra, permitiendo revisar y discutir esos cambios antes de integrarlos.**



- issue
  
   **Es una herramienta para registrar tareas, mejoras o errores dentro de un proyecto.**



- README.md
  
   **Es un archivo que describe el proyecto, explicando qué hace, cómo usarlo y otra información relevante.**



- Markdown
  
   **Es un lenguaje de marcado ligero que permite formatear texto de forma sencilla.**



- .gitignore
  
   **Es un archivo que indica qué archivos o carpetas no deben ser rastreados por el sistema de control de versiones.**



- historial de cambios
  
   **Es el registro completo de todos los commits realizados en un repositorio a lo largo del tiempo.**



- documentación técnica
  
   **Es el conjunto de textos que explican cómo funciona un sistema, cómo usarlo y cómo está construido.**



### F. Docker y automatización

Recursos:

1. **Docker Docs - Get started**  
   https://docs.docker.com/get-started/

2. **Docker Docs - Introduction**  
   https://docs.docker.com/get-started/introduction/

3. **GitHub Actions Documentation**  
   https://docs.github.com/actions

Conceptos mínimos:

- contenedor
  
   **Es una unidad ligera y ejecutable que incluye todo lo necesario para ejecutar una aplicación (código, dependencias, configuraciones).**



- imagen
  
   **Es una plantilla inmutable que contiene todo lo necesario para crear un contenedor.**



- Dockerfile
  
   **Es un archivo de texto con instrucciones para construir una imagen de Docker paso a paso.**



- volumen
  
   **Es un mecanismo para persistir datos fuera del contenedor, permitiendo que los datos se mantengan aunque el contenedor se elimine.**



- variable de entorno
  
   **Es un valor configurable que se pasa al contenedor o proceso para modificar su comportamiento sin cambiar el código.**



- workflow
  
   **Es un proceso automatizado definido en un archivo que describe qué acciones ejecutar en un repositorio.**


- job
  
   **Es un conjunto de pasos que se ejecutan dentro de un mismo entorno en un workflow.**



- step
  
   **Es una tarea individual dentro de un job, como ejecutar un comando o usar una acción.**



- CI/CD
  
   **Es una práctica que automatiza la integración y el despliegue continuo del código mediante pipelines.**



- artefactos de ejecución
  
   **Son los archivos generados durante la ejecución de un workflow, como binarios o reportes, que pueden guardarse y reutilizarse.**



- logs de pipeline
  
   **Son los registros detallados de lo que ocurre durante la ejecución de un workflow o pipeline, útiles para depuración.**



### G. SQLite y tratamiento de resultados

Recursos:

1. **SQLite Documentation**  
   https://sqlite.org/docs.html

2. **SQLite Quick Start**  
   https://sqlite.org/quickstart.html

3. **Python sqlite3**  
   https://docs.python.org/3/library/sqlite3.html

Conceptos mínimos:

- tabla
  
   **Es una estructura en una base de datos que organiza los datos en filas y columnas.**

- columna
  
   **Es un campo dentro de una tabla que define un tipo de dato específico para almacenar información.**

- clave primaria
  
   **Es una columna (o conjunto de columnas) que identifica de forma única cada fila de una tabla.**

- clave foránea
  
   **Es una columna que establece una relación con la clave primaria de otra tabla.**

- `SELECT`
  
   **Es una sentencia SQL que se utiliza para consultar y recuperar datos de una base de datos.**

- `INSERT`
  
   **Es una sentencia SQL que se utiliza para añadir nuevos registros a una tabla.**

- `JOIN`
  
   **Es una operación que permite combinar filas de dos o más tablas basándose en una relación entre ellas.**

- `GROUP BY`
  
   **Es una cláusula que agrupa filas que tienen valores iguales en columnas específicas.**

- subconsulta
  
   **Es una consulta dentro de otra consulta que se utiliza para obtener datos intermedios.**

- exportación a CSV
  
   **Es el proceso de guardar los datos de una base de datos en un archivo con formato CSV (valores separados por comas).**

- importación de datos
  
   **Es el proceso de cargar datos externos en una base de datos, por ejemplo desde un archivo CSV.**



## 5.2. Entregable de la fase de estudio

Cread el documento:

```text
docs/00-estudio-inicial.md
```

Podría contener estas secciones (usado como guía flexible):

```markdown
# Estudio inicial

## 1. Resumen de Ethereum

Explicación breve con nuestras palabras.

## 2. Resumen de contratos inteligentes

Qué son, cómo se ejecutan y por qué son sensibles desde el punto de vista de seguridad.

## 3. Resumen de Solidity

Conceptos básicos que necesitaremos para leer contratos simples.

## 4. Herramientas de desarrollo

Comparativa básica entre Foundry y Hardhat.

## 5. Herramientas de análisis de seguridad

Qué es Slither, qué hace y qué limitaciones tiene.

## 6. Vulnerabilidades comunes

Tabla con vulnerabilidad, explicación, ejemplo y posible impacto.

## 7. Glosario

Lista de términos nuevos aprendidos.

## 8. Dudas abiertas

Preguntas que todavía no sabemos responder.

## 9. Recursos consultados

Lista de enlaces consultados.
```

Ejemplo de tabla para vulnerabilidades:

| Vulnerabilidad | Explicación sencilla | Impacto posible | ¿Puede detectarla Slither? |
|||||
| Reentrancy | Un contrato externo vuelve a llamar antes de que termine la ejecución original. | Robo o bloqueo de fondos. | A veces sí. |
| Access control | Una función sensible no comprueba quién la llama. | Cualquier usuario podría ejecutar acciones críticas. | A veces sí. |
| tx.origin | Se usa `tx.origin` para autorización. | Riesgo de phishing o bypass de permisos. | Sí, en muchos casos. |



# Fase 2: Diseño del laboratorio

Una vez terminada la fase de estudio, diseñad el laboratorio antes de implementarlo.

El objetivo de esta fase es decidir:

- qué herramientas vais a usar;
- qué contratos de ejemplo vais a analizar;
- qué comandos deberá ejecutar una persona usuaria;
- qué resultados se van a guardar;
- qué documentación será necesaria;
- qué errores pueden aparecer y cómo se registrarán.

Entregable:

```text
docs/02-diseno-laboratorio.md
```

Contenido mínimo:

```markdown
# Diseño del laboratorio

## 1. Objetivo del laboratorio

## 2. Herramientas seleccionadas

## 3. Contratos o proyectos de ejemplo

## 4. Flujo de uso previsto

## 5. Resultados esperados

## 6. Riesgos técnicos

## 7. Decisiones tomadas
```

Ejemplo de flujo de uso:

```text
1. Clonar el repositorio.
2. Instalar dependencias.
3. Compilar contratos.
4. Ejecutar tests.
5. Ejecutar Slither.
6. Guardar resultados.
7. Importar resultados a SQLite.
8. Generar informe Markdown.
```



# Fase 3: Preparación del entorno técnico

En esta fase se prepara el entorno mínimo para poder trabajar.

## 3.1. Herramientas recomendadas

El laboratorio debería poder funcionar, idealmente, con:

- Git;
- GitHub;
- Docker;
- Python 3;
- Node.js;
- Foundry;
- Slither;
- SQLite;
- editor de código, preferiblemente VS Code.

## 3.2. Documento de instalación

Entregable:

```text
docs/01-instalacion-entorno.md
```

Debe incluir:

- sistema operativo usado;
- versiones de herramientas;
- comandos de instalación;
- problemas encontrados;
- soluciones aplicadas;
- capturas si son útiles;
- cómo comprobar que todo funciona.

Ejemplo de sección:

~~~markdown
## Comprobación de instalación

Ejecutar:

```bash
git --version
docker --version
python3 --version
node --version
forge --version
slither --version
sqlite3 --version
```

Resultado esperado:

```text
Todas las herramientas muestran su versión sin errores.
```
~~~

## 3.3. Recomendación importante

No escribáis simplemente “instalamos Foundry”. Documentadlo de forma que otra persona pueda repetirlo.

Mala documentación:

```text
Instalamos Foundry y funcionó.
```

Buena documentación:

~~~markdown
## Instalación de Foundry

Sistema operativo: Ubuntu 22.04 bajo WSL2.

Comando utilizado:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Comprobación:

```bash
forge --version
```

Problema encontrado:

El comando `forge` no aparecía después de instalar.

Solución:

Cerrar y abrir la terminal para recargar el PATH.
~~~



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



# Fase 6: Automatización con GitHub Actions

El laboratorio debe poder ejecutarse automáticamente cuando haya cambios en el repositorio.

## 6.1. Objetivo

Crear un workflow en:

```text
.github/workflows/security-analysis.yml
```

Ese workflow debería:

1. descargar el repositorio;
2. instalar dependencias;
3. compilar contratos;
4. ejecutar tests, si existen;
5. ejecutar Slither;
6. guardar resultados como artefactos o dentro de la carpeta `reports/`.

Ejemplo orientativo:

```yaml
name: Security Analysis

on:
  push:
    branches: [ "main" ]
  pull_request:

jobs:
  analyze:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install Foundry
        uses: foundry-rs/foundry-toolchain@v1
        with:
          version: stable

      - name: Install Python dependencies
        run: |
          python -m pip install --upgrade pip
          pip install slither-analyzer

      - name: Build project
        run: forge build

      - name: Run tests
        run: forge test

      - name: Run Slither
        run: |
          mkdir -p reports/slither
          slither . --json reports/slither/slither-results.json || true
          slither . > reports/slither/slither-results.txt || true

      - name: Upload reports
        uses: actions/upload-artifact@v4
        with:
          name: slither-reports
          path: reports/slither/
```

El `|| true` evita que el pipeline falle solo porque Slither haya encontrado warnings. Podéis cambiar esta decisión si queréis que ciertos warnings rompan la ejecución.

## 6.2. Documento de CI

Cread:

```text
docs/07-automatizacion-ci.md
```

Contenido mínimo:

```markdown
# Automatización con GitHub Actions

## 1. Objetivo del workflow

## 2. Cuándo se ejecuta

## 3. Pasos del workflow

## 4. Resultados generados

## 5. Errores encontrados

## 6. Decisiones tomadas
```



# Fase 7: Base de datos de resultados

En esta fase guardaréis resultados de análisis en una base de datos sencilla.

## 7.1. Objetivo

Crear una base de datos SQLite que permita registrar:

- herramientas usadas;
- contratos analizados;
- findings encontrados;
- severidad;
- descripción;
- fecha de análisis;
- archivo afectado.

## 7.2. Esquema orientativo

Archivo:

```text
database/schema.sql
```

Ejemplo:

```sql
CREATE TABLE tools (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    version TEXT,
    description TEXT
);

CREATE TABLE contracts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    path TEXT NOT NULL,
    description TEXT
);

CREATE TABLE findings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tool_id INTEGER NOT NULL,
    contract_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    severity TEXT,
    description TEXT,
    file_path TEXT,
    line_number INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tool_id) REFERENCES tools(id),
    FOREIGN KEY (contract_id) REFERENCES contracts(id)
);
```

## 7.3. Consultas mínimas

Archivo:

```text
database/queries.sql
```

Debe incluir consultas como:

```sql
-- Número de findings por severidad
SELECT severity, COUNT(*) AS total
FROM findings
GROUP BY severity;

-- Findings por contrato
SELECT contracts.name, COUNT(findings.id) AS total_findings
FROM contracts
LEFT JOIN findings ON contracts.id = findings.contract_id
GROUP BY contracts.name;

-- Findings detectados por herramienta
SELECT tools.name, COUNT(findings.id) AS total_findings
FROM tools
LEFT JOIN findings ON tools.id = findings.tool_id
GROUP BY tools.name;

-- Findings de severidad alta
SELECT title, severity, file_path, line_number
FROM findings
WHERE severity = 'High';
```

## 7.4. Documento del modelo de datos

Archivo:

```text
docs/05-modelo-datos.md
```

Debe explicar:

- por qué existen esas tablas;
- qué representa cada campo;
- cómo se importan datos;
- ejemplos de consultas;
- limitaciones del modelo.



# Fase 8: Generación de informes

El laboratorio debe generar informes comprensibles.

## 8.1. Tipos de informe

Como mínimo:

```text
reports/final/informe-analisis.md
```

Este informe debería incluir:

```markdown
# Informe de análisis

## 1. Resumen ejecutivo

## 2. Entorno utilizado

## 3. Contratos analizados

## 4. Herramientas utilizadas

## 5. Findings detectados

## 6. Tabla resumen

## 7. Interpretación de resultados

## 8. Limitaciones

## 9. Recomendaciones

## 10. Anexos
```

## 8.2. Ejemplo de finding

```markdown
## Finding 01: Uso inseguro de tx.origin

**Contrato:** `TxOriginExample.sol`  
**Severidad:** Media  
**Herramienta:** Slither  
**Archivo:** `contracts/vulnerable-examples/TxOriginExample.sol`  
**Línea:** 18  

- Descripción

El contrato utiliza `tx.origin` para comprobar permisos. Esta práctica puede permitir ataques de phishing en los que un contrato malicioso induce a una víctima a ejecutar una transacción.

- Impacto

Un atacante podría conseguir que un usuario autorizado ejecute una acción sin comprender realmente qué contrato está invocando.

- Recomendación

Usar `msg.sender` para autorización directa y aplicar patrones de control de acceso más robustos.

- Estado

Detectado automáticamente por Slither y revisado manualmente.
```



# Fase 9: Auditoría de logs e incidencias

Este proyecto también debe demostrar capacidad para registrar actividad, errores e incidencias.

No hace falta auditar servidores reales. Se pueden auditar los logs generados por:

- Docker;
- GitHub Actions;
- Foundry;
- Slither;
- scripts propios;
- errores de instalación;
- errores de compilación;
- errores de permisos;
- errores de dependencias.

## 9.1. Documento de incidencias

Archivo:

```text
docs/04-auditoria-logs-incidencias.md
```

Plantilla:

```markdown
# Auditoría de logs e incidencias

## 1. Fuentes de logs revisadas

- GitHub Actions
- Docker
- Slither
- Foundry
- Scripts propios

## 2. Incidencias detectadas

| ID | Fecha | Fuente | Descripción | Causa | Solución | Estado |
||||||||
| INC-001 | 2026-XX-XX | Slither | Error al compilar contrato | Versión incorrecta de Solidity | Configurar versión correcta | Resuelta |

## 3. Ejemplos de logs

Incluir fragmentos relevantes.

## 4. Conclusiones

Qué se ha aprendido revisando los logs.
```

## 9.2. Buenas prácticas

Cuando aparezca un error, no lo borréis sin más. Documentadlo.

Ejemplo:

```markdown
## INC-003: Error en GitHub Actions al instalar Slither

- Síntoma

El workflow fallaba en el paso `pip install slither-analyzer`.

- Causa

La versión de Python usada no era compatible con una dependencia.

- Solución

Se actualizó el workflow para usar una versión compatible de Python.

- Evidencia

Se adjunta enlace al run de GitHub Actions y fragmento del log.
```



# Fase 10: Informe final y presentación

Al final de las prácticas debéis preparar:

```text
docs/06-informe-final.md
```

Y una presentación breve de 10-15 minutos.

## 10.1. Informe final

Estructura recomendada:

```markdown
# Informe final de prácticas

## 1. Resumen del proyecto

## 2. Objetivos iniciales

## 3. Trabajo realizado

## 4. Estructura del repositorio

## 5. Herramientas utilizadas

## 6. Laboratorio construido

## 7. Resultados obtenidos

## 8. Problemas encontrados

## 9. Decisiones técnicas

## 10. Qué hemos aprendido

## 11. Limitaciones

## 12. Mejoras futuras

## 13. Conclusión
```

## 10.2. Presentación final

La presentación debe responder a estas preguntas:

- ¿qué habéis construido?
- ¿para qué sirve?
- ¿cómo se usa?
- ¿qué herramientas habéis usado?
- ¿qué problemas habéis encontrado?
- ¿qué resultados genera?
- ¿qué mejoraríais si tuvierais más tiempo?
- ¿qué habéis aprendido?



# Plantillas útiles

## Plantilla de diario semanal

Archivo sugerido:

```text
docs/diario-semanal.md
```

Contenido:

```markdown
# Diario semanal

## Semana X

- Objetivos de la semana

- 

- Trabajo realizado

- 

- Problemas encontrados

- 

- Soluciones aplicadas

- 

- Decisiones tomadas

- 

- Recursos consultados

- 

- Pendiente para la próxima semana

- 
```



## Plantilla de decisión técnica

```markdown
# Decisión técnica: [título]

## Contexto

Qué problema había que resolver.

## Opciones consideradas

1. Opción A
2. Opción B
3. Opción C

## Decisión

Qué opción se ha elegido.

## Motivo

Por qué se ha elegido.

## Consecuencias

Qué ventajas e inconvenientes tiene.
```



## Plantilla de guía de uso

```markdown
# Guía de uso del laboratorio

## 1. Requisitos previos

## 2. Instalación

## 3. Compilación

## 4. Ejecución de tests

## 5. Ejecución de análisis

## 6. Consulta de resultados

## 7. Generación de informes

## 8. Resolución de problemas comunes
```



# Criterios de calidad

El proyecto se considerará bien realizado si cumple estos criterios:

## Documentación

- El `README.md` explica claramente el objetivo.
- Hay instrucciones de instalación paso a paso.
- Hay guía de uso.
- Se documentan incidencias reales.
- Se explican decisiones técnicas.
- Los documentos están escritos con claridad.

## Reproducibilidad

- Otra persona puede clonar el repositorio y ejecutar el laboratorio.
- Las versiones de herramientas están indicadas.
- Los comandos importantes están documentados.
- Los scripts tienen nombres claros.
- El pipeline de GitHub Actions funciona.

## Seguridad

- No hay claves privadas reales.
- No hay conexión a mainnet.
- No se atacan sistemas externos.
- No se publican datos sensibles.
- Las dependencias utilizadas están documentadas.

## Base de datos

- Existe un esquema SQL claro.
- Hay datos de ejemplo.
- Hay consultas documentadas.
- Se explica cómo se importan resultados.
- Se pueden obtener métricas básicas.

## Análisis técnico

- Se ejecuta al menos una herramienta de análisis.
- Los resultados se guardan.
- Los findings se interpretan.
- Se distinguen warnings, errores y vulnerabilidades.
- Se explican limitaciones.

## Trabajo en equipo

- Hay issues o tareas trazables.
- Hay commits frecuentes.
- El trabajo no aparece de golpe al final.
- Las decisiones se documentan.
- El diario semanal refleja progreso real.



# Posibles ampliaciones

Si el proyecto básico se completa pronto, se pueden añadir mejoras.

## Nivel 1: mejoras sencillas

- Añadir más contratos vulnerables.
- Añadir más consultas SQL.
- Mejorar el README.
- Crear una guía visual con capturas.
- Añadir badges de GitHub Actions.

## Nivel 2: mejoras intermedias

- Generar informes automáticamente con Python.
- Convertir resultados JSON de Slither a Markdown.
- Crear una tabla comparativa de herramientas.
- Añadir un contenedor Docker completo.
- Añadir más tests en Foundry.

## Nivel 3: mejoras avanzadas

- Añadir Echidna para fuzzing.
- Añadir Mythril.
- Añadir visualización de resultados.
- Crear una pequeña interfaz web.
- Comparar resultados entre herramientas.
- Ejecutar análisis sobre ejercicios de Ethernaut.
- Incorporar retos sencillos inspirados en Damn Vulnerable DeFi.

Estas ampliaciones no son obligatorias. Es mejor entregar un proyecto pequeño, claro y bien documentado que uno grande y confuso.



# Uso responsable de inteligencia artificial

Podéis usar herramientas de IA para aprender, resumir documentación o pedir ayuda con errores, pero con estas condiciones:

1. No copiéis texto sin revisarlo.
2. No aceptéis respuestas técnicas sin comprobarlas.
3. Si una IA os da un comando, entended qué hace antes de ejecutarlo.
4. Si usáis una explicación generada por IA, reescribidla con vuestras palabras.
5. Citad recursos reales y documentación oficial siempre que sea posible.
6. No subáis información sensible a herramientas externas.

Una buena práctica es añadir al diario semanal una sección:

```markdown
## Uso de IA

- Para qué se ha usado.
- Qué respuestas fueron útiles.
- Qué se verificó manualmente.
- Qué errores produjo.
```



# Glosario inicial

| Término | Significado |
|||
| Ethereum | Red blockchain programable donde se pueden ejecutar contratos inteligentes. |
| Smart contract | Programa que vive en blockchain y se ejecuta mediante transacciones. |
| Solidity | Lenguaje usado para escribir contratos inteligentes en Ethereum. |
| EVM | Ethereum Virtual Machine, entorno donde se ejecutan los contratos. |
| Foundry | Toolkit para desarrollar, probar y ejecutar contratos inteligentes. |
| Hardhat | Framework de desarrollo para proyectos Ethereum. |
| Slither | Herramienta de análisis estático para contratos Solidity y Vyper. |
| Análisis estático | Revisión del código sin ejecutarlo. |
| Finding | Resultado o hallazgo detectado durante un análisis. |
| Falso positivo | Advertencia de una herramienta que no representa una vulnerabilidad real. |
| CI/CD | Automatización de procesos como tests, análisis y despliegues. |
| Docker | Tecnología para ejecutar aplicaciones en contenedores. |
| SQLite | Base de datos ligera basada en un único archivo. |



# Checklist final

Antes de dar el proyecto por terminado, revisad:

- [ ] El repositorio tiene un `README.md` claro.
- [ ] La fase de estudio está documentada.
- [ ] Hay una guía de instalación.
- [ ] El entorno se puede reproducir.
- [ ] Hay contratos de ejemplo.
- [ ] Slither se ejecuta correctamente.
- [ ] Los resultados se guardan en `reports/`.
- [ ] Hay un workflow de GitHub Actions.
- [ ] Hay una base de datos SQLite.
- [ ] Hay consultas SQL documentadas.
- [ ] Hay informe de logs e incidencias.
- [ ] Hay informe final.
- [ ] Hay presentación final.
- [ ] No hay secretos, claves privadas ni información sensible.
- [ ] Todo el trabajo importante está documentado.



# Cierre

El objetivo principal no es construir una herramienta perfecta, sino demostrar que sois capaces de:

- aprender una tecnología nueva (ya lo habéis estado haciendo durante el curso);
- instalar y configurar herramientas técnicas;
- trabajar de forma ordenada;
- documentar procesos;
- analizar resultados;
- automatizar tareas;
- resolver incidencias;
- comunicar lo aprendido.

En seguridad, la documentación, la trazabilidad y la capacidad de explicar lo que se ha hecho son tan importantes como ejecutar herramientas.

Un buen resultado final sería un laboratorio sencillo, pero claro, reproducible y útil para introducir a otras personas en la seguridad de contratos inteligentes.
