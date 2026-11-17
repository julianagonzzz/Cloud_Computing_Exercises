#!/bin/bash
# Pruebas del workshop 2 - correr desde la carpeta workshop_2

# funcion para mandar varias peticiones a una ruta y contar que instancia respondio
probar() {
    echo "== $1 ($2 peticiones) =="
    for i in $(seq 1 $2); do curl -s "http://localhost:8080$1"; echo; done
    echo "instancias que respondieron:"
    for i in $(seq 1 $2); do curl -s "http://localhost:8080$1"; echo; done \
        | grep -o '"instance":"[^"]*"' | sort | uniq -c
}

# ---------- Parte 3: solo routing ----------
docker compose up --build -d
sleep 3
docker compose ps
probar /api/users/ 4
probar /api/products/ 4
# se ve UN solo hostname por servicio -> no hay balanceo, solo routing
docker compose down

# ---------- Parte 5: routing + balanceo en users ----------
docker compose -f docker-compose.lb.yml up --build -d
sleep 3
docker compose -f docker-compose.lb.yml ps
probar /api/users/ 6
probar /api/products/ 4
# en users ahora salen DOS hostnames alternandose, en products sigue saliendo uno
docker compose -f docker-compose.lb.yml down

# ---------- Reto: orders balanceado ----------
docker compose -f docker-compose.reto.yml up --build -d
sleep 3
probar /api/orders/ 6
docker compose -f docker-compose.reto.yml down
