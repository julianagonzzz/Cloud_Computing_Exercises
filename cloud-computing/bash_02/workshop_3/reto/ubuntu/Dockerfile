FROM ubuntu:latest

# procps trae ps, que usa monitor.sh (la imagen base de ubuntu no lo incluye)
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

WORKDIR /scripts

COPY monitor.sh /scripts/monitor.sh
COPY analiza.sh /scripts/analiza.sh

RUN chmod +x /scripts/monitor.sh /scripts/analiza.sh

# Mantiene el contenedor encendido para poder usar docker compose exec
CMD ["tail", "-f", "/dev/null"]
