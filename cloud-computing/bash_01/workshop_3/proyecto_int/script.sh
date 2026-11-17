#!/bin/bash

# Proyecto integrador - Taller 3
# Crea una carpeta con la fecha, copia los .txt, cuenta cuántos se copiaron,
# genera reporte.log y muestra éxito o error según el código de salida.

# Crear una carpeta con la fecha actual
fecha=$(date +%Y-%m-%d)

# Para indicarle que use el contenido de la var, es con "$"
# -p evita el error si la carpeta ya existe
mkdir -p "$fecha"

# Copiar todos los archivos .txt
# -maxdepth 1 evita que se vuelvan a copiar los .txt que ya están dentro de la carpeta de la fecha
contador=0
estado=0

for archivo in $(find . -maxdepth 1 -type f -name "*.txt")
do
	cp "$archivo" "$fecha/"
	if [ $? -eq 0 ]
	then
		contador=$((contador+1))
	else
		estado=1
	fi
done

# Mostrar cuántos archivos se copiaron
echo "Se copiaron $contador archivos"

# Mostrar el resultado según el código de salida de las copias
if [ $estado -eq 0 ]
then
	mensaje="Proceso realizado correctamente"
else
	mensaje="Ocurrio un error al copiar uno o más archivos"
fi
echo "$mensaje"

# Generar un reporte
{
	echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
	echo "Carpeta destino: $fecha"
	echo "Se copiaron $contador archivos"
	echo "Estado: $mensaje"
} > reporte.log

exit $estado
