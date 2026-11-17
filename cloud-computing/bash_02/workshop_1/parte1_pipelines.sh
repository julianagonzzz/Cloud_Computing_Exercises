#!/bin/bash
# Parte 1 (A-E) - Análisis de access.log con pipes

echo "== A. Líneas con ERROR =="
grep 'ERROR' access.log

echo "== B. Cantidad de errores =="
grep 'ERROR' access.log | wc -l

echo "== C. Usuarios con errores =="
grep 'ERROR' access.log | awk '{for(i=1;i<=NF;i++) if($i ~ /^user=/) print $i}'

echo "== D. Errores por usuario =="
grep 'ERROR' access.log | awk '{for(i=1;i<=NF;i++) if($i ~ /^user=/) print $i}' | sort | uniq -c

echo "== E. IP más asociada a errores =="
grep 'ERROR' access.log | awk '{for(i=1;i<=NF;i++) if($i ~ /^ip=/) print $i}' | sort | uniq -c | sort -rn | head -1
