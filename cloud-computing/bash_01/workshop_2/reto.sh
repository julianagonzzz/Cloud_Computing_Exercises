#!/bin/bash
# Reto: encontrar todos los .txt, ordenarlos alfabéticamente y guardar el resultado en reporte.txt
find . -name "*.txt" | sort > reporte.txt
cat reporte.txt
