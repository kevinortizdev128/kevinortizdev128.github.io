-- 1. Crear la base de datos 
CREATE DATABASE IF NOT EXISTS colegio;
USE colegio;

-- 2. Crear tablas

CREATE TABLE estudiante (
    Carnet INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Carrera VARCHAR(50)
);

CREATE TABLE profesor (
    Cedula INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Telefono VARCHAR(20)
);

CREATE TABLE materia (
    CodMateria VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(50),
    Creditos INT
);

CREATE TABLE grupo (
    CodMateria VARCHAR(10),
    Grupo VARCHAR(5),
    Prof INT,
    PRIMARY KEY (CodMateria, Grupo),
    FOREIGN KEY (CodMateria) REFERENCES materia(CodMateria),
    FOREIGN KEY (Prof) REFERENCES profesor(Cedula)
);

CREATE TABLE matricula (
    Carnet INT,
    CodMateria VARCHAR(10),
    Grupo VARCHAR(5),
    Nota INT,
    PRIMARY KEY (Carnet, CodMateria, Grupo),
    FOREIGN KEY (Carnet) REFERENCES estudiante(Carnet),
    FOREIGN KEY (CodMateria, Grupo) REFERENCES grupo(CodMateria, Grupo)
);

-- 3. Insertar datos de los ejemplos

INSERT INTO estudiante VALUES
(600000, 'Rojas', 'Química'),
(700000, 'Méndez', 'Historia'),
(800000, 'Castro', 'Matemática'),
(900000, 'Murillo', 'Química');

INSERT INTO profesor VALUES
(1111, 'Pérez', '4410926'),
(2222, 'Arce', '4426578'),
(3333, 'Alvarez', '2467865'),
(4444, 'Rojas', '5551234');

INSERT INTO materia VALUES
('A20', 'Ciencias', 4),
('A21', 'Biología', 3),
('B20', 'Matemátic', 5),
('C20', 'Español', 4),
('D20', 'Inglés', 2);

INSERT INTO grupo VALUES
('A20', '02', 1111),
('B20', '01', 1111),
('A20', '01', 2222),
('C20', '01', 2222),
('C20', '02', 2222),
('A21', '01', 3333),
('D20', '02', 3333);

INSERT INTO matricula VALUES
(600000, 'A20', '01', 100),
(600000, 'A21', '01', 95),
(700000, 'B20', '01', 80),
(800000, 'B20', '01', 70),
(800000, 'D20', '02', 50);
