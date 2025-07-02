-- Base de datos para gestión de amigos
CREATE DATABASE IF NOT EXISTS amigos_db;
USE amigos_db;

-- Tabla de géneros
CREATE TABLE generos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de amigos
CREATE TABLE amigos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    genero_id INT,
    categoria_id INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genero_id) REFERENCES generos(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabla de amistades (relación muchos a muchos)
CREATE TABLE amistades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amigo1_id INT NOT NULL,
    amigo2_id INT NOT NULL,
    fecha_amistad DATE NOT NULL,
    estado ENUM('pendiente', 'aceptada', 'rechazada') DEFAULT 'pendiente',
    FOREIGN KEY (amigo1_id) REFERENCES amigos(id),
    FOREIGN KEY (amigo2_id) REFERENCES amigos(id)
);

-- Insertar géneros
INSERT INTO generos (nombre) VALUES
('Masculino'),
('Femenino'),
('No binario'),
('Prefiero no decir');

-- Insertar categorías
INSERT INTO categorias (nombre) VALUES
('Trabajo'),
('Colegio'),
('Universidad'),
('Vecinos'),
('Internet'),
('Familia'),
('Deporte'),
('Hobby');

-- Insertar amigos de ejemplo
INSERT INTO amigos (nombre, apellido, fecha_nacimiento, email, telefono, ciudad, genero_id, categoria_id) VALUES
('Juan', 'Pérez', '1990-05-15', 'juan.perez@email.com', '555-0123', 'Madrid', 1, 1),
('María', 'García', '1988-12-03', 'maria.garcia@email.com', '555-0456', 'Barcelona', 2, 2),
('Carlos', 'López', '1992-08-22', 'carlos.lopez@email.com', '555-0789', 'Valencia', 1, 3),
('Ana', 'Martínez', '1985-11-10', 'ana.martinez@email.com', '555-0321', 'Sevilla', 2, 1),
('Luis', 'Rodríguez', '1993-03-07', 'luis.rodriguez@email.com', '555-0654', 'Bilbao', 1, 4),
('Carmen', 'Sánchez', '1991-07-18', 'carmen.sanchez@email.com', '555-0987', 'Málaga', 2, 5),
('David', 'Torres', '1989-04-25', 'david.torres@email.com', '555-0147', 'Zaragoza', 1, 6),
('Laura', 'Ruiz', '1994-09-12', 'laura.ruiz@email.com', '555-0258', 'Murcia', 2, 7),
('Miguel', 'Jiménez', '1987-01-30', 'miguel.jimenez@email.com', '555-0369', 'Palma', 1, 8),
('Elena', 'Moreno', '1995-06-08', 'elena.moreno@email.com', '555-0741', 'Las Palmas', 2, 2);

-- Insertar algunas amistades
INSERT INTO amistades (amigo1_id, amigo2_id, fecha_amistad, estado) VALUES
(1, 2, '2023-01-15', 'aceptada'),
(1, 3, '2023-02-20', 'aceptada'),
(2, 4, '2023-03-10', 'aceptada'),
(3, 5, '2023-04-05', 'pendiente'),
(4, 6, '2023-05-12', 'aceptada'),
(5, 7, '2023-06-18', 'aceptada'),
(6, 8, '2023-07-22', 'rechazada'),
(7, 9, '2023-08-14', 'aceptada'),
(8, 10, '2023-09-03', 'pendiente'),
(9, 1, '2023-10-11', 'aceptada');

-- Consultas útiles
-- Ver todos los amigos con su información completa
SELECT 
    a.nombre, 
    a.apellido, 
    a.email, 
    a.telefono, 
    a.ciudad,
    g.nombre as genero,
    c.nombre as categoria
FROM amigos a
LEFT JOIN generos g ON a.genero_id = g.id
LEFT JOIN categorias c ON a.categoria_id = c.id;

-- Ver amistades aceptadas
SELECT 
    a1.nombre as amigo1,
    a1.apellido as apellido1,
    a2.nombre as amigo2,
    a2.apellido as apellido2,
    am.fecha_amistad
FROM amistades am
JOIN amigos a1 ON am.amigo1_id = a1.id
JOIN amigos a2 ON am.amigo2_id = a2.id
WHERE am.estado = 'aceptada';

-- Contar amigos por categoría
SELECT 
    c.nombre as categoria,
    COUNT(a.id) as total_amigos
FROM categorias c
LEFT JOIN amigos a ON c.id = a.categoria_id
GROUP BY c.id, c.nombre
ORDER BY total_amigos DESC;
