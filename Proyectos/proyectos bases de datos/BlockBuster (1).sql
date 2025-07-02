-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-04-2025 a las 04:39:21
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `video2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `direccion` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES
(1, 'Maria', 'Lopez', '1111-1111', 'Orotina'),
(2, 'Juan', 'Loria', '2222-2222', 'Santo Domingo'),
(3, 'Monica', 'Lara', '3333-3333', 'Puntarenas'),
(4, 'Arturo', 'Castro', '4444-4444', 'Jaco'),
(5, 'Daniela', 'Mora', '5555-5555', 'Turrubares');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `id_detalle` int(11) NOT NULL,
  `id_dvd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle`
--

INSERT INTO `detalle` (`id_detalle`, `id_dvd`) VALUES
(1, 1),
(1, 3),
(1, 5),
(2, 1),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 3),
(3, 5),
(3, 6),
(3, 8),
(4, 1),
(4, 3),
(4, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dvd`
--

CREATE TABLE `dvd` (
  `id_dvd` int(11) NOT NULL,
  `id_video` int(11) DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dvd`
--

INSERT INTO `dvd` (`id_dvd`, `id_video`, `disponible`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 2, 1),
(5, 2, 0),
(6, 3, 1),
(7, 4, 1),
(8, 5, 1),
(9, 5, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha_inic` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `costo` double DEFAULT NULL,
  `multa` double DEFAULT NULL,
  `id_detalle` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id_factura`, `id_cliente`, `fecha_inic`, `fecha_fin`, `costo`, `multa`, `id_detalle`) VALUES
(1, 1, '2022-10-02', '2022-10-05', 3000, 0, 1),
(2, 2, '2022-10-03', '2022-10-05', 4000, 0, 2),
(3, 3, '2022-10-14', '2022-10-16', 5000, 0, 3),
(4, 4, '2022-10-01', '2022-10-04', 3000, 0, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `id_genero` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`id_genero`, `nombre`) VALUES
(1, 'Comedia'),
(2, 'Accion'),
(3, 'Romantica'),
(4, 'Fantacia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `video`
--

CREATE TABLE `video` (
  `id_video` int(11) NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `director` varchar(30) DEFAULT NULL,
  `estreno` date DEFAULT NULL,
  `id_genero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `video`
--

INSERT INTO `video` (`id_video`, `titulo`, `director`, `estreno`, `id_genero`) VALUES
(1, 'Rapidos y furiosos', 'Clint Eastwood', '2013-10-16', 2),
(2, 'El pardrino', 'Martin Scorsese', '1951-12-13', 2),
(3, 'Kill Bill', 'Quentin Tarantino', '1999-11-10', 1),
(4, 'Cartas a Julieta', 'Gary Winick', '2014-12-18', 3),
(5, 'Harry Potter', 'David Yates', '1937-03-31', 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD PRIMARY KEY (`id_detalle`,`id_dvd`),
  ADD KEY `detalle_ibfk_1` (`id_dvd`);

--
-- Indices de la tabla `dvd`
--
ALTER TABLE `dvd`
  ADD PRIMARY KEY (`id_dvd`),
  ADD KEY `dvd_ibfk_1` (`id_video`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `factura_ibfk_1` (`id_cliente`),
  ADD KEY `factura_ibfk_2` (`id_detalle`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id_genero`);

--
-- Indices de la tabla `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id_video`),
  ADD KEY `video_ibfk_1` (`id_genero`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`id_dvd`) REFERENCES `dvd` (`id_dvd`);

--
-- Filtros para la tabla `dvd`
--
ALTER TABLE `dvd`
  ADD CONSTRAINT `dvd_ibfk_1` FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`id_detalle`) REFERENCES `detalle` (`id_detalle`);

--
-- Filtros para la tabla `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`id_genero`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
