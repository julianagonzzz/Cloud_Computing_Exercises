# Taller 2 (02_bash) - Dockerfile 

Juliana González Sánchez

**1. ¿Cuál instrucción se comporta como valor por defecto?**
`CMD`. Solo se usa si no se pasa nada después de la imagen en `docker run`.

**2. ¿Cuál instrucción define el programa principal del contenedor?**
`ENTRYPOINT`. Siempre se ejecuta y recibe como argumentos lo que se pase en `docker run`.

**3. ¿Qué sucede con `CMD` cuando se pasa un comando al final de `docker run`?**
Se descarta completo y se ejecuta lo que se pasó. Por eso `docker run --rm ejemplo-cmd "Mensaje reemplazado"` falla: Docker intenta ejecutar el texto como programa.

**4. ¿Por qué `ENTRYPOINT` es útil cuando queremos que el contenedor se comporte como una herramienta concreta?**
Porque fija el ejecutable y el contenedor se usa como un comando más (`docker run analizador access.log`), sin riesgo de cambiar el programa principal por accidente.

**5. ¿Qué combinación utilizaría para crear un script que tenga un ejecutable fijo pero permita modificar parámetros?**
`ENTRYPOINT` + `CMD`: el primero fija el ejecutable y el segundo da los parámetros por defecto, que se pueden reemplazar. Por ejemplo, `ENTRYPOINT ["/app/analiza.sh"]` con `CMD ["access.log"]`.
