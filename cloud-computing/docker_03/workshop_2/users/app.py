import socket
from flask import Flask, jsonify

app = Flask(__name__)

# hostname del contenedor (docker le pone el id del contenedor).
# lo agrego a la respuesta para poder ver que instancia respondio cuando hay balanceo
HOSTNAME = socket.gethostname()


# la ruta interna es "/" porque nginx le quita el prefijo /api/users/
@app.get("/")
def home():
    return jsonify({
        "service": "users",
        "message": "Servicio de usuarios",
        "instance": HOSTNAME
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
