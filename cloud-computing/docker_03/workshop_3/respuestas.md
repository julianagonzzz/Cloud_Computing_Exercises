# Workshop 3 - Análisis

1. ¿Dónde se encuentra el estado del negocio?

En PostgreSQL, en la tabla `products` de la base `shop`. Las APIs no guardan nada en memoria, cada petición abre una conexión, consulta o modifica la base y responde.

2. ¿Por qué las APIs pueden ser stateless?

Porque toda la información está en la base compartida, entonces da igual qué instancia atienda la petición. En las pruebas creé un producto con un POST que atendió api-2 y después lo consulté y respondieron api-3, api-1 y api-2 con el mismo dato. Ninguna instancia necesita recordar algo de la petición anterior.

3. ¿Qué ocurre si una API reinicia?

No se pierde nada porque no tenía datos propios. Mientras está caída nginx manda las peticiones a las otras dos y cuando vuelve a arrancar sigue funcionando igual que antes. Al detener api2 las respuestas salieron solo de api-1 y api-3, y al detener también api3 todo lo respondió api-1, sin errores para el cliente.

4. ¿Qué ocurre si PostgreSQL reinicia?

Mientras la base está abajo todas las APIs fallan al mismo tiempo, porque las tres dependen de ella. En mi caso responden un 503 con "base de datos no disponible" y `/health` muestra `db_error`. Cuando PostgreSQL vuelve, las APIs se recuperan solas porque abren una conexión nueva en cada petición. Los datos no se pierden porque están en el volumen `pg_data`.

5. ¿Dónde existen puntos únicos de falla?

En nginx, porque es la única entrada, y en PostgreSQL, porque es una sola instancia de la que dependen todas las APIs. Las APIs no lo son porque hay tres. También se podría decir que el host donde corre Docker es un punto único, ya que si esa máquina se cae se cae todo.

6. ¿El balanceamiento de API soluciona el escalamiento de la base de datos?

No. Balancear reparte las peticiones HTTP entre las APIs, pero las tres terminan consultando la misma base, así que si crece mucho la carga el cuello de botella pasa a ser PostgreSQL. Para escalar la base se necesitan otras cosas, como réplicas de lectura, connection pooling o particionamiento.

7. ¿Qué mecanismos podrían añadirse en una arquitectura de producción?

Más de un nginx (o un balanceador administrado como el ALB de AWS) para que no sea un punto único de falla, health checks activos a `/health`, PostgreSQL con réplicas y respaldos o un servicio administrado como RDS, un pool de conexiones (por ejemplo PgBouncer), credenciales en un gestor de secretos en vez de dejarlas en el compose, HTTPS en nginx, y monitoreo y logs centralizados.
