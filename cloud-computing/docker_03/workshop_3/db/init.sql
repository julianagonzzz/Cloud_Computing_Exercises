-- Script de la base "shop"
-- postgres lo ejecuta solo la primera vez (cuando el volumen de datos esta vacio)

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

-- productos de prueba (minimo 5)
INSERT INTO products (name, price) VALUES
('Laptop', 3500000),
('Mouse', 80000),
('Teclado', 150000),
('Monitor', 900000),
('Audifonos', 220000),
('Memoria USB 64GB', 45000);
