#!/bin/bash
# Taller 2 (02_bash) - construir y probar todas las imágenes
# Ejecutar desde la carpeta workshop_2

set -x

# Conclusión (CMD vs ENTRYPOINT):
# - Caso A (solo CMD): sin argumentos imprime "Hola desde CMD"; con un argumento,
#   el CMD se reemplaza entero y Docker intenta ejecutar el texto como programa (falla).
# - Caso B (solo ENTRYPOINT): echo siempre se ejecuta y los argumentos se le agregan.
# - Caso C (ENTRYPOINT + CMD): sin argumentos imprime "Mensaje por defecto";
#   con argumento solo se reemplaza el CMD y echo se mantiene.

# Parte 1 - imagen de laboratorio
docker build -t ubuntu-bash-lab ./ubuntu-bash-lab
# interactivo: docker run -it --name ubuntu-lab ubuntu-bash-lab
docker run --rm ubuntu-bash-lab bash -c "cd /app && ls -la && ./analiza.sh access.log"

# Caso A - solo CMD
docker build -t ejemplo-cmd ./cmd
docker run --rm ejemplo-cmd
docker run --rm ejemplo-cmd "Mensaje reemplazado"     # falla: intenta ejecutar "Mensaje reemplazado" como programa
docker run --rm ejemplo-cmd echo "Mensaje reemplazado" # así sí reemplaza el CMD

# Caso B - solo ENTRYPOINT
docker build -t ejemplo-entrypoint ./entrypoint
docker run --rm ejemplo-entrypoint "Hola"
docker run --rm ejemplo-entrypoint "Mensaje adicional"
docker run --rm ejemplo-entrypoint

# Caso C - ENTRYPOINT + CMD
docker build -t ejemplo-combinado ./entry_cmd
docker run --rm ejemplo-combinado
docker run --rm ejemplo-combinado "Mensaje personalizado"
