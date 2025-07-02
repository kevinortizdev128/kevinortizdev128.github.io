-- Base de datos para gestión de colegio
CREATE DATABASE IF NOT EXISTS colegio_db;
USE colegio_db;

-- Tabla de grados
CREATE TABLE grados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nivel VARCHAR(20) NOT NULL
);

-- Tabla de estudiantes
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    grado_id INT,
    email VARCHAR(100),
    telefono_contacto VARCHAR(20),
    direccion TEXT,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (grado_id) REFERENCES grados(id)
);

-- Tabla de profesores
CREATE TABLE profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_contratacion DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de materias
CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    creditos INT,
    profesor_id INT,
    grado_id INT,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (grado_id) REFERENCES grados(id)
);

-- Tabla de calificaciones
CREATE TABLE calificaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    materia_id INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    tipo_evaluacion ENUM('examen', 'tarea', 'proyecto', 'participacion') DEFAULT 'examen',
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (materia_id) REFERENCES materias(id)
);

-- Tabla de asistencia
CREATE TABLE asistencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    materia_id INT NOT NULL,
    fecha DATE NOT NULL,
    presente BOOLEAN DEFAULT TRUE,
    observaciones TEXT,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (materia_id) REFERENCES materias(id)
);

-- Insertar grados
INSERT INTO grados (nombre, nivel) VALUES
('Séptimo', 'Secundaria'),
('Octavo', 'Secundaria'),
('Noveno', 'Secundaria'),
('Décimo', 'Secundaria'),
('Undécimo', 'Secundaria');

-- Insertar profesores
INSERT INTO profesores (nombre, apellido, especialidad, email, telefono, fecha_contratacion) VALUES
('Dr. Pedro', 'González', 'Matemáticas', 'pedro.gonzalez@colegio.edu', '555-1001', '2020-01-15'),
('Dra. Carmen', 'Ruiz', 'Ciencias Naturales', 'carmen.ruiz@colegio.edu', '555-1002', '2019-08-20'),
('Prof. Miguel', 'Torres', 'Historia', 'miguel.torres@colegio.edu', '555-1003', '2021-02-10'),
('Lic. Ana', 'Vega', 'Lengua y Literatura', 'ana.vega@colegio.edu', '555-1004', '2020-06-05'),
('Prof. Carlos', 'Morales', 'Educación Física', 'carlos.morales@colegio.edu', '555-1005', '2021-09-01'),
('Lic. María', 'Herrera', 'Inglés', 'maria.herrera@colegio.edu', '555-1006', '2020-03-12');

-- Insertar materias
INSERT INTO materias (nombre, descripcion, creditos, profesor_id, grado_id) VALUES
('Álgebra', 'Fundamentos de álgebra para secundaria', 4, 1, 2),
('Geometría', 'Conceptos básicos de geometría', 3, 1, 3),
('Biología', 'Introducción a la biología celular', 3, 2, 2),
('Química', 'Fundamentos de química general', 4, 2, 4),
('Historia Universal', 'Historia desde la antigüedad hasta el siglo XX', 3, 3, 3),
('Historia Nacional', 'Historia del país y cultura local', 3, 3, 4),
('Literatura', 'Análisis de textos literarios clásicos', 3, 4, 3),
('Gramática', 'Reglas gramaticales y ortografía', 2, 4, 2),
('Inglés Básico', 'Fundamentos del idioma inglés', 3, 6, 2),
('Inglés Intermedio', 'Conversación y gramática avanzada', 3, 6, 4),
('Educación Física', 'Desarrollo físico y deportes', 2, 5, 2);

-- Insertar estudiantes
INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, grado_id, email, telefono_contacto, direccion) VALUES
('Sofia', 'Hernández', '2008-04-12', 2, 'sofia.hernandez@estudiante.edu', '555-2001', 'Calle Principal 123'),
('Diego', 'Morales', '2007-09-25', 4, 'diego.morales@estudiante.edu', '555-2002', 'Avenida Central 456'),
('Isabella', 'Castro', '2008-01-18', 2, 'isabella.castro@estudiante.edu', '555-2003', 'Plaza Mayor 789'),
('Alejandro', 'Ramírez', '2007-11-30', 4, 'alejandro.ramirez@estudiante.edu', '555-2004', 'Calle Secundaria 321'),
('Valentina', 'Silva', '2008-06-15', 3, 'valentina.silva@estudiante.edu', '555-2005', 'Avenida Norte 654'),
('Sebastián', 'Vargas', '2007-03-22', 4, 'sebastian.vargas@estudiante.edu', '555-2006', 'Calle Sur 987'),
('Camila', 'Mendoza', '2008-08-08', 2, 'camila.mendoza@estudiante.edu', '555-2007', 'Plaza Central 147'),
('Mateo', 'Jiménez', '2007-12-05', 3, 'mateo.jimenez@estudiante.edu', '555-2008', 'Avenida Este 258');

-- Insertar calificaciones de ejemplo
INSERT INTO calificaciones (estudiante_id, materia_id, nota, fecha_evaluacion, tipo_evaluacion) VALUES
(1, 1, 8.5, '2024-03-15', 'examen'),
(1, 3, 9.0, '2024-03-16', 'proyecto'),
(2, 2, 7.8, '2024-03-15', 'examen'),
(2, 4, 8.2, '2024-03-17', 'tarea'),
(3, 1, 9.2, '2024-03-15', 'examen'),
(3, 8, 8.7, '2024-03-18', 'participacion'),
(4, 6, 8.9, '2024-03-19', 'proyecto'),
(4, 10, 7.5, '2024-03-20', 'examen'),
(5, 5, 8.3, '2024-03-21', 'tarea'),
(5, 7, 9.1, '2024-03-22', 'examen');

-- Consultas útiles
-- Ver estudiantes con su grado
SELECT 
    e.nombre, 
    e.apellido, 
    g.nombre as grado,
    e.email,
    e.telefono_contacto
FROM estudiantes e
JOIN grados g ON e.grado_id = g.id
WHERE e.activo = TRUE;

-- Ver materias con sus profesores
SELECT 
    m.nombre as materia,
    m.creditos,
    CONCAT(p.nombre, ' ', p.apellido) as profesor,
    g.nombre as grado
FROM materias m
JOIN profesores p ON m.profesor_id = p.id
JOIN grados g ON m.grado_id = g.id;

-- Promedio de calificaciones por estudiante
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) as estudiante,
    AVG(c.nota) as promedio,
    COUNT(c.id) as total_evaluaciones
FROM estudiantes e
LEFT JOIN calificaciones c ON e.id = c.estudiante_id
GROUP BY e.id, e.nombre, e.apellido
ORDER BY promedio DESC;
