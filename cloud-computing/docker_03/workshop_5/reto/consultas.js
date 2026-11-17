// consultas para comprobar el reto (se corren desde pruebas.sh)
use tienda

show collections

db.customers.find()
db.products.find()
db.orders.find()

// ordenes de Ana (customerId 1)
db.orders.find({ customerId: 1 })

// ordenes que incluyen un Mouse (busca dentro del arreglo items)
db.orders.find({ "items.product": "Mouse" })

// total gastado por cliente: se "desarma" el arreglo items con $unwind,
// se multiplica cantidad por precio y se agrupa por cliente.
// $lookup trae el nombre desde customers (parecido a un JOIN)
db.orders.aggregate([
  { $unwind: "$items" },
  { $group: { _id: "$customerId", total: { $sum: { $multiply: ["$items.quantity", "$items.unitPrice"] } } } },
  { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "cliente" } },
  { $project: { _id: 0, cliente: { $arrayElemAt: ["$cliente.name", 0] }, total: 1 } }
])
