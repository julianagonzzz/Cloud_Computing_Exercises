# Workshop 1 - Preguntas de análisis

1. ¿Por qué el cliente solamente conoce `localhost:8080`?

Porque en el compose el único servicio que publica un puerto hacia el host es nginx (8080:80). Las tres APIs no tienen `ports`, entonces solo se pueden alcanzar dentro de la red de Docker. El cliente le habla a nginx y nginx es el que sabe a qué instancia mandar la petición.

2. ¿Qué función cumple `upstream`?

Define el grupo de servidores backend entre los que nginx reparte las peticiones, en este caso api1, api2 y api3 en el puerto 5000. Después en el `proxy_pass` se usa el nombre del upstream (`flask_backend`) en lugar de una sola dirección.

3. ¿Qué estrategia utiliza Nginx por defecto en este escenario?

Round robin. En las pruebas las respuestas salen en orden api-1, api-2, api-3 y vuelve a empezar, y con 12 peticiones cada instancia respondió 4.

4. ¿Qué ocurre al detener `api2`?

Las peticiones siguen funcionando y ahora se reparten solo entre api-1 y api-3 (6 y 6). Cuando nginx intenta mandar algo a api2 y falla la conexión, pasa esa petición al siguiente servidor del upstream y deja de usar api2 por un rato, así que el cliente no ve errores. Puede que alguna petición se demore un poco más justo cuando nginx detecta que api2 no responde.

5. ¿Qué componente podría convertirse en un punto único de falla?

Nginx. Si se cae, no hay forma de llegar a ninguna API aunque las tres estén funcionando. Para evitarlo habría que tener más de un balanceador.

6. ¿Por qué este diseño representa escalamiento horizontal?

Porque para atender más carga no se le dan más recursos a una sola API, sino que se agregan más copias iguales de la misma API y el balanceador reparte el trabajo entre ellas.

7. ¿Qué tendría que cambiar para tener cinco instancias?

Agregar `api4` y `api5` en el `docker-compose.yml` (con su `INSTANCE`), añadirlas al `depends_on` de nginx y agregar `server api4:5000;` y `server api5:5000;` en el upstream del `nginx.conf`.

## Reto: health check

El endpoint `/health` devuelve `{"status": "ok", "instance": ...}` si la API está viva. Se puede usar de varias formas. En Docker se puede poner un `healthcheck` en el compose que haga `curl` a `/health` cada cierto tiempo y marque el contenedor como unhealthy si falla. Nginx open source no hace health checks activos, solo pasivos (se da cuenta cuando una petición real falla, con `max_fails` y `fail_timeout`). Los activos, donde el balanceador consulta `/health` por su cuenta, están en Nginx Plus o en otros balanceadores como HAProxy o el Application Load Balancer de AWS, que saca del tráfico las instancias que no responden bien.
