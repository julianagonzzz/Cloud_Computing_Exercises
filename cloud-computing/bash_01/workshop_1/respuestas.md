# Taller 1 - Bash (01_bash) · Respuestas

**Estudiante:** Juliana González Sánchez

## Ejercicio 1

**1. ¿Qué significa `pwd`?**
*Print working directory*: muestra la ruta absoluta del directorio en el que estoy.

**2. ¿Qué directorio aparece?**
Mi directorio personal, `/home/julianita`.

## Ejercicio 2

**¿Qué diferencia observa?**
`ls` muestra solo los nombres. `ls -l` agrega permisos, dueño, grupo, tamaño y fecha de modificación. `ls -la` muestra además los archivos ocultos, incluidos `.` y `..`.

**¿Qué son los archivos ocultos?**
Los que empiezan por punto, como `.bashrc`. Suelen guardar configuraciones y se ocultan para que no estorben ni se modifiquen por accidente.

## Preguntas de reflexión

**1. ¿Cuál es la diferencia entre una ruta absoluta y una relativa?**
La absoluta parte de la raíz `/` y funciona desde cualquier lugar (`/home/julianita/proyecto`). La relativa depende del directorio actual (`proyecto/datos`, `../documentos`).

**2. ¿Qué hace `cd ..`?**
Sube al directorio padre.

**3. ¿Para qué sirve `man`?**
Abre el manual de un comando, con su descripción y sus opciones.

**4. ¿Qué riesgo tiene `rm -r`?**
Borra directorios completos sin pasar por la papelera, así que un error de ruta puede eliminar información de forma permanente.
