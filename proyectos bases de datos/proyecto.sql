-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-05-2025 a las 05:07:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `Carnet` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Carrera` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`Carnet`, `Nombre`, `Carrera`) VALUES
(600000, 'Rojas', 'Química'),
(700000, 'Méndez', 'Historia'),
(800000, 'Castro', 'Matemática'),
(900000, 'Murillo', 'Química');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `CodMateria` varchar(10) NOT NULL,
  `Grupo` varchar(5) NOT NULL,
  `Prof` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`CodMateria`, `Grupo`, `Prof`) VALUES
('A20', '02', 1111),
('B20', '01', 1111),
('A20', '01', 2222),
('C20', '01', 2222),
('C20', '02', 2222),
('A21', '01', 3333),
('D20', '02', 3333);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `CodMateria` varchar(10) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Creditos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`CodMateria`, `Nombre`, `Creditos`) VALUES
('A20', 'Ciencias', 4),
('A21', 'Biología', 3),
('B20', 'Matemátic', 5),
('C20', 'Español', 4),
('D20', 'Inglés', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `Carnet` int(11) NOT NULL,
  `CodMateria` varchar(10) NOT NULL,
  `Grupo` varchar(5) NOT NULL,
  `Nota` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`Carnet`, `CodMateria`, `Grupo`, `Nota`) VALUES
(600000, 'A20', '01', 100),
(600000, 'A21', '01', 95),
(700000, 'B20', '01', 80),
(800000, 'B20', '01', 70),
(800000, 'D20', '02', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `Cedula` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`Cedula`, `Nombre`, `Telefono`) VALUES
(1111, 'Pérez', '4410926'),
(2222, 'Arce', '4426578'),
(3333, 'Alvarez', '2467865'),
(4444, 'Rojas ', '5551234');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`Carnet`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`CodMateria`,`Grupo`),
  ADD KEY `Prof` (`Prof`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`CodMateria`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`Carnet`,`CodMateria`,`Grupo`),
  ADD KEY `CodMateria` (`CodMateria`,`Grupo`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`Cedula`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`CodMateria`) REFERENCES `materia` (`CodMateria`),
  ADD CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`Prof`) REFERENCES `profesor` (`Cedula`);

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`Carnet`) REFERENCES `estudiante` (`Carnet`),
  ADD CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`CodMateria`,`Grupo`) REFERENCES `grupo` (`CodMateria`, `Grupo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
