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

Ubuntu 24.04
git version 2.43.0
Docker version 29.4.2, build 055a478
Python 3.12.3
Node v18.19.1
forge Version: 1.6.0-v1.7.0
slither 0.11.5
sqlite3 3.45.1

~~~markdown
## Instalación de Git

Comando utilizado:

```bash
sudo apt update;
sudo apt install git
```

Comprobación:

```bash
git --version
```
~~~

~~~markdown
## Instalación de Docker

Comando utilizado:

```bash
  sudo apt update;
  sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release;
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
  sudo apt install docker-ce docker-ce-cli containerd.io;
```

Comprobación:

```bash
  docker --version
```
Problema encontrado:

Hay que instalar dependencias
El usuario actual no pertenece al grupo del servicio docker

Solución:

```bash
  sudo usermod -aG docker $USER
```
~~~

~~~markdown
## Instalación de Python

Comando utilizado:

```bash
  sudo apt update;
  sudo apt install python3 python3-pip pipx;
```

Comprobación:

```bash
python3 --version
```
~~~

~~~markdown
## Instalación de Node

Comando utilizado:

```bash
sudo apt update;
sudo apt install nodejs;
```

Comprobación:

```bash
node --version
```
~~~

~~~markdown
## Instalación de Forge

Comando utilizado:

```bash
sudo curl -L https://foundry.paradigm.xyz | bash;
sudo foundryup;
sudo echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc;
sudo source ~/.bashrc;
sudo hash -r;
```

Comprobación:

```bash
forge --version
```


~~~

~~~markdown
## Instalación de Slither

Comando utilizado:

```bash
sudo apt update;
sudo pipx install slither-analyzer
```

Comprobación:

```bash
slither --version
```
~~~


~~~markdown
## Instalación de Sqlite3

Comando utilizado:

```bash
sudo apt update;
sudo apt install sqlite3;
```

Comprobación:

```bash
sqlite3 --version
```
~~~

### 3.3 Cómo comprobar que todo funciona.


```bash
docker run hello-world;
forge init test_project;
sqlite3 test.db
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete 
d5e71e642bf5: Download complete 
Digest: sha256:f9078146db2e05e794366b1bfe584a14ea6317f44027d10ef7dad65279026885
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

Initializing /home/pc/test_project...
Installing forge-std in /home/pc/test_project/lib/forge-std (url: https://github.com/foundry-rs/forge-std, tag: None)
Clonando en '/home/pc/test_project/lib/forge-std'...
remote: Enumerating objects: 2977, done.
remote: Counting objects: 100% (292/292), done.
remote: Compressing objects: 100% (138/138), done.
remote: Total 2977 (delta 249), reused 155 (delta 154), pack-reused 2685 (from 3)
Recibiendo objetos: 100% (2977/2977), 1.13 MiB | 2.69 MiB/s, listo.
Resolviendo deltas: 100% (1989/1989), listo.
    Installed forge-std tag=v1.16.1@620536fa5277db4e3fd46772d5cbc1ea0696fb43
    Initialized forge project
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
sqlite> 
```