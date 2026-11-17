#!/bin/bash
# Partes 2 y 7 - Explorar Docker y sus recursos

# --- Parte 2 ---
# Muestra la versión instalada del cliente Docker
docker --version
# Lista las imágenes descargadas (repositorio, etiqueta, ID, tamaño). Al inicio está vacía.
docker images
# Resume el espacio en disco usado por imágenes, contenedores, volúmenes y caché de build
docker system df

# --- Parte 7 ---
# Redes: por defecto existen bridge, host y none
docker network ls
# Volúmenes: almacenamiento persistente que sobrevive al borrar el contenedor
docker volume ls
# Uso de disco por tipo de recurso y cuánto se puede recuperar (RECLAIMABLE)
docker system df
# Limpieza: borra contenedores detenidos, redes sin uso, imágenes colgantes y caché de build.
# Pide confirmación antes de borrar.
docker system prune
