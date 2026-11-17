#!/bin/bash
# Parte 4 y reto - verificar la carga automatica desde cero
# uso: ./pruebas.sh automatico    o    ./pruebas.sh reto

CARPETA=${1:-automatico}
cd "$CARPETA" || exit 1

# -v borra el volumen mongo_data, asi mongo arranca vacio y vuelve a correr el init
docker compose down -v
docker compose up -d

# esperar hasta que mongo responda
until docker compose exec -T mongo mongosh -u admin -p admin --authenticationDatabase admin \
      --quiet --eval "db.adminCommand('ping')" > /dev/null 2>&1; do
    sleep 1
done
sleep 2

MONGO="docker compose exec -T mongo mongosh -u admin -p admin --authenticationDatabase admin"

if [ "$CARPETA" = "reto" ]; then
    $MONGO < consultas.js
else
    # lo mismo de la parte 4: use tienda, show collections y los find
    $MONGO <<'FIN'
use tienda
show collections
db.products.find()
db.customers.find()
FIN
fi
