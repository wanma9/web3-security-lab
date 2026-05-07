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