# Taller 4 - Bash 

Juliana González Sánchez

## Parte 2. Pipes

**`ls | wc -l`**: cuenta cuántos archivos y carpetas hay en el directorio actual.

**`cat archivo.txt | grep error`**: muestra solo las líneas del archivo que contienen la palabra `error`.

## Preguntas de reflexión

**1. ¿Qué ventajas ofrecen los pipes?**
Permiten combinar comandos simples para resolver tareas complejas sin crear archivos temporales.

**2. ¿Cuándo utilizar `grep` en lugar de `jq`?**
`grep` para búsquedas rápidas de texto en cualquier archivo. `jq` cuando necesito filtrar por un campo exacto del JSON (`.status==500`), extraer campos o agrupar, porque entiende la estructura.

**3. ¿Qué ventajas ofrece `awk`?**
Separa cada línea en columnas, así que puedo imprimir solo los campos que necesito, filtrar por el valor de una columna y hacer cálculos en una sola línea.

**4. ¿Qué riesgos tiene finalizar procesos incorrectos con `kill`?**
Tumbar un servicio en producción, perder datos no guardados o dejar archivos corruptos, sobre todo con `kill -9`. Hay que confirmar el PID antes.

**5. ¿Qué utilidad tiene el análisis de logs en ambientes Cloud?**
Es la forma de detectar errores, accesos sospechosos y problemas de rendimiento en muchos servicios distribuidos a la vez, y de alimentar alertas y dashboards.
