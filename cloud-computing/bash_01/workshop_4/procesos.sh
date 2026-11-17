#!/bin/bash
# Parte 4 - Proceso sospechoso consumiendo recursos
# Simula un proceso que consume CPU, lo encuentra con ps/grep/awk, lo finaliza con kill
# y verifica que ya no exista.

# 1. Simular el proceso sospechoso (yes escribe "y" sin parar y consume CPU)
yes > /dev/null &
pid_simulado=$!
sleep 2

# 2. Los 5 procesos con más CPU (equivalente rápido a mirar htop ordenado por CPU)
echo "===== TOP 5 POR CPU ====="
ps aux --sort=-%cpu | head -6

# 3. Filtrar solo el proceso con grep y mostrar USER, PID, %CPU y %MEM con awk
echo
echo "===== PROCESO SOSPECHOSO ====="
echo "USER PID %CPU %MEM COMANDO"
ps aux | grep -E " yes$" | awk '{print $1, $2, $3, $4, $11}'

# 4. Tomar el PID con mayor CPU entre los procesos "yes"
pid=$(ps aux | grep -E " yes$" | sort -k3 -rn | head -1 | awk '{print $2}')
echo
echo "Finalizando PID $pid ..."

# 5. kill envía SIGTERM (terminación ordenada). Si no responde, se usaría kill -9.
kill "$pid"
sleep 1

# 6. Verificar que ya no existe
if ps -p "$pid" > /dev/null; then
    echo "El proceso $pid sigue activo"
else
    echo "El proceso $pid ya no existe"
fi
