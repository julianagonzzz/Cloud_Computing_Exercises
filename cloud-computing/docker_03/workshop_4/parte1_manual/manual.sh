#!/bin/bash
# Parte 1 y 2 - levantar postgres y crear la estructura "a mano"
# (en clase se escribe cada sentencia dentro de psql; aqui se le pasa el archivo para no copiar todo otra vez)

docker compose up -d
sleep 5   # darle tiempo a postgres de arrancar

# -T porque la entrada viene de un archivo y no de la terminal
docker compose exec -T postgres psql -U admin -d universidad < manual.sql

# verificar
docker compose exec postgres psql -U admin -d universidad -c "\dn"
docker compose exec postgres psql -U admin -d universidad -c "\dt academia.*"

# OJO: este compose no tiene volumen, al hacer down se pierde todo
# docker compose down
