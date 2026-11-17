#!/bin/bash
# Reto integrador - Taller 4
# 1. Identifica procesos problemáticos (simula uno con "yes"), lo filtra y lo finaliza
# 2. Analiza logs.json: filtra, cuenta errores HTTP 500 e identifica el servicio afectado
# 3. Genera informe.txt con los hallazgos
# Uso: ./reto_integrador.sh [archivo.json]   (por defecto logs.json)

log="${1:-logs.json}"
informe="informe.txt"

if [ ! -f "$log" ]; then
    echo "El archivo '$log' no existe"
    exit 1
fi

# ---------- 1. Procesos problemáticos ----------
yes > /dev/null &          # proceso que consume CPU (simulado)
sleep 2

# proceso con mayor %CPU del sistema
proceso=$(ps aux --sort=-%cpu | awk 'NR==2 {print $1, $2, $3, $4, $11}')
usuario=$(echo "$proceso" | awk '{print $1}')
pid=$(echo "$proceso" | awk '{print $2}')
cpu=$(echo "$proceso" | awk '{print $3}')
mem=$(echo "$proceso" | awk '{print $4}')
nombre=$(echo "$proceso" | awk '{print $5}')

kill "$pid"
sleep 1
if ps -p "$pid" > /dev/null; then
    estado_proceso="sigue activo"
else
    estado_proceso="finalizado correctamente"
fi

# ---------- 2. Análisis de logs ----------
total=$(wc -l < "$log")
errores_500=$(jq -c 'select(.status==500)' "$log" | wc -l)
por_servicio=$(jq -r 'select(.status==500) | .service' "$log" | sort | uniq -c | sort -rn)
max=$(echo "$por_servicio" | head -1 | awk '{print $1}')
afectados=$(echo "$por_servicio" | awk -v m="$max" '$1==m {print $2}' | paste -sd "," | sed "s/,/, /g")
detalle=$(jq -r 'select(.status==500) | "  - \(.service): \(.message)"' "$log")

# ---------- 3. Informe ----------
{
    echo "===== INFORME DE HALLAZGOS ====="
    echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Servidor: $(hostname)"
    echo
    echo "--- Proceso problemático ---"
    echo "Nombre: $nombre | PID: $pid | Usuario: $usuario | CPU: $cpu% | MEM: $mem%"
    echo "Acción: kill $pid -> $estado_proceso"
    echo
    echo "--- Logs ($log) ---"
    echo "Registros analizados: $total"
    echo "Errores HTTP 500: $errores_500"
    echo "Errores por servicio:"
    echo "$por_servicio"
    echo "Servicio(s) más afectado(s): $afectados"
    echo "Detalle:"
    echo "$detalle"
} > "$informe"

cat "$informe"
