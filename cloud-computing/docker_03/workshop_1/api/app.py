import os
from flask import Flask, jsonify

app = Flask(__name__)

# el nombre de la instancia viene de la variable de entorno INSTANCE
# (se define en el docker-compose para cada servicio). Si no existe, queda "api-local"
INSTANCE = os.getenv("INSTANCE", "api-local")


@app.get("/")
def home():
    # devolvemos tambien la instancia para poder ver cual respondio
    return jsonify({
        "message": "Hola desde Flask",
        "instance": INSTANCE
    })


# Reto: endpoint de salud.
# Lo puede consultar el balanceador (o docker) para saber si la instancia esta viva
@app.get("/health")
def health():
    return jsonify({
        "status": "ok",
        "instance": INSTANCE
    })


if __name__ == "__main__":
    # 0.0.0.0 para que acepte conexiones desde fuera del contenedor, no solo localhost
    app.run(host="0.0.0.0", port=5000)
