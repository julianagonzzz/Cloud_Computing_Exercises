#!/bin/bash
# Parte 3 - Monitor básico del contenedor (no recibe argumentos)

UMBRAL=80   # porcentaje de uso de disco a partir del cual se muestra advertencia

echo "===== MONITOR DEL CONTENEDOR ====="
echo "Hostname: $(hostname)"
echo "Usuario: $(whoami)"
echo "Fecha: $(date)"
echo "Directorio: $(pwd)"

echo "===== DISCO ====="
df -h

echo "===== PROCESOS ====="
# se resta 1 por la línea de encabezado de ps
echo "Procesos activos: $(( $(ps aux | wc -l) - 1 ))"

echo "===== ALERTAS DE DISCO (umbral ${UMBRAL}%) ====="
alertas=$(df -h | awk -v u="$UMBRAL" 'NR>1 {gsub("%","",$5); if ($5+0 > u) print "ADVERTENCIA: " $6 " está al " $5 "%"}')
if [ -n "$alertas" ]; then
    echo "$alertas"
else
    echo "Ninguna partición supera el ${UMBRAL}%"
fi

echo "===== FIN DEL REPORTE ====="
echo "Diagnóstico terminado correctamente"
