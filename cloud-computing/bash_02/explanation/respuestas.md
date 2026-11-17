# Explanation (02_bash) - Dockerfile y Docker Compose 

Juliana González Sánchez

**1. ¿Qué problema resuelve un `Dockerfile`?**
Deja escrito, paso a paso, cómo construir una imagen, así que cualquiera puede reproducir exactamente el mismo entorno con `docker build` en lugar de configurarlo a mano.

**2. ¿Qué problema resuelve Docker Compose?**
Permite definir en un solo archivo YAML varios servicios con sus puertos, volúmenes, variables y redes, y levantarlos o apagarlos juntos con un comando, en vez de lanzar muchos `docker run` manuales.

**3. ¿Cuál es la diferencia entre una imagen y un contenedor?**
La imagen es la plantilla inmutable; el contenedor es una instancia en ejecución creada a partir de ella. Una imagen puede generar muchos contenedores.

**4. ¿Para qué sirve `FROM`?**
Define la imagen base sobre la que se construye la nueva imagen, por ejemplo `ubuntu:24.04` o `nginx:alpine`.

**5. ¿En qué momento se ejecuta `RUN`?**
Durante la construcción de la imagen (`docker build`), no cuando arranca el contenedor. Su resultado queda guardado como una capa de la imagen.

**6. ¿Qué función cumple `COPY`?**
Copia archivos del contexto de construcción (la carpeta local) hacia dentro de la imagen.

**7. ¿Qué diferencia existe entre `CMD` y `ENTRYPOINT`?**
`ENTRYPOINT` define el programa principal del contenedor y se mantiene siempre. `CMD` da el comando o los argumentos por defecto, y se reemplaza si se pasan argumentos en `docker run`.

**8. ¿Qué ocurre cuando se agrega un comando al final de `docker run`?**
Reemplaza el `CMD` de la imagen. Si hay `ENTRYPOINT`, lo que se agrega se le pasa como argumentos.

**9. ¿Qué representa `8080:80`?**
Que el puerto 8080 del host se redirige al puerto 80 del contenedor. La izquierda es el host y la derecha el contenedor.

**10. ¿Por qué un contenedor puede comunicarse con otro utilizando el nombre del servicio?**
Porque Compose crea una red para el proyecto con un DNS interno que resuelve cada nombre de servicio a la IP de su contenedor.

**11. ¿Qué problema resuelve un volumen?**
La pérdida de datos: los contenedores son efímeros, y el volumen guarda la información fuera de ellos para que persista o se comparta entre contenedores y con el host.

**12. ¿Qué diferencia existe entre `image` y `build` en Compose?**
`image` usa una imagen ya existente (por ejemplo de Docker Hub). `build` construye la imagen a partir de un Dockerfile en la ruta indicada.
