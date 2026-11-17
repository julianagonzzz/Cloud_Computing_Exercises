// Parte 1 y 2 - comandos escritos a mano en mongosh
// (entrar con: docker compose exec mongo mongosh -u admin -p admin --authenticationDatabase admin)

// cambia a la base tienda (si no existe, se crea cuando se guarde el primer documento)
use tienda

// en mongo no es obligatorio crear la coleccion antes, pero aqui se hace explicito
db.createCollection("products")

db.products.insertMany([
  { name: "Laptop", price: 3500000, stock: 5 },
  { name: "Mouse", price: 80000, stock: 20 },
  { name: "Keyboard", price: 150000, stock: 12 }
])

db.products.find()

// ---------- Parte 2: explorar ----------
show dbs
show collections

db.products.countDocuments()

// $gt = mayor que -> productos con mas de 10 unidades
db.products.find({ stock: { $gt: 10 } })

// documento con estructuras anidadas: un objeto (specs) y un arreglo (tags)
// no hace falta cambiar ningun "esquema" para que tenga campos distintos a los otros
db.products.insertOne({
  name: "Monitor",
  price: 900000,
  stock: 7,
  specs: { size: "27 pulgadas", resolution: "2560x1440", ports: ["HDMI", "DisplayPort"] },
  tags: ["oficina", "gaming"]
})

// se puede consultar dentro del objeto anidado con notacion de punto
db.products.find({ "specs.size": "27 pulgadas" })

// y buscar un valor dentro del arreglo
db.products.find({ tags: "gaming" })
