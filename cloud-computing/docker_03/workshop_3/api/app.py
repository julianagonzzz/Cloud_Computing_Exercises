import os

import psycopg
from psycopg.rows import dict_row
from flask import Flask, jsonify, request

app = Flask(__name__)

# todo sale de variables de entorno, nada de credenciales quemadas en el codigo
INSTANCE = os.getenv("INSTANCE", "api-local")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


def get_conn():
    # se abre una conexion por peticion. No es lo mas eficiente (lo ideal seria un pool)
    # pero asi la api no guarda nada en memoria y queda stateless
    return psycopg.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        row_factory=dict_row,  # para que cada fila llegue como diccionario
    )


def to_json(p):
    # price es NUMERIC en postgres y llega como Decimal, jsonify no lo maneja bien.
    # si no tiene decimales lo dejo como entero (3500000 y no 3500000.0)
    price = float(p["price"])
    if price.is_integer():
        price = int(price)
    return {"id": p["id"], "name": p["name"], "price": price}


# si la base no esta disponible (por ejemplo mientras reinicia) se responde un 503
# en json, en vez del error 500 en html que flask muestra por defecto
@app.errorhandler(psycopg.OperationalError)
def db_no_disponible(error):
    return jsonify({"served_by": INSTANCE, "error": "base de datos no disponible"}), 503


@app.get("/")
def home():
    return jsonify({"message": "API de productos", "served_by": INSTANCE})


@app.get("/health")
def health():
    # revisa que la api pueda hablar con la base
    try:
        with get_conn() as conn:
            conn.execute("SELECT 1")
        return jsonify({"status": "ok", "instance": INSTANCE})
    except psycopg.Error:
        return jsonify({"status": "db_error", "instance": INSTANCE}), 503


# ---------- Parte 2: listar productos ----------
@app.get("/products")
def list_products():
    with get_conn() as conn:
        rows = conn.execute("SELECT id, name, price FROM products ORDER BY id").fetchall()
    return jsonify({
        "served_by": INSTANCE,
        "products": [to_json(r) for r in rows]
    })


# ---------- Parte 7: reto CRUD ----------
@app.get("/products/<int:product_id>")
def get_product(product_id):
    with get_conn() as conn:
        row = conn.execute(
            "SELECT id, name, price FROM products WHERE id = %s", (product_id,)
        ).fetchone()
    if row is None:
        return jsonify({"served_by": INSTANCE, "error": "producto no encontrado"}), 404
    return jsonify({"served_by": INSTANCE, "product": to_json(row)})


@app.post("/products")
def create_product():
    data = request.get_json(silent=True) or {}
    # validacion basica de lo que llega
    if "name" not in data or "price" not in data:
        return jsonify({"served_by": INSTANCE, "error": "faltan name o price"}), 400

    # los %s los reemplaza psycopg (evita inyeccion SQL)
    with get_conn() as conn:
        row = conn.execute(
            "INSERT INTO products (name, price) VALUES (%s, %s) RETURNING id, name, price",
            (data["name"], data["price"]),
        ).fetchone()
    # al salir del with se hace commit automaticamente
    return jsonify({"served_by": INSTANCE, "product": to_json(row)}), 201


@app.put("/products/<int:product_id>")
def update_product(product_id):
    data = request.get_json(silent=True) or {}
    if "name" not in data or "price" not in data:
        return jsonify({"served_by": INSTANCE, "error": "faltan name o price"}), 400

    with get_conn() as conn:
        row = conn.execute(
            "UPDATE products SET name = %s, price = %s WHERE id = %s RETURNING id, name, price",
            (data["name"], data["price"], product_id),
        ).fetchone()
    if row is None:
        return jsonify({"served_by": INSTANCE, "error": "producto no encontrado"}), 404
    return jsonify({"served_by": INSTANCE, "product": to_json(row)})


@app.delete("/products/<int:product_id>")
def delete_product(product_id):
    with get_conn() as conn:
        row = conn.execute(
            "DELETE FROM products WHERE id = %s RETURNING id", (product_id,)
        ).fetchone()
    if row is None:
        return jsonify({"served_by": INSTANCE, "error": "producto no encontrado"}), 404
    return jsonify({"served_by": INSTANCE, "deleted": product_id})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
