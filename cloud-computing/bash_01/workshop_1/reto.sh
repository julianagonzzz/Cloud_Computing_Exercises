#!/bin/bash
# Reto final - Taller 1: construir la estructura proyecto/, respaldar ventas.csv y mostrar el árbol

mkdir -p proyecto/codigo proyecto/datos proyecto/documentos

touch proyecto/codigo/main.py proyecto/codigo/util.py
touch proyecto/datos/clientes.csv proyecto/datos/ventas.csv
touch proyecto/documentos/informe.md

# Copiar ventas.csv a documentos y renombrarlo como ventas_backup.csv
cp proyecto/datos/ventas.csv proyecto/documentos/
mv proyecto/documentos/ventas.csv proyecto/documentos/ventas_backup.csv

# Mostrar el árbol creado
ls -R proyecto
