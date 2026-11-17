#!/bin/bash
# Desafío - Detecta usuarios con dos o más eventos ERROR (situación potencialmente sospechosa)
# Uso: ./sospechoso.sh [archivo_log]

log="${1:-access.log}"
umbral=2

sospechosos=$(grep 'ERROR' "$log" | awk '{for(i=1;i<=NF;i++) if($i ~ /^user=/) print $i}' \
    | sort | uniq -c | awk -v u="$umbral" '$1 >= u {print $2" ("$1" errores)"}')

if [ -n "$sospechosos" ]; then
    echo "ALERTA: posible actividad sospechosa"
    echo "$sospechosos"
    exit 1
else
    echo "Sin actividad sospechosa"
fi
