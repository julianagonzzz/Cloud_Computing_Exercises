-- Reto - esquema completo con profesores, cursos, estudiantes e inscripciones

CREATE SCHEMA IF NOT EXISTS academia;

CREATE TABLE IF NOT EXISTS academia.teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS academia.students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

-- cada curso lo dicta un profesor -> llave foranea a teachers
CREATE TABLE IF NOT EXISTS academia.courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits > 0),
    teacher_id INTEGER NOT NULL REFERENCES academia.teachers(id)
);

-- tabla intermedia (relacion muchos a muchos entre estudiantes y cursos)
CREATE TABLE IF NOT EXISTS academia.enrollments (
    id SERIAL PRIMARY KEY,
    -- si se borra el estudiante o el curso se borran sus inscripciones
    student_id INTEGER NOT NULL REFERENCES academia.students(id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES academia.courses(id) ON DELETE CASCADE,
    enrolled_at DATE NOT NULL DEFAULT CURRENT_DATE,
    grade NUMERIC(2,1) CHECK (grade BETWEEN 0 AND 5),
    -- un estudiante no se puede inscribir dos veces al mismo curso
    UNIQUE (student_id, course_id)
);
