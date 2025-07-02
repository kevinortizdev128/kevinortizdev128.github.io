-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2025 a las 05:03:46
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `peluqueria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `servicio` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `fecha_hora`, `id_cliente`, `id_empleado`, `servicio`) VALUES
(1, '2025-06-01 10:00:00', 1, 1, 'Corte y peinado'),
(2, '2025-06-01 11:00:00', 2, 2, 'Coloración básica'),
(3, '2025-06-02 10:00:00', 4, 3, 'Manicure básico'),
(4, '2025-06-02 11:30:00', 5, 4, 'Corte de barba'),
(5, '2025-06-03 14:00:00', 3, 3, 'Uñas acrílicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES
(1, 'Ana Pérez', '8999-1111'),
(2, 'Luis Fernández', '8999-2222'),
(3, 'Laura Pineda', '8888-1111'),
(4, 'Carlos Mora', '8787-2222'),
(5, 'Ana Zamora', '8989-3333');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `especialidad` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `especialidad`, `telefono`) VALUES
(1, 'María López', 'Corte de cabello', '8888-1111'),
(2, 'Carlos Ruiz', 'Coloración', '8888-2222'),
(3, 'Karla Jiménez', 'Uñas acrílicas', '8888-3333'),
(4, 'Luis Álvarez', 'Barbería', '8888-4444');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas_dia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas_dia` (
`fecha` date
,`hora` time
,`nombre_cliente` varchar(50)
,`nombre_empleado` varchar(50)
,`servicio` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas_programadas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas_programadas` (
`id_cita` int(11)
,`fecha_hora` datetime
,`nombre_cliente` varchar(50)
,`nombre_empleado` varchar(50)
,`especialidad` varchar(50)
,`servicio` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_historial_cliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_historial_cliente` (
`id_cliente` int(11)
,`nombre_cliente` varchar(50)
,`fecha_hora` datetime
,`nombre_empleado` varchar(50)
,`servicio` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_servicios_por_empleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_servicios_por_empleado` (
`id_empleado` int(11)
,`nombre_empleado` varchar(50)
,`total_servicios` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas_dia`
--
DROP TABLE IF EXISTS `vista_citas_dia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas_dia`  AS SELECT cast(`c`.`fecha_hora` as date) AS `fecha`, cast(`c`.`fecha_hora` as time) AS `hora`, `cl`.`nombre` AS `nombre_cliente`, `e`.`nombre` AS `nombre_empleado`, `c`.`servicio` AS `servicio` FROM ((`cita` `c` join `cliente` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `empleado` `e` on(`c`.`id_empleado` = `e`.`id_empleado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas_programadas`
--
DROP TABLE IF EXISTS `vista_citas_programadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas_programadas`  AS SELECT `c`.`id_cita` AS `id_cita`, `c`.`fecha_hora` AS `fecha_hora`, `cl`.`nombre` AS `nombre_cliente`, `e`.`nombre` AS `nombre_empleado`, `e`.`especialidad` AS `especialidad`, `c`.`servicio` AS `servicio` FROM ((`cita` `c` join `cliente` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `empleado` `e` on(`c`.`id_empleado` = `e`.`id_empleado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_historial_cliente`
--
DROP TABLE IF EXISTS `vista_historial_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_historial_cliente`  AS SELECT `cl`.`id_cliente` AS `id_cliente`, `cl`.`nombre` AS `nombre_cliente`, `c`.`fecha_hora` AS `fecha_hora`, `e`.`nombre` AS `nombre_empleado`, `c`.`servicio` AS `servicio` FROM ((`cita` `c` join `cliente` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `empleado` `e` on(`c`.`id_empleado` = `e`.`id_empleado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_servicios_por_empleado`
--
DROP TABLE IF EXISTS `vista_servicios_por_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_servicios_por_empleado`  AS SELECT `e`.`id_empleado` AS `id_empleado`, `e`.`nombre` AS `nombre_empleado`, count(`c`.`id_cita`) AS `total_servicios` FROM (`empleado` `e` left join `cita` `c` on(`e`.`id_empleado` = `c`.`id_empleado`)) GROUP BY `e`.`id_empleado`, `e`.`nombre` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
