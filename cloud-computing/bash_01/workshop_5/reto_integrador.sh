#!/bin/bash
# Reto integrador - Workshop 5 (Docker: introducción a contenedores)
# Levanta Ubuntu + Nginx, entra a Ubuntu con docker exec, revisa logs de Nginx
# y luego detiene y elimina contenedores e imágenes.
# Ejecutar paso a paso; se pausa entre bloques para tomar capturas.


pausa() { read -p ">> Enter para continuar..." _; }

echo "== 1. Descargar imágenes =="
docker pull ubuntu
docker pull nginx
docker images
pausa

echo "== 2. Crear contenedores =="
# Ubuntu en segundo plano: sleep infinity lo mantiene vivo para poder hacer exec
docker run -d --name ubuntu-reto ubuntu sleep infinity
docker run -d --name nginx-reto -p 8080:80 nginx
docker ps
echo "Abre http://localhost:8080 en el navegador"
pausa

echo "== 3. Ejecutar comandos dentro de Ubuntu con docker exec =="
docker exec ubuntu-reto bash -c "pwd; ls; whoami; cat /etc/os-release | head -2"
echo "(Para entrar de forma interactiva: docker exec -it ubuntu-reto bash)"
pausa

echo "== 4. Logs de Nginx =="
curl -s http://localhost:8080 > /dev/null   # genera una petición para que aparezca en el log
docker logs --tail 10 nginx-reto
pausa

echo "== 5. Inspeccionar =="
docker inspect --format '{{.Name}} -> IP {{.NetworkSettings.IPAddress}}, estado {{.State.Status}}' ubuntu-reto nginx-reto
pausa

echo "== 6. Detener contenedores =="
docker stop ubuntu-reto nginx-reto
docker ps -a
pausa

echo "== 7. Eliminar contenedores =="
docker rm ubuntu-reto nginx-reto
docker ps -a
pausa

echo "== 8. Eliminar imágenes =="
docker rmi ubuntu nginx
docker images
echo "Reto terminado"
