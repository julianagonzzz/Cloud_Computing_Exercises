#!/bin/bash

# Desafío final - Taller 3
# Respalda un directorio en backup/ comprimido con tar, con la fecha en el nombre,
# registra la operación en backup.log y muestra un resumen.

# Solicitar el nombre del directorio: el resultado se guarda en directory.
read -p "Ingrese el nombre del directorio: " directory

fecha=$(date +%Y-%m-%d_%H-%M-%S)
log="backup.log"

# Verificar que exista el directorio
if [ -d "$directory" ]
then
	echo "El directorio existe"
else
	echo "El directorio no existe"
	echo "$fecha | $directory | ERROR: el directorio no existe" >> "$log"
	exit 1
fi

# Crear una carpeta backup (-p para que no falle si ya existe)
mkdir -p backup

# Comprimir el contenido usando tar, con la fecha en el nombre del archivo
nombre_base=$(basename "$directory")
archivo="backup/${nombre_base}_${fecha}.tar.gz"

tar -czf "$archivo" "$directory"

# Guardar el estado según el código de salida de tar
if [ $? -eq 0 ]
then
	estado="EXITOSO"
else
	estado="FALLIDO"
fi

# Datos para el resumen
cantidad=$(find "$directory" -type f | wc -l)
tamano=$(du -h "$archivo" 2>/dev/null | cut -f1)

# Registrar la operación en backup.log
echo "$fecha | $directory | $archivo | $cantidad archivos | $tamano | $estado" >> "$log"

# Mostrar resumen
echo "===== RESUMEN DEL BACKUP ====="
echo "Fecha: $fecha"
echo "Directorio respaldado: $directory"
echo "Archivo generado: $archivo"
echo "Cantidad de archivos respaldados: $cantidad"
echo "Tamaño del respaldo: $tamano"
echo "Estado del proceso: $estado"

if [ "$estado" = "EXITOSO" ]; then
	exit 0
else
	exit 1
fi
