#!/bin/bash
# Parte 5 - evidenciar el balanceo
# correr desde la carpeta workshop_1 con docker desktop / docker en WSL encendido

# 0. probar la imagen sola antes del balanceo (Parte 2)
docker build -t flask-api ./api
docker run -d --rm --name api-sola -p 5000:5000 -e INSTANCE=api-sola flask-api
sleep 2
curl -s http://localhost:5000/ ; echo
docker stop api-sola

# 1. levantar todo (en segundo plano para poder seguir usando la terminal)
docker compose up --build -d
sleep 3
docker compose ps

# 2. 12 peticiones al balanceador
echo "---- con las 3 instancias ----"
for i in {1..12}; do curl -s http://localhost:8080/; echo; done

# contar cuantas respondio cada instancia
echo "---- conteo ----"
for i in {1..12}; do curl -s http://localhost:8080/; echo; done | grep -o 'api-[0-9]' | sort | uniq -c

# 3. tumbar api2 y repetir
docker compose stop api2
echo "---- sin api2 ----"
for i in {1..12}; do curl -s http://localhost:8080/; echo; done | grep -o 'api-[0-9]' | sort | uniq -c

# 4. reto: endpoint /health
echo "---- health ----"
for i in {1..3}; do curl -s http://localhost:8080/health; echo; done

# volver a prender api2 y apagar todo al final
docker compose start api2
# docker compose down
