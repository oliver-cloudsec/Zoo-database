-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-09-2025 a las 04:01:31
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Zoo_7`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areaveterinaria`
--

CREATE TABLE `areaveterinaria` (
  `id_area` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areaveterinaria`
--

INSERT INTO `areaveterinaria` (`id_area`, `nombre`) VALUES
(1, 'Consulta general'),
(2, 'Cirugía veterinaria'),
(3, 'Cuarentena y aislamiento'),
(4, 'Rehabilitación animal'),
(5, 'Laboratorio de análisis clínicos'),
(6, 'Nutrición y dietética'),
(7, 'Manejo y contención de fauna'),
(8, 'Reproducción y genética'),
(9, 'Control de enfermedades infecciosas'),
(10, 'Investigación y bienestar animal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoherramienta`
--

CREATE TABLE `estadoherramienta` (
  `id_estado` int(11) NOT NULL,
  `descripcion` enum('EN_BUEN_ESTADO','REQUIERE_MANTENIMIENTO','PRESTADA','SIN_STOCK','REEMPLAZAR') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estadoherramienta`
--

INSERT INTO `estadoherramienta` (`id_estado`, `descripcion`) VALUES
(1, 'EN_BUEN_ESTADO'),
(2, 'REQUIERE_MANTENIMIENTO'),
(3, 'PRESTADA'),
(4, 'SIN_STOCK'),
(5, 'EN_BUEN_ESTADO'),
(6, 'REQUIERE_MANTENIMIENTO'),
(7, 'PRESTADA'),
(8, 'SIN_STOCK'),
(9, 'EN_BUEN_ESTADO'),
(10, 'REEMPLAZAR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramienta`
--

CREATE TABLE `herramienta` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `enUso` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT INTO `herramienta` (`clave`, `nombre`, `id_estado`, `id_zona`, `stock`, `enUso`) VALUES
(11, 'Taladro', 1, 1, 5, 0),
(12, 'Sierra Eléctrica', 2, 1, 2, 1),
(13, 'Destornillador Eléctrico', 1, 2, 8, 0),
(14, 'Martillo', 3, 2, 0, 1),
(15, 'Llave Inglesa', 4, 3, 0, 0),
(16, 'Pala', 1, 3, 10, 0),
(17, 'Manguera de Alta Presión', 2, 4, 1, 1),
(18, 'Compresor de Aire', 3, 4, 0, 1),
(19, 'Soldadora', 5, 5, 0, 0),
(20, 'Cerrucho Manual', 1, 5, 7, 0),
(21, 'Taladro electrico', 5, 3, 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

CREATE TABLE `medicamento` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `id_area` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`codigo`, `nombre`, `stock`, `id_area`) VALUES
(1, 'Antibiótico de amplio espectro', 50, 1),
(2, 'Analgésico antiinflamatorio', 30, 2),
(3, 'Sedante para grandes mamíferos', 20, 3),
(4, 'Vacuna contra la rabia', 40, 5),
(5, 'Suero rehidratante', 60, 5),
(6, 'Desparasitante oral', 70, 6),
(7, 'Antifúngico tópico', 25, 7),
(8, 'Vitamina B12 inyectable', 45, 5),
(9, 'Antihistamínico para reacciones alérgicas', 35, 9),
(10, 'Oxitocina para inducción del parto', 15, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `id_personal` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `edad` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id_personal`, `nombre`, `apellido`, `edad`) VALUES
(1, 'Cristhian Gael', 'Rivera Torres', 22),
(2, 'Oliver', 'Sanchez Gomez', 26),
(3, 'Bruno Ivan', 'Santos Villarruel', 25),
(4, 'Vanessa', 'Saucedo Barrera', 22),
(5, 'Paulina', 'Vázquez Encina', 20);

--
-- Disparadores `personal`
--
DELIMITER $$
CREATE TRIGGER `validar_edad` BEFORE INSERT ON `personal` FOR EACH ROW BEGIN
  IF NEW.edad < 18 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Edad no válida. Debe ser mayor de 18.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudherramienta`
--

CREATE TABLE `solicitudherramienta` (
  `id_solicitud` int(11) NOT NULL,
  `id_personal` int(11) NOT NULL,
  `clave_herramienta` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudherramienta`
--

INSERT INTO `solicitudherramienta` (`id_solicitud`, `id_personal`, `clave_herramienta`, `fecha_solicitud`) VALUES
(1, 1, 17, '2025-01-29'),
(2, 4, 21, '2025-02-07'),
(3, 5, 11, '2025-02-13'),
(4, 3, 14, '2025-03-03'),
(5, 2, 15, '2025-03-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudmedicamento`
--

CREATE TABLE `solicitudmedicamento` (
  `id_solicitud` int(11) NOT NULL,
  `id_personal` int(11) NOT NULL,
  `codigo_medicamento` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudmedicamento`
--

INSERT INTO `solicitudmedicamento` (`id_solicitud`, `id_personal`, `codigo_medicamento`, `id_area`, `fecha_solicitud`) VALUES
(1, 1, 1, 2, '2025-01-21'),
(2, 2, 3, 10, '2025-02-01'),
(3, 3, 5, 3, '2025-02-14'),
(4, 4, 7, 1, '2025-02-21'),
(5, 5, 9, 5, '2025-03-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id_tecnico` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonatrabajo`
--

CREATE TABLE `zonatrabajo` (
  `id_zona` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `zonatrabajo`
--

INSERT INTO `zonatrabajo` (`id_zona`, `nombre`) VALUES
(1, 'Taller de mantenimiento'),
(2, 'Área de construcción'),
(3, 'Zona de veterinaria'),
(4, 'Almacén de herramientas'),
(5, 'Área de electricidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zoologico`
--

CREATE TABLE `zoologico` (
  `id_zoologico` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `zoologico`
--

INSERT INTO `zoologico` (`id_zoologico`, `nombre`, `direccion`) VALUES
(1, 'Zoológico de Chapultepec', 'Calz. Chivatito s/n, Miguel Hidalgo, CDMX, México'),
(2, 'Zoológico Guadalajara', 'Paseo del Zoológico 600, Guadalajara, Jalisco, México'),
(3, 'Bioparque Estrella', 'Carretera Ixtlahuaca - Jilotepec Km 38.5, Estado de México, México'),
(4, 'Africam Safari', 'Blvd. Capitán Carlos Camacho Espíritu Km 16.5, Puebla, México'),
(5, 'Zoológico de León', 'Blvd. Paseo de los Niños, León, Guanajuato, México');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areaveterinaria`
--
ALTER TABLE `areaveterinaria`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `estadoherramienta`
--
ALTER TABLE `estadoherramienta`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `herramienta`
--
ALTER TABLE `herramienta`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `id_zona` (`id_zona`),
  ADD KEY `fk_estado` (`id_estado`);

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `id_area` (`id_area`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id_personal`),
  ADD UNIQUE KEY `clave` (`apellido`);

--
-- Indices de la tabla `solicitudherramienta`
--
ALTER TABLE `solicitudherramienta`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_personal` (`id_personal`),
  ADD KEY `clave_herramienta` (`clave_herramienta`);

--
-- Indices de la tabla `solicitudmedicamento`
--
ALTER TABLE `solicitudmedicamento`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_personal` (`id_personal`),
  ADD KEY `codigo_medicamento` (`codigo_medicamento`),
  ADD KEY `id_area` (`id_area`);

--
-- Indices de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- Indices de la tabla `zonatrabajo`
--
ALTER TABLE `zonatrabajo`
  ADD PRIMARY KEY (`id_zona`);

--
-- Indices de la tabla `zoologico`
--
ALTER TABLE `zoologico`
  ADD PRIMARY KEY (`id_zoologico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areaveterinaria`
--
ALTER TABLE `areaveterinaria`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `estadoherramienta`
--
ALTER TABLE `estadoherramienta`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `herramienta`
--
ALTER TABLE `herramienta`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `id_personal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `solicitudherramienta`
--
ALTER TABLE `solicitudherramienta`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `solicitudmedicamento`
--
ALTER TABLE `solicitudmedicamento`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id_tecnico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zonatrabajo`
--
ALTER TABLE `zonatrabajo`
  MODIFY `id_zona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `zoologico`
--
ALTER TABLE `zoologico`
  MODIFY `id_zoologico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `herramienta`
--
ALTER TABLE `herramienta`
  ADD CONSTRAINT `fk_estado` FOREIGN KEY (`id_estado`) REFERENCES `estadoherramienta` (`id_estado`),
  ADD CONSTRAINT `herramienta_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estadoherramienta` (`id_estado`),
  ADD CONSTRAINT `herramienta_ibfk_2` FOREIGN KEY (`id_zona`) REFERENCES `zonatrabajo` (`id_zona`);

--
-- Filtros para la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD CONSTRAINT `fk_medicamentos_areas` FOREIGN KEY (`id_area`) REFERENCES `areaveterinaria` (`id_area`),
  ADD CONSTRAINT `medicamento_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `areaveterinaria` (`id_area`);

--
-- Filtros para la tabla `solicitudherramienta`
--
ALTER TABLE `solicitudherramienta`
  ADD CONSTRAINT `solicitudherramienta_ibfk_1` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id_personal`),
  ADD CONSTRAINT `solicitudherramienta_ibfk_2` FOREIGN KEY (`clave_herramienta`) REFERENCES `herramienta` (`clave`);

--
-- Filtros para la tabla `solicitudmedicamento`
--
ALTER TABLE `solicitudmedicamento`
  ADD CONSTRAINT `solicitudmedicamento_ibfk_1` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id_personal`),
  ADD CONSTRAINT `solicitudmedicamento_ibfk_2` FOREIGN KEY (`codigo_medicamento`) REFERENCES `medicamento` (`codigo`),
  ADD CONSTRAINT `solicitudmedicamento_ibfk_3` FOREIGN KEY (`id_area`) REFERENCES `areaveterinaria` (`id_area`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
