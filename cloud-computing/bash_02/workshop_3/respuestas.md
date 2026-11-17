# Taller 3 (02_bash) 

Juliana González Sánchez

## Parte 2

**1. ¿Por qué el cambio aparece sin reconstruir la imagen?**
Porque `html` está montada como volumen: el contenedor lee los archivos directamente de mi carpeta.

**2. ¿Qué función cumple `:ro`?**
Monta el volumen en solo lectura; Nginx puede leer los archivos pero no modificarlos.

**3. ¿Cuál es la diferencia entre el puerto `8080` y el `80`?**
El 80 es donde escucha Nginx dentro del contenedor; el 8080 es el puerto de mi equipo que Docker redirige hacia él.

**4. ¿Qué parte representa el host y qué parte representa el contenedor?**
En `"8080:80"` y en `./html:/usr/share/nginx/html`, la izquierda es el host y la derecha el contenedor.

## Pregunta de diseño

**¿Por qué Docker Compose resulta más conveniente que ejecutar manualmente varios `docker run`?**
Porque deja puertos, volúmenes, variables, redes y el orden de arranque en un solo archivo versionable. Con `docker compose up` se levanta todo igual cada vez, los servicios se encuentran por nombre en una red común, y con `docker compose down` se limpia todo, lo que evita errores cuando el sistema tiene varios servicios.
