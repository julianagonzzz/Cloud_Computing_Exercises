#!/bin/bash
# Parte 5 - Análisis de logs JSON
# Uso: ./analisis_logs.sh [archivo.json]   (por defecto logs.json)

archivo="${1:-logs.json}"

if [ ! -f "$archivo" ]; then
    echo "El archivo '$archivo' no existe"
    exit 1
fi

echo "===== 1. Líneas con error (grep) ====="
grep error "$archivo"

echo
echo "===== 2. service, status y message (jq) ====="
jq -c '{service,status,message}' "$archivo"

echo
echo "===== 3. Solo errores HTTP 500 ====="
jq -c 'select(.status==500)' "$archivo"

echo
echo "===== 4. Cantidad de errores 500 ====="
total=$(jq -c 'select(.status==500)' "$archivo" | wc -l)
echo "$total"

echo
echo "===== 5. Errores 500 por servicio ====="
jq -r 'select(.status==500) | .service' "$archivo" | sort | uniq -c | sort -rn

# Servicio(s) con más errores (si hay empate se muestran todos)
max=$(jq -r 'select(.status==500) | .service' "$archivo" | sort | uniq -c | sort -rn | head -1 | awk '{print $1}')
servicios=$(jq -r 'select(.status==500) | .service' "$archivo" | sort | uniq -c | awk -v m="$max" '$1==m {print $2}' | paste -sd "," | sed "s/,/, /g")
echo
echo "Servicio(s) con más errores: $servicios ($max error(es) cada uno)"
