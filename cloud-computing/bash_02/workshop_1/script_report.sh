#!/bin/bash
# Parte 1F - Genera reporte.txt a partir de access.log usando pipes y redirecciones
# Uso: ./script_report.sh [archivo_log]   (por defecto access.log)

log="${1:-access.log}"

registros=$(wc -l < "$log")

errores=$(awk '$3 == "ERROR"' "$log" | wc -l)

advertencias=$(awk '$3 == "WARN"' "$log" | wc -l)

usuario_top=$(awk '$3 == "ERROR" {print $4}' "$log" | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' | cut -d= -f2)

ip_top=$(awk '$3 == "ERROR" {print $6}' "$log" | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' | cut -d= -f2)

{
    echo "===== REPORTE DE $log ====="
    echo "Cantidad total de registros: $registros"
    echo "Cantidad de errores: $errores"
    echo "Cantidad de advertencias: $advertencias"
    echo "Usuario con más errores: $usuario_top"
    echo "IP con más errores: $ip_top"
} > reporte.txt

cat reporte.txt
