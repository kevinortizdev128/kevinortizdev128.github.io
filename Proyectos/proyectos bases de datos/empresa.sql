-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2025 a las 04:47:03
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
-- Base de datos: `empresa`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_hijos` ()   BEGIN
   SELECT nombre, apellido, sueldo, cantidadhijos
   FROM empleados
   WHERE cantidadhijos > 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_empleados_hijos_minimo` (`min_hijos` INT)   BEGIN
   SELECT nombre, apellido, cantidadhijos
   FROM empleados
   WHERE cantidadhijos >= min_hijos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seccion` (`Nombre` VARCHAR(50))   BEGIN
	SELECT ep.nombre
    FROM empleados ep 
    WHERE ep.seccion = Nombre;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `documento` char(8) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido` varchar(20) DEFAULT NULL,
  `sueldo` decimal(6,2) DEFAULT NULL,
  `cantidadhijos` int(11) DEFAULT NULL,
  `seccion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`documento`, `nombre`, `apellido`, `sueldo`, `cantidadhijos`, `seccion`) VALUES
('22222222', 'Juan', 'Perez', 300.00, 2, 'Contaduria'),
('22333333', 'Luis', 'Lopez', 300.00, 0, 'Contaduria'),
('22444444', 'Marta', 'Perez', 500.00, 1, 'Sistemas'),
('22555555', 'Susana', 'Garcia', 400.00, 2, 'Secretaria'),
('22666666', 'Jose Maria', 'Morales', 400.00, 3, 'Secretaria');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`documento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
