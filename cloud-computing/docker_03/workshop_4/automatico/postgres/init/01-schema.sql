-- 01: estructura. Se ejecuta primero porque los archivos van en orden alfabetico
-- IF NOT EXISTS para que no falle si ya existe

CREATE SCHEMA IF NOT EXISTS academia;

CREATE TABLE IF NOT EXISTS academia.students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS academia.courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);
