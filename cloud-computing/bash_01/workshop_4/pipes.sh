#!/bin/bash
# Parte 2 - Pipes

# Cuenta cuántos archivos y carpetas hay en el directorio actual
ls | wc -l

# Muestra solo las líneas que contienen "error"
cat logs.json | grep error
