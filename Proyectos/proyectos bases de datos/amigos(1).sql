-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-05-2025 a las 23:37:54
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
-- Base de datos: `amigos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amigos`
--

CREATE TABLE `amigos` (
  `id_amigos` int(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `id_categoria_amigos` int(20) DEFAULT NULL,
  `id_genero` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `amigos`
--

INSERT INTO `amigos` (`id_amigos`, `nombre`, `apellido`, `fecha_nacimiento`, `email`, `telefono`, `id_categoria_amigos`, `id_genero`) VALUES
(1, 'Bruce', 'Wayne', '1972-02-19', 'bruce.wayne@dc.com', '5551000', 1, 1),
(2, 'Clark', 'Kent', '1978-06-18', 'clark.kent@dc.com', '5551001', 1, 1),
(3, 'Diana', 'Prince', '1985-03-10', 'diana.prince@dc.com', '5551002', 2, 2),
(4, 'Barry', 'Allen', '1990-09-29', 'barry.allen@dc.com', '5551003', 3, 1),
(5, 'Arthur', 'Curry', '1983-01-07', 'arthur.curry@dc.com', '5551004', 3, 1),
(6, 'Victor', 'Stone', '1995-05-15', 'victor.stone@dc.com', '5551005', 4, 1),
(7, 'Hal', 'Jordan', '1982-11-25', 'hal.jordan@dc.com', '5551006', 5, 1),
(8, 'Selina', 'Kyle', '1986-08-03', 'selina.kyle@dc.com', '5551007', 2, 2),
(9, 'Tony', 'Stark', '1970-05-29', 'tony.stark@marvel.com', '5551008', 1, 1),
(10, 'Steve', 'Rogers', '1918-07-04', 'steve.rogers@marvel.com', '5551009', 2, 1),
(11, 'Natasha', 'Romanoff', '1984-11-22', 'natasha.romanoff@marvel.com', '5551010', 3, 2),
(12, 'Peter', 'Parker', '2001-08-10', 'peter.parker@marvel.com', '5551011', 3, 1),
(13, 'Wanda', 'Maximoff', '1990-02-13', 'wanda.maximoff@marvel.com', '5551012', 4, 2),
(14, 'Stephen', 'Strange', '1976-10-15', 'stephen.strange@marvel.com', '5551013', 4, 1),
(15, 'Carol', 'Danvers', '1987-04-17', 'carol.danvers@marvel.com', '5551014', 5, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(20) NOT NULL,
  `nombre_categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre_categoria`) VALUES
(1, 'Trabajo'),
(2, 'Colegio'),
(3, 'Vecinos'),
(4, 'Internet'),
(5, 'Vecinos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gnero`
--

CREATE TABLE `gnero` (
  `id_genero` int(20) NOT NULL,
  `nombre_genero` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `gnero`
--

INSERT INTO `gnero` (`id_genero`, `nombre_genero`) VALUES
(1, 'masculino'),
(2, 'femenino');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD KEY `id_categoria_amigos` (`id_categoria_amigos`),
  ADD KEY `id_genero` (`id_genero`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `gnero`
--
ALTER TABLE `gnero`
  ADD PRIMARY KEY (`id_genero`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD CONSTRAINT `amigos_ibfk_1` FOREIGN KEY (`id_categoria_amigos`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `amigos_ibfk_2` FOREIGN KEY (`id_genero`) REFERENCES `gnero` (`id_genero`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
