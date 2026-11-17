#!/bin/bash
# Reto integrador - Taller 3 (02_bash)
# Levanta Nginx + Ubuntu/Bash con carpeta de logs compartida y demuestra que funcionan a la vez.
# Ejecutar desde la carpeta reto/

set -e

# Construir y levantar los dos servicios
docker compose up --build -d

# Evidencia: ambos servicios en estado Up al mismo tiempo
docker compose ps

# Generar tráfico a Nginx (localhost:8080) para que escriba en logs/access.log
for i in 1 2 3; do
    curl -s -o /dev/null -w "Petición $i -> HTTP %{http_code}\n" http://localhost:8080
done

# Ejecutar los scripts dentro del contenedor Ubuntu
docker compose exec bash ./monitor.sh
docker compose exec bash ./analiza.sh /logs/eventos.log /logs/access.log

# El volumen compartido: Ubuntu ve los logs que escribió Nginx
docker compose exec bash ls -la /logs

# Para apagar todo: docker compose down
