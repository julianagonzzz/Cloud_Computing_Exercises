#!/bin/bash
# Parte 4 - Analizador de texto (recibe uno o más archivos como argumentos)
# Uso: ./analiza.sh archivo1 [archivo2 ...]

# Verificar que se proporcionó al menos un archivo
if [ "$#" -lt 1 ]
then
    echo "Se debe proporcionar al menos un archivo"
    echo "Uso: $0 archivo1 [archivo2 ...]"
    echo "Ejemplo: $0 access.log"
    exit 1
fi

errores=0

for archivo in "$@"
do
    # Verificar que el archivo existe
    if [ ! -f "$archivo" ]; then
        echo "Error: el archivo '$archivo' no existe"
        echo
        errores=1
        continue
    fi

    echo "===== Archivo analizado: $archivo ====="

    lineas=$(wc -l < "$archivo")
    echo "Hay $lineas líneas en el archivo"

    palabras=$(wc -w < "$archivo")
    echo "Hay $palabras palabras en el archivo"

    carac=$(wc -m < "$archivo")
    echo "Hay $carac caracteres en el archivo"

    err=$(grep -c 'ERROR' "$archivo")
    echo "Hay $err líneas con ERROR"

    warn=$(grep -c 'WARN' "$archivo")
    echo "Hay $warn líneas con WARN"
    echo
done

exit $errores
