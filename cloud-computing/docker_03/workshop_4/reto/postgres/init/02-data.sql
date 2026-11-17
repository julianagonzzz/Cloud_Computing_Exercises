-- Reto - datos de prueba
-- el orden importa por las llaves foraneas: primero teachers y students, despues courses y al final enrollments

INSERT INTO academia.teachers (name, email) VALUES
('Carlos Ruiz', 'cruiz@example.com'),
('Laura Gomez', 'lgomez@example.com');

INSERT INTO academia.students (name, email) VALUES
('Ana', 'ana@example.com'),
('Luis', 'luis@example.com'),
('Marta', 'marta@example.com'),
('Juliana', 'juliana@example.com');

INSERT INTO academia.courses (name, credits, teacher_id) VALUES
('Cloud Computing', 3, 1),
('Internet of Things', 4, 1),
('Bases de Datos', 3, 2);

INSERT INTO academia.enrollments (student_id, course_id, grade) VALUES
(1, 1, 4.5),
(1, 2, 3.8),
(2, 1, 4.0),
(3, 3, NULL),   -- todavia sin nota
(4, 1, 4.7),
(4, 2, NULL),
(4, 3, 4.2);
