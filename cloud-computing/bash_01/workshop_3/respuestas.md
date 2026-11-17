# Taller 3 - Bash 

Juliana González Sánchez

**1. ¿Qué ventaja tienen los scripts frente a ejecutar comandos manualmente?**
Se repiten siempre igual y sin errores de digitación, quedan documentados y se pueden programar con `cron`.

**2. ¿Cuándo utilizar un `for` y cuándo un `while`?**
`for` cuando conozco de antemano sobre qué voy a iterar (un rango, una lista de archivos). `while` cuando las repeticiones dependen de una condición que cambia, como un contador o esperar a que algo ocurra.

**3. ¿Qué representa `$?`?**
El código de salida del último comando: `0` si terminó bien y otro valor si hubo error.

**4. ¿Por qué es importante validar la existencia de archivos antes de manipularlos?**
Para que el script no falle a mitad de camino ni ejecute `cp`, `tar` o `rm` sobre rutas que no existen, y pueda avisar el error de forma controlada.

**5. ¿Cómo podrían integrarse estos scripts en procesos de automatización para servidores Linux, servicios en la nube o dispositivos IoT?**
Programándolos con `cron` (por ejemplo, un backup nocturno que se sube a S3), usándolos como *user data* al crear una instancia EC2, como `ENTRYPOINT` de un contenedor, o en dispositivos IoT para rotar logs y revisar el espacio en disco.
