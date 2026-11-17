#!/bin/bash
# Parte 5 y reto - comprobar que la base se reconstruye sola desde cero
# uso: ./pruebas.sh automatico    o    ./pruebas.sh reto

CARPETA=${1:-automatico}
cd "$CARPETA" || exit 1

# psql dentro del contenedor (para no repetir tanto)
sql() {
    docker compose exec -T postgres psql -U admin -d universidad -c "$1"
}

# -v borra tambien el volumen -> la carpeta de datos queda vacia y se vuelven a correr los scripts
docker compose down -v
docker compose up -d

# esperar a que postgres termine de inicializar.
# durante el init postgres arranca un servidor temporal y luego se reinicia,
# por eso primero se espera el mensaje de "init process complete" y despues pg_isready
until docker compose logs postgres 2>/dev/null | grep -q "PostgreSQL init process complete"; do
    sleep 1
done
until docker compose exec -T postgres pg_isready -U admin -d universidad > /dev/null 2>&1; do
    sleep 1
done

# en los logs se ve que corrio los .sql
docker compose logs postgres | grep "docker-entrypoint-initdb.d"

echo "== esquemas =="
sql "\dn"
echo "== tablas =="
sql "\dt academia.*"
echo "== datos =="
sql "SELECT * FROM academia.students;"
sql "SELECT * FROM academia.courses;"

if [ "$CARPETA" = "reto" ]; then
    sql "SELECT * FROM academia.teachers;"

    # consulta uniendo las tablas para ver que las llaves foraneas tienen sentido
    echo "== inscripciones con nombres =="
    sql "SELECT s.name AS estudiante, c.name AS curso, t.name AS profesor, e.grade AS nota
         FROM academia.enrollments e
         JOIN academia.students s ON s.id = e.student_id
         JOIN academia.courses  c ON c.id = e.course_id
         JOIN academia.teachers t ON t.id = c.teacher_id
         ORDER BY s.name;"

    # probar que la FK no deja meter un curso con profesor que no existe (debe fallar)
    echo "== prueba de llave foranea (debe dar error) =="
    sql "INSERT INTO academia.courses (name, credits, teacher_id) VALUES ('Fantasma', 2, 99);"
fi
