-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-05-2025 a las 23:09:25
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
-- Base de datos: `colegio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `Carnet` int(20) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `carrera` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`Carnet`, `Nombre`, `carrera`) VALUES
(600000, 'Rojas', 'Química'),
(700000, 'Méndez', 'Historia'),
(800000, 'Castro', 'Matemática'),
(900000, 'Murillo', 'Química');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `codmateria` varchar(20) NOT NULL,
  `grupo` int(20) NOT NULL,
  `prof` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`codmateria`, `grupo`, `prof`) VALUES
('A20', 1, 2222),
('A20', 2, 1111),
('A21', 1, 3333),
('B20', 1, 1111),
('C20', 1, 2222),
('C20', 2, 2222),
('D20', 2, 3333);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `codmateria` varchar(20) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `creditos` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`codmateria`, `Nombre`, `creditos`) VALUES
('A20', 'Ciencias', 4),
('A21', 'Biología', 3),
('B20', 'Matemátic', 5),
('C20', 'Español', 4),
('D20', 'Inglés', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `cedula` int(20) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `telefono` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`cedula`, `Nombre`, `telefono`) VALUES
(1111, 'Perez', 4410926),
(2222, 'Arce', 4426578),
(3333, 'Alvarez', 2467865);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`Carnet`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD KEY `codmateria` (`codmateria`),
  ADD KEY `prof` (`prof`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`codmateria`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`cedula`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`codmateria`) REFERENCES `materia` (`codmateria`),
  ADD CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`prof`) REFERENCES `profesor` (`cedula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
