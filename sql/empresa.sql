-- Base de datos para gestión de empresa
CREATE DATABASE IF NOT EXISTS empresa_db;
USE empresa_db;

-- Tabla de departamentos
CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    presupuesto DECIMAL(12,2),
    ubicacion VARCHAR(100),
    fecha_creacion DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de cargos
CREATE TABLE cargos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    salario_minimo DECIMAL(10,2),
    salario_maximo DECIMAL(10,2)
);

-- Tabla de empleados
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    fecha_contratacion DATE,
    salario DECIMAL(10,2),
    departamento_id INT,
    cargo_id INT,
    jefe_id INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
    FOREIGN KEY (cargo_id) REFERENCES cargos(id),
    FOREIGN KEY (jefe_id) REFERENCES empleados(id)
);

-- Tabla de proyectos
CREATE TABLE proyectos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    presupuesto DECIMAL(12,2),
    estado ENUM('Planificación', 'En Progreso', 'Completado', 'Cancelado', 'Pausado') DEFAULT 'Planificación',
    departamento_id INT,
    responsable_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
    FOREIGN KEY (responsable_id) REFERENCES empleados(id)
);

-- Insertar departamentos
INSERT INTO departamentos (nombre, descripcion, presupuesto, ubicacion, fecha_creacion) VALUES
('Desarrollo', 'Departamento de desarrollo de software', 500000.00, 'Piso 3', '2020-01-01'),
('Marketing', 'Departamento de marketing y ventas', 300000.00, 'Piso 1', '2020-01-01'),
('Recursos Humanos', 'Gestión del personal y contrataciones', 200000.00, 'Piso 2', '2020-01-01'),
('Finanzas', 'Control financiero y contabilidad', 250000.00, 'Piso 2', '2020-01-01'),
('Operaciones', 'Gestión de operaciones y logística', 350000.00, 'Piso 1', '2020-06-01');

-- Insertar cargos
INSERT INTO cargos (nombre, descripcion, salario_minimo, salario_maximo) VALUES
('Gerente', 'Responsable de departamento', 70000.00, 120000.00),
('Desarrollador Senior', 'Desarrollador con experiencia avanzada', 60000.00, 85000.00),
('Desarrollador Junior', 'Desarrollador con poca experiencia', 35000.00, 50000.00),
('Analista', 'Analista de sistemas o procesos', 45000.00, 65000.00),
('Especialista', 'Especialista en área específica', 50000.00, 70000.00),
('Coordinador', 'Coordinador de equipos', 55000.00, 75000.00),
('Asistente', 'Asistente administrativo', 25000.00, 35000.00);

-- Insertar empleados
INSERT INTO empleados (nombre, apellido, email, telefono, fecha_nacimiento, fecha_contratacion, salario, departamento_id, cargo_id, jefe_id) VALUES
('Ana', 'García', 'ana.garcia@empresa.com', '555-3001', '1985-03-15', '2021-03-15', 75000.00, 1, 1, NULL),
('Carlos', 'López', 'carlos.lopez@empresa.com', '555-3002', '1988-07-22', '2020-06-01', 80000.00, 2, 1, NULL),
('María', 'Rodríguez', 'maria.rodriguez@empresa.com', '555-3003', '1990-11-08', '2021-01-20', 65000.00, 3, 1, NULL),
('Juan', 'Martínez', 'juan.martinez@empresa.com', '555-3004', '1987-05-30', '2020-11-10', 70000.00, 4, 1, NULL),
('Laura', 'Sánchez', 'laura.sanchez@empresa.com', '555-3005', '1992-09-14', '2022-02-14', 65000.00, 1, 2, 1),
('Diego', 'Torres', 'diego.torres@empresa.com', '555-3006', '1994-01-25', '2022-08-01', 45000.00, 1, 3, 1),
('Carmen', 'Vega', 'carmen.vega@empresa.com', '555-3007', '1989-12-03', '2021-05-10', 55000.00, 2, 4, 2),
('Roberto', 'Silva', 'roberto.silva@empresa.com', '555-3008', '1991-04-18', '2021-09-15', 60000.00, 2, 5, 2),
('Patricia', 'Moreno', 'patricia.moreno@empresa.com', '555-3009', '1993-08-27', '2022-01-03', 50000.00, 3, 5, 3),
('Miguel', 'Herrera', 'miguel.herrera@empresa.com', '555-3010', '1986-06-12', '2020-12-01', 55000.00, 4, 4, 4);

-- Insertar proyectos
INSERT INTO proyectos (nombre, descripcion, fecha_inicio, fecha_fin, presupuesto, estado, departamento_id, responsable_id) VALUES
('Sistema CRM', 'Desarrollo de sistema de gestión de clientes', '2023-01-15', '2024-06-30', 150000.00, 'En Progreso', 1, 1),
('Campaña Digital 2024', 'Campaña de marketing digital para el año 2024', '2024-01-01', '2024-12-31', 80000.00, 'En Progreso', 2, 2),
('Migración de Datos', 'Migración del sistema legacy a la nueva plataforma', '2024-03-01', '2024-09-30', 200000.00, 'Planificación', 1, 5),
('Optimización de Procesos', 'Mejora de procesos internos de RRHH', '2023-09-01', '2024-03-31', 50000.00, 'En Progreso', 3, 3),
('Sistema de Facturación', 'Nuevo sistema automatizado de facturación', '2024-02-01', '2024-08-31', 120000.00, 'Planificación', 4, 4),
('App Móvil Corporativa', 'Desarrollo de aplicación móvil para empleados', '2024-04-01', '2024-11-30', 180000.00, 'Planificación', 1, 1);

-- Consultas útiles
-- Ver empleados con su departamento y cargo
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) as empleado,
    d.nombre as departamento,
    c.nombre as cargo,
    e.salario,
    e.fecha_contratacion
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.id
JOIN cargos c ON e.cargo_id = c.id
WHERE e.activo = TRUE
ORDER BY d.nombre, e.apellido;

-- Ver proyectos con su responsable y departamento
SELECT 
    p.nombre as proyecto,
    p.estado,
    p.fecha_inicio,
    p.fecha_fin,
    p.presupuesto,
    CONCAT(e.nombre, ' ', e.apellido) as responsable,
    d.nombre as departamento
FROM proyectos p
JOIN empleados e ON p.responsable_id = e.id
JOIN departamentos d ON p.departamento_id = d.id
ORDER BY p.fecha_inicio DESC;

-- Estadísticas por departamento
SELECT 
    d.nombre as departamento,
    COUNT(e.id) as total_empleados,
    AVG(e.salario) as salario_promedio,
    SUM(e.salario) as costo_total_salarios,
    COUNT(p.id) as proyectos_activos
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id AND e.activo = TRUE
LEFT JOIN proyectos p ON d.id = p.departamento_id AND p.estado IN ('En Progreso', 'Planificación')
GROUP BY d.id, d.nombre
ORDER BY total_empleados DESC;
