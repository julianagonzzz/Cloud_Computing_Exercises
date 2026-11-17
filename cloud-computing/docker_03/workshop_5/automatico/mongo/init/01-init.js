// Parte 3 - script de inicializacion
// mongo lo ejecuta solo cuando /data/db esta vacio (primer arranque o despues de down -v)

// en los scripts no se puede usar "use tienda", se cambia de base asi:
db = db.getSiblingDB('tienda');

db.products.insertMany([
  { name: 'Laptop', price: 3500000, stock: 5 },
  { name: 'Mouse', price: 80000, stock: 20 },
  { name: 'Keyboard', price: 150000, stock: 12 }
]);

db.customers.insertMany([
  { name: 'Ana', email: 'ana@example.com' },
  { name: 'Luis', email: 'luis@example.com' }
]);
