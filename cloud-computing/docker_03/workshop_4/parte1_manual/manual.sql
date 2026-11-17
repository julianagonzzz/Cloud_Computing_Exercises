-- Parte 2 - comandos que se escriben a mano dentro de psql
-- (entrar con: docker compose exec postgres psql -U admin -d universidad)

-- un esquema es como una carpeta dentro de la base para agrupar tablas
CREATE SCHEMA academia;

CREATE TABLE academia.students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE academia.courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);

-- datos de prueba
INSERT INTO academia.students (name, email) VALUES
('Juliana', 'juliana@example.com'),
('Camilo', 'camilo@example.com');

INSERT INTO academia.courses (name, credits) VALUES
('Computacion en la Nube', 3);

SELECT * FROM academia.students;
SELECT * FROM academia.courses;
