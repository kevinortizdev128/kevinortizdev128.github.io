-- Base de datos para gestión de peluquería
CREATE DATABASE IF NOT EXISTS peluqueria_db;
USE peluqueria_db;

-- Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_nacimiento DATE,
    direccion TEXT,
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de categorías de servicios
CREATE TABLE categorias_servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla de servicios
CREATE TABLE servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(8,2) NOT NULL,
    duracion_minutos INT,
    categoria_id INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (categoria_id) REFERENCES categorias_servicios(id)
);

-- Tabla de estilistas
CREATE TABLE estilistas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    especialidad VARCHAR(100),
    fecha_contratacion DATE,
    comision_porcentaje DECIMAL(5,2) DEFAULT 0.00,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de horarios de trabajo
CREATE TABLE horarios_trabajo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estilista_id INT,
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'),
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (estilista_id) REFERENCES estilistas(id)
);

-- Tabla de citas
CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    estilista_id INT,
    servicio_id INT,
    fecha_cita DATE,
    hora_cita TIME,
    estado ENUM('Programada', 'Completada', 'Cancelada', 'No Show') DEFAULT 'Programada',
    observaciones TEXT,
    precio_final DECIMAL(8,2),
    descuento DECIMAL(8,2) DEFAULT 0.00,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (estilista_id) REFERENCES estilistas(id),
    FOREIGN KEY (servicio_id) REFERENCES servicios(id)
);

-- Insertar categorías de servicios
INSERT INTO categorias_servicios (nombre, descripcion) VALUES
('Cortes', 'Servicios de corte de cabello'),
('Coloración', 'Servicios de tinte y coloración'),
('Peinados', 'Peinados para eventos especiales'),
('Tratamientos', 'Tratamientos capilares y cuidado'),
('Barbería', 'Servicios especializados para hombres'),
('Manicura', 'Cuidado de uñas y manos'),
('Depilación', 'Servicios de depilación');

-- Insertar servicios
INSERT INTO servicios (nombre, descripcion, precio, duracion_minutos, categoria_id) VALUES
('Corte de Cabello Mujer', 'Corte y peinado básico para mujer', 25.00, 45, 1),
('Corte de Cabello Hombre', 'Corte masculino clásico', 18.00, 30, 1),
('Corte y Peinado Premium', 'Corte con lavado y peinado profesional', 35.00, 60, 1),
('Tinte Completo', 'Tinte de cabello completo con productos premium', 65.00, 120, 2),
('Mechas', 'Aplicación de mechas con técnica profesional', 85.00, 150, 2),
('Rayitos', 'Rayitos sutiles para iluminar el rostro', 45.00, 90, 2),
('Peinado de Fiesta', 'Peinado elegante para eventos especiales', 45.00, 60, 3),
('Peinado de Novia', 'Peinado completo para el día de la boda', 120.00, 120, 3),
('Tratamiento Capilar', 'Tratamiento nutritivo y reparador', 35.00, 75, 4),
('Hidratación Profunda', 'Mascarilla hidratante intensiva', 28.00, 60, 4),
('Corte y Barba', 'Corte de cabello y arreglo de barba', 30.00, 50, 5),
('Afeitado Clásico', 'Afeitado tradicional con navaja', 25.00, 40, 5),
('Manicura Básica', 'Limado, cutícula y esmaltado', 15.00, 45, 6),
('Manicura Francesa', 'Manicura con técnica francesa', 20.00, 60, 6),
('Depilación Cejas', 'Depilación y diseño de cejas', 12.00, 20, 7),
('Depilación Facial', 'Depilación de vello facial', 18.00, 30, 7);

-- Insertar estilistas
INSERT INTO estilistas (nombre, apellido, telefono, email, especialidad, fecha_contratacion, comision_porcentaje) VALUES
('Carmen', 'Vega', '555-4001', 'carmen.vega@peluqueria.com', 'Coloración', '2021-05-15', 15.00),
('Roberto', 'Silva', '555-4002', 'roberto.silva@peluqueria.com', 'Cortes Masculinos', '2020-08-20', 12.00),
('Patricia', 'Moreno', '555-4003', 'patricia.moreno@peluqueria.com', 'Peinados de Fiesta', '2022-01-10', 18.00),
('Miguel', 'Herrera', '555-4004', 'miguel.herrera@peluqueria.com', 'Barbería', '2021-11-03', 10.00),
('Sofía', 'Ramírez', '555-4005', 'sofia.ramirez@peluqueria.com', 'Tratamientos', '2022-06-15', 14.00),
('Andrea', 'Castro', '555-4006', 'andrea.castro@peluqueria.com', 'Manicura', '2023-02-01', 20.00);

-- Insertar horarios de trabajo
INSERT INTO horarios_trabajo (estilista_id, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'Lunes', '09:00:00', '18:00:00'),
(1, 'Martes', '09:00:00', '18:00:00'),
(1, 'Miércoles', '09:00:00', '18:00:00'),
(1, 'Jueves', '09:00:00', '18:00:00'),
(1, 'Viernes', '09:00:00', '18:00:00'),
(1, 'Sábado', '08:00:00', '16:00:00'),
(2, 'Martes', '10:00:00', '19:00:00'),
(2, 'Miércoles', '10:00:00', '19:00:00'),
(2, 'Jueves', '10:00:00', '19:00:00'),
(2, 'Viernes', '10:00:00', '19:00:00'),
(2, 'Sábado', '08:00:00', '17:00:00'),
(3, 'Miércoles', '11:00:00', '20:00:00'),
(3, 'Jueves', '11:00:00', '20:00:00'),
(3, 'Viernes', '11:00:00', '20:00:00'),
(3, 'Sábado', '09:00:00', '18:00:00'),
(3, 'Domingo', '10:00:00', '16:00:00');

-- Insertar clientes
INSERT INTO clientes (nombre, apellido, telefono, email, fecha_nacimiento, direccion) VALUES
('Elena', 'Jiménez', '555-5001', 'elena.jimenez@email.com', '1985-07-12', 'Calle Rosa 15'),
('Fernando', 'Castillo', '555-5002', 'fernando.castillo@email.com', '1990-03-25', 'Avenida Sol 42'),
('Lucía', 'Ramos', '555-5003', 'lucia.ramos@email.com', '1988-11-08', 'Plaza Luna 7'),
('Andrés', 'Vargas', '555-5004', 'andres.vargas@email.com', '1992-09-14', 'Calle Estrella 23'),
('Sofía', 'Mendoza', '555-5005', 'sofia.mendoza@email.com', '1987-05-30', 'Avenida Mar 18'),
('Gabriel', 'Ortiz', '555-5006', 'gabriel.ortiz@email.com', '1991-02-17', 'Calle Primavera 31'),
('Valentina', 'Cruz', '555-5007', 'valentina.cruz@email.com', '1989-10-22', 'Plaza Central 89'),
('Mateo', 'Guerrero', '555-5008', 'mateo.guerrero@email.com', '1993-06-05', 'Avenida Norte 156'),
('Isabella', 'Flores', '555-5009', 'isabella.flores@email.com', '1986-12-28', 'Calle Jardín 73'),
('Sebastián', 'Peña', '555-5010', 'sebastian.pena@email.com', '1994-04-11', 'Plaza Libertad 245');

-- Insertar citas de ejemplo
INSERT INTO citas (cliente_id, estilista_id, servicio_id, fecha_cita, hora_cita, estado, precio_final) VALUES
(1, 1, 4, '2024-01-15', '10:00:00', 'Completada', 65.00),
(2, 2, 2, '2024-01-16', '14:30:00', 'Completada', 18.00),
(3, 3, 7, '2024-01-17', '16:00:00', 'Completada', 45.00),
(4, 4, 11, '2024-01-18', '11:00:00', 'Completada', 30.00),
(5, 1, 5, '2024-01-19', '09:30:00', 'Completada', 85.00),
(6, 2, 1, '2024-01-20', '15:00:00', 'Programada', 25.00),
(7, 5, 9, '2024-01-21', '13:00:00', 'Programada', 35.00),
(8, 4, 12, '2024-01-22', '10:30:00', 'Programada', 25.00),
(9, 6, 13, '2024-01-23', '11:30:00', 'Programada', 15.00),
(10, 3, 8, '2024-01-24', '14:00:00', 'Programada', 120.00);

-- Consultas útiles
-- Ver citas programadas con información completa
SELECT 
    c.fecha_cita,
    c.hora_cita,
    CONCAT(cl.nombre, ' ', cl.apellido) as cliente,
    cl.telefono,
    CONCAT(e.nombre, ' ', e.apellido) as estilista,
    s.nombre as servicio,
    s.duracion_minutos,
    c.precio_final,
    c.estado
FROM citas c
JOIN clientes cl ON c.cliente_id = cl.id
JOIN estilistas e ON c.estilista_id = e.id
JOIN servicios s ON c.servicio_id = s.id
WHERE c.estado = 'Programada'
ORDER BY c.fecha_cita, c.hora_cita;

-- Ingresos por estilista
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) as estilista,
    COUNT(c.id) as total_citas,
    SUM(c.precio_final) as ingresos_total,
    AVG(c.precio_final) as ticket_promedio,
    SUM(c.precio_final * e.comision_porcentaje / 100) as comisiones
FROM estilistas e
LEFT JOIN citas c ON e.id = c.estilista_id AND c.estado = 'Completada'
GROUP BY e.id, e.nombre, e.apellido, e.comision_porcentaje
ORDER BY ingresos_total DESC;

-- Servicios más populares
SELECT 
    s.nombre as servicio,
    cat.nombre as categoria,
    COUNT(c.id) as veces_solicitado,
    SUM(c.precio_final) as ingresos_generados,
    AVG(c.precio_final) as precio_promedio
FROM servicios s
LEFT JOIN citas c ON s.id = c.servicio_id AND c.estado = 'Completada'
LEFT JOIN categorias_servicios cat ON s.categoria_id = cat.id
GROUP BY s.id, s.nombre, cat.nombre
ORDER BY veces_solicitado DESC;
