# Explanation - Preguntas de análisis

1. ¿Por qué una sola instancia Flask puede convertirse en un cuello de botella?

Porque tiene una capacidad limitada de CPU, memoria y conexiones. Si llegan más peticiones de las que puede procesar, empiezan a hacer cola, la respuesta se vuelve lenta y puede llegar a fallar. Además, si esa única instancia se cae, se cae todo el servicio.

2. ¿Cuál es la diferencia entre escalamiento vertical y horizontal?

El vertical es darle más recursos a la misma máquina (más CPU, más RAM). Es sencillo, pero tiene un límite y sigue siendo un solo punto de falla. El horizontal es agregar más instancias iguales y repartir la carga entre ellas, que es lo que se hizo con api1, api2 y api3 detrás de nginx.

3. ¿Por qué un reverse proxy puede existir sin balanceamiento?

Porque su función principal es ser intermediario entre el cliente y los servidores internos. Puede mandar cada ruta a un solo backend, como en el workshop 2 donde `/api/users/` iba a users y `/api/products/` a products, cada uno con una sola instancia. Ahí hay routing pero no se reparte carga.

4. ¿Por qué un load balancer normalmente trabaja con varias instancias?

Porque su objetivo es distribuir el tráfico, y con un solo backend no hay nada que distribuir. Necesita varias instancias del mismo servicio para poder repartir las peticiones y para seguir respondiendo si alguna falla.

5. ¿Por qué es conveniente que una API balanceada sea stateless?

Porque cada petición puede caer en una instancia diferente. Si una instancia guarda algo en memoria (como una sesión), la siguiente petición puede ir a otra que no lo tiene. Si el estado está afuera, por ejemplo en PostgreSQL, cualquier instancia puede atender cualquier petición y también se pueden agregar o quitar instancias sin perder nada.

6. ¿Qué ocurre si una de las tres instancias Flask se detiene?

El servicio sigue funcionando. Nginx detecta que la conexión con esa instancia falla y manda las peticiones a las otras dos. En el workshop 1, al detener api2, las 12 peticiones respondieron bien y se repartieron entre api-1 y api-3.

7. ¿Qué ocurre si Nginx se detiene?

Se pierde el acceso a todo, porque es el único punto de entrada y las APIs no publican puertos al host. Aunque las tres APIs estén funcionando, el cliente no tiene cómo llegar a ellas. Es el punto único de falla de esta arquitectura.

8. ¿El balanceamiento de APIs resuelve el problema de escalabilidad de PostgreSQL?

No. Solo reparte las peticiones HTTP entre las APIs, pero todas siguen usando la misma base. Si la carga sube mucho, el cuello de botella se pasa a PostgreSQL. Escalar la base es otro problema y se resuelve con cosas como réplicas de lectura, connection pooling o particionamiento.

9. ¿Qué requerimientos no funcionales podrían verse afectados por una mala configuración del load balancer?

La disponibilidad, porque un error en la configuración puede bloquear todo el tráfico o seguir mandando peticiones a instancias caídas. El rendimiento, si reparte mal la carga o los timeouts están mal puestos. La escalabilidad, si no se pueden agregar instancias fácilmente. También la seguridad, si expone algo que no debería, y la tolerancia a fallos, si no tiene health checks.

10. ¿Qué componentes adicionales serían necesarios para llevar esta arquitectura a producción?

Más de un balanceador (o uno administrado de la nube) para que no sea punto único de falla, health checks, HTTPS con certificados, la base de datos replicada y con backups (o un servicio administrado como RDS), un pool de conexiones, manejo seguro de credenciales, monitoreo y logs centralizados, y un orquestador como Kubernetes o ECS que reinicie y escale las instancias automáticamente.
