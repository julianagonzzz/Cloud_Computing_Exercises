#!/bin/bash
# Pruebas del workshop 3 - correr desde la carpeta workshop_3
URL=http://localhost:8080

# levantar todo
docker compose up --build -d
sleep 8
docker compose ps

# ---------- evidencia de que postgres tiene los datos ----------
docker compose exec db psql -U postgres -d shop -c "SELECT * FROM products;"

# ---------- Parte 5: integracion ----------
echo "== 15 peticiones a /products =="
for i in {1..15}; do curl -s $URL/products; echo; done
# served_by cambia pero los productos son los mismos
echo "quien respondio:"
for i in {1..15}; do curl -s $URL/products; echo; done | grep -o '"served_by":"[^"]*"' | sort | uniq -c

# ---------- Parte 6: tolerancia a fallos ----------
echo "== sin api2 =="
docker compose stop api2
for i in {1..9}; do curl -s -o /dev/null -w "%{http_code} " $URL/products; done; echo
for i in {1..9}; do curl -s $URL/products; echo; done | grep -o '"served_by":"[^"]*"' | sort | uniq -c

echo "== sin api2 ni api3 =="
docker compose stop api3
for i in {1..6}; do curl -s $URL/products; echo; done | grep -o '"served_by":"[^"]*"' | sort | uniq -c

docker compose start api2 api3
sleep 3

# ---------- Parte 7: CRUD entre instancias ----------
echo "== crear un producto =="
curl -s -X POST $URL/products -H "Content-Type: application/json" \
     -d '{"name": "Webcam", "price": 120000}'
echo

# consultar varias veces el mismo id: responde una instancia distinta cada vez,
# pero todas ven el registro porque todas leen la misma base
ID=$(docker compose exec -T db psql -U postgres -d shop -tAc "SELECT max(id) FROM products;")
echo "== consultar id $ID desde varias instancias =="
for i in {1..3}; do curl -s $URL/products/$ID; echo; done

echo "== actualizar =="
curl -s -X PUT $URL/products/$ID -H "Content-Type: application/json" \
     -d '{"name": "Webcam HD", "price": 135000}'
echo
curl -s $URL/products/$ID; echo

echo "== borrar =="
curl -s -X DELETE $URL/products/$ID; echo
curl -s $URL/products/$ID; echo   # deberia dar 404

# para apagar: docker compose down   (con -v se borra tambien la base)
