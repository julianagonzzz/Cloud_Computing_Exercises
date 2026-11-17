#!/bin/bash
# Parte 3 - Investigación de comandos
# Para cada comando: qué hace, sintaxis, ejemplo (se ejecuta) y caso de uso.
# Requiere: sudo apt install jq htop

echo "== grep =="
# Qué hace: busca líneas que coinciden con un patrón de texto o regex
# Sintaxis: grep [opciones] patrón [archivo]
# Caso de uso: encontrar errores en un log
grep -i "error" logs.json

echo "== ps =="
# Qué hace: muestra una foto de los procesos en ejecución
# Sintaxis: ps [opciones]
# Caso de uso: ver qué procesos consumen más CPU en un servidor
ps aux --sort=-%cpu | head -5

echo "== htop =="
# Qué hace: monitor interactivo de procesos en tiempo real (CPU, memoria, carga)
# Sintaxis: htop [opciones]
# Caso de uso: diagnosticar lentitud y finalizar procesos desde la interfaz (F9)
# Ejemplo (interactivo, se sale con q): htop -u $(whoami)
echo "Ejecutar manualmente: htop -u $(whoami)"

echo "== kill =="
# Qué hace: envía una señal a un proceso por su PID (por defecto SIGTERM)
# Sintaxis: kill [-señal] PID
# Caso de uso: terminar un proceso colgado o que consume demasiados recursos
sleep 100 &
kill $!
echo "Proceso $! finalizado"

echo "== awk =="
# Qué hace: procesa texto por columnas y patrones; filtra, calcula y formatea
# Sintaxis: awk 'patrón {acción}' archivo
# Caso de uso: extraer columnas específicas de logs o de la salida de otros comandos
ps aux | awk 'NR<=4 {print $1, $2, $3, $4}'

echo "== jq =="
# Qué hace: filtra, transforma y consulta datos JSON desde la terminal
# Sintaxis: jq 'filtro' archivo.json
# Caso de uso: analizar logs estructurados de microservicios o respuestas de APIs
jq -c 'select(.status==500)' logs.json
