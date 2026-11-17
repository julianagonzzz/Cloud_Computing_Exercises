# Workshop 5 - Comparación PostgreSQL vs MongoDB

1. ¿Qué diferencia existe entre tabla y colección?

Una tabla en PostgreSQL tiene un esquema fijo: hay que definir antes las columnas y sus tipos, y todas las filas los cumplen. Una colección en MongoDB es un grupo de documentos que no necesita esquema previo. Incluso se crea sola al insertar el primer documento, y cada documento puede tener campos distintos.

2. ¿Qué diferencia existe entre fila y documento?

Una fila tiene un valor por cada columna de la tabla y todo es plano. Un documento es tipo JSON (BSON), puede tener solo los campos que necesite y además puede tener objetos y arreglos adentro. Por ejemplo, en el workshop el Monitor tiene `specs` y `tags` y los otros productos no, y no hubo que cambiar nada para eso.

3. ¿Qué ventaja ofrecen los documentos anidados?

Que la información que se usa junta queda guardada junta. Una orden trae sus items adentro, entonces con una sola consulta ya se tiene la orden completa sin hacer JOINs. También se puede consultar dentro de lo anidado, como `db.orders.find({ "items.product": "Mouse" })`.

4. ¿Qué riesgos tiene duplicar datos en documentos?

Que los datos queden inconsistentes. Si el nombre de un producto está copiado en muchas órdenes y después se cambia, hay que actualizarlo en todos lados o van a quedar versiones distintas. Además ocupa más espacio y no hay llaves foráneas que obliguen a que, por ejemplo, el `customerId` de una orden exista de verdad. Hay casos donde sí conviene copiar, como el precio en el item de la orden, porque ahí lo que importa es el precio al que se vendió y no el actual.

5. ¿Qué tipos de aplicaciones podrían beneficiarse de MongoDB?

Las que manejan datos con estructura variable o que cambia mucho: catálogos de productos con características diferentes, contenido de blogs o redes sociales, perfiles de usuario, logs y eventos, y datos de sensores IoT donde cada dispositivo manda campos distintos. También sirve cuando se necesita escalar horizontalmente con mucho volumen de escrituras.

6. ¿Qué modelo resulta más adecuado para el ejercicio universitario y por qué?

PostgreSQL. Los datos de la universidad son muy relacionales y con estructura fija: profesores que dictan cursos y estudiantes que se inscriben en muchos cursos (muchos a muchos). Con llaves foráneas la base misma no deja inscribir a un estudiante en un curso que no existe, y con los JOIN es fácil sacar reportes como las notas por curso o los cursos de un profesor. En MongoDB habría que duplicar datos o hacer varias consultas, y la integridad dependería de la aplicación.
