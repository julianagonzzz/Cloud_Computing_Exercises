# Workshop 5 (01_bash) 

Juliana González Sánchez

**1. ¿Cuál es la diferencia entre una imagen y un contenedor?**
La imagen es la plantilla de solo lectura; el contenedor es esa imagen en ejecución, con una capa de escritura encima. De una imagen salen muchos contenedores.

**2. ¿Por qué Docker facilita el despliegue en la nube?**
La imagen trae todo lo que la aplicación necesita, así que corre igual en cualquier servidor con Docker, y los servicios de nube trabajan directamente con imágenes.

**3. ¿Qué ventajas ofrece Docker frente a instalar aplicaciones directamente en el sistema operativo?**
Aislamiento entre aplicaciones (sin conflictos de versiones), instalación y eliminación limpias, entornos reproducibles y arranque en segundos.

**4. ¿En qué situaciones utilizaría un volumen Docker?**
Cuando los datos deben sobrevivir al contenedor: bases de datos, archivos subidos por usuarios, logs o configuraciones compartidas.

**5. ¿Qué riesgos existen al ejecutar `docker system prune` en un servidor de producción?**
Puede borrar contenedores detenidos que se iban a reiniciar e imágenes necesarias para un rollback; con `--volumes`, incluso datos.
