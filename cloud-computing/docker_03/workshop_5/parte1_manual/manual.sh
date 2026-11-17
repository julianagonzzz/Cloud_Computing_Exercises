#!/bin/bash
# levanta mongo y le pasa los comandos de manual.js por la entrada estandar
# (es lo mismo que escribirlos uno por uno dentro de mongosh)

docker compose up -d
sleep 5

docker compose exec -T mongo mongosh -u admin -p admin --authenticationDatabase admin < manual.js

# docker compose down   (sin volumen, se pierde todo)
