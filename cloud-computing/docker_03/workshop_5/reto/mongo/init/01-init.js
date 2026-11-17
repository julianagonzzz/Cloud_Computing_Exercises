// Parte 5 - reto de modelado: products, customers y orders

db = db.getSiblingDB('tienda');

// a customers le pongo _id numerico para que coincida con el customerId del enunciado
// (si no, mongo genera un ObjectId automatico)
db.customers.insertMany([
  { _id: 1, name: 'Ana', email: 'ana@example.com', address: { city: 'Cali', neighborhood: 'San Fernando' } },
  { _id: 2, name: 'Luis', email: 'luis@example.com', address: { city: 'Bogota', neighborhood: 'Chapinero' } },
  { _id: 3, name: 'Marta', email: 'marta@example.com', address: { city: 'Medellin', neighborhood: 'Laureles' } }
]);

db.products.insertMany([
  { name: 'Laptop', price: 3500000, stock: 5 },
  { name: 'Mouse', price: 80000, stock: 20 },
  { name: 'Keyboard', price: 150000, stock: 12 },
  { name: 'Monitor', price: 900000, stock: 7 }
]);

// las ordenes guardan los items ADENTRO del documento (arreglo de subdocumentos)
// el precio se copia en el item para que la orden no cambie si despues cambia el precio del producto
db.orders.insertMany([
  {
    customerId: 1,
    date: ISODate('2026-08-24T00:00:00Z'),
    items: [
      { product: 'Laptop', quantity: 1, unitPrice: 3500000 },
      { product: 'Mouse', quantity: 2, unitPrice: 80000 }
    ],
    status: 'entregada'
  },
  {
    customerId: 2,
    date: ISODate('2026-08-25T00:00:00Z'),
    items: [
      { product: 'Keyboard', quantity: 1, unitPrice: 150000 }
    ],
    status: 'pendiente'
  },
  {
    customerId: 1,
    date: ISODate('2026-09-02T00:00:00Z'),
    items: [
      { product: 'Monitor', quantity: 2, unitPrice: 900000 }
    ],
    status: 'pendiente'
  }
]);

// indice para buscar rapido las ordenes de un cliente
db.orders.createIndex({ customerId: 1 });
