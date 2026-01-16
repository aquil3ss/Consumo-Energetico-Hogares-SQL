-- Script de creación de base de datos normalizada - MySQL
-- Proyecto: Análisis de Consumo de Energía en Hogares Inteligentes

CREATE DATABASE PROYECTO_5;
USE PROYECTO_5;

-- TABLAS SECUNDARIAS 

-- Tipos de Vivienda
CREATE TABLE Tipos_Vivienda (
    id_tipo_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Sector_Zona
CREATE TABLE Sector_Zona(
	id_sector_zona INT AUTO_INCREMENT PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Tarifas
CREATE TABLE Tarifas (
    id_tarifa INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Tipos de Energía
CREATE TABLE Tipos_Energia (
    id_energia INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Tipos de Dispositivo
CREATE TABLE Tipos_Dispositivo (
    id_tipo_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Marcas
CREATE TABLE Marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre_marca VARCHAR(50) NOT NULL UNIQUE
);

-- Estados de Alerta
CREATE TABLE Estados_Alerta (
    id_estado_alerta INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- Tipo de Alerta 
CREATE TABLE Tipo_Alerta (
    id_tipo_alerta INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- TABLAS PRINCIPALES

-- Propietarios
CREATE TABLE Propietarios (
    id_propietario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

-- Hogares
CREATE TABLE Hogares (
    id_hogares INT AUTO_INCREMENT PRIMARY KEY,
    id_sector_zona INT NOT NULL, 
    id_propietario INT NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    integrantes INT CHECK (integrantes >= 0),
    id_tipo_vivienda INT NOT NULL,
    num_habitaciones INT CHECK (num_habitaciones > 0),
    area_m2 DECIMAL(6,2) CHECK (area_m2 > 0),
    id_tarifa INT NOT NULL,
    id_energia INT NOT NULL,
    FOREIGN KEY (id_propietario) REFERENCES Propietarios(id_propietario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_vivienda) REFERENCES Tipos_Vivienda(id_tipo_vivienda) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_tarifa) REFERENCES Tarifas(id_tarifa) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_energia) REFERENCES Tipos_Energia(id_energia) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_sector_zona) REFERENCES Sector_Zona(id_sector_zona) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Dispositivos
CREATE TABLE Dispositivos (
    id_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
    id_hogares INT NOT NULL,
    nombre_dispositivo VARCHAR(100) NOT NULL,
    id_tipo_dispositivo INT NOT NULL,
    id_marca INT NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_hogares) REFERENCES Hogares(id_hogares) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_dispositivo) REFERENCES Tipos_Dispositivo(id_tipo_dispositivo) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_marca) REFERENCES Marcas(id_marca) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Consumo Energía
CREATE TABLE Consumo_Energia (
    id_consumo INT AUTO_INCREMENT PRIMARY KEY,
    id_dispositivo INT NOT NULL,
    consumo_kwh DECIMAL(8,2) CHECK (consumo_kwh >= 0),
    fecha_inicio_consumo DATETIME NOT NULL,
    fecha_fin_consumo DATETIME NOT NULL,
    FOREIGN KEY (id_dispositivo) REFERENCES Dispositivos(id_dispositivo) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (fecha_fin_consumo >= fecha_inicio_consumo)
);

-- Alertas
CREATE TABLE Alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_consumo INT NOT NULL,
    id_tipo_alerta INT NOT NULL,       
    id_estado_alerta INT NOT NULL,
    fecha_alerta DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (id_consumo) REFERENCES Consumo_Energia(id_consumo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_alerta) REFERENCES Tipo_Alerta(id_tipo_alerta) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_estado_alerta) REFERENCES Estados_Alerta(id_estado_alerta) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- INSERT DE PRUEBA

INSERT INTO Tipos_Vivienda (descripcion) VALUES ('Casa'), ('Departamento');
INSERT INTO Sector_Zona(descripcion) VALUES ('Sur'), ('Norte'), ('Centro');
INSERT INTO Tarifas (descripcion) VALUES ('Residencial'), ('Comercial');
INSERT INTO Tipos_Energia (descripcion) VALUES ('Eléctrica'), ('Mixta'), ('Solar');
INSERT INTO Tipos_Dispositivo (descripcion) VALUES ('Electrodoméstico'), ('Entretenimiento'), ('Climatización'), ('Electrónica');
INSERT INTO Marcas (nombre_marca) VALUES ('LG'), ('Samsung'), ('Mabe'), ('Daikin'), ('HP'), ('Indurama'), ('Amazon'), ('Whirlpool'), ('Hikvision'), ('Tekno'), ('Sylvania'), ('Bambú'), ('Sony'), ('Opalux'), ('Epson');
INSERT INTO Estados_Alerta (descripcion) VALUES ('Pendiente'), ('Atendida'); 
INSERT INTO Tipo_Alerta (descripcion) VALUES ('Consumo alto'), ('Consumo moderado'); 

-- Propietarios
INSERT INTO Propietarios (nombre, contacto, email) VALUES 
('Juan Pérez','0991234567','juan.perez@gmail.com'),
('María Gómez','0987654321','maria.gomez@gmail.com'),
('Carlos Ramírez','0998765432','carlos.ramirez@gmail.com'),
('Vicente Paredes','0990966222','vicente.paredes@gmail.com'),
('Ignacio Guaman','0910883803','ignacio.guaman@gmail.com'),
('Natalia Calderon','0903750080','natalia.calderon@gmail.com'),
('Francisco Delgado','0922475975','francisco.delgado@gmail.com'),
('Melanie Galvez','0913618532','melanie.galvez@gmail.com'),
('Laura Intriago','0988757962','laura.intriago@gmail.com'),
('Julio Peña','0970880095','julio.peña@gmail.com');

-- Hogares
INSERT INTO Hogares (id_sector_zona,id_propietario, direccion, integrantes, id_tipo_vivienda, num_habitaciones, area_m2, id_tarifa, id_energia) VALUES
(1,1,'Av. 25 de Julio y Callejón 10, Guayaquil',4,1,5,120.5,1,1),
(2,2,'Calle Ficus y Av. Víctor Emilio Estrada, Guayaquil',3,2,3,80.75,1,2),
(3,3,'Av. 9 de Octubre y Malecón Simón Bolívar, Guayaquil',5,1,6,150,2,3),
(2,4,'Av. Juan Tanca Marengo y Rodrigo Chávez, Guayaquil',3,2,3,100,1,1),
(2,5,'Av. Isidro Ayora y Av. de las Américas, Guayaquil',5,2,6,188,1,2),
(3,6,'Av. 9 de Octubre y Chimborazo, Guayaquil',1,1,6,173,2,1),
(1,7,'Coop. Unión de bananeros Mz10. S.1, Guayaquil',2,1,4,135,1,1),
(2,8,'Cdla. Lomas de urdesa Mz. 7  V.9, Guayaquil',1,2,2,133,1,3),
(1,9,'Calle Portete y la 17 ava., Guayaquil',4,1,3,177,1,1),
(1,10,'Av. Quito y 1ero de mayo, Guayaquil',5,2,4,130,2,1);


-- Dispositivos
INSERT INTO Dispositivos (id_hogares, nombre_dispositivo, id_tipo_dispositivo, id_marca, modelo) VALUES
(1,'Refrigerador',1,1,'GR-123'),
(1,'Televisor',2,2,'QLED55'),
(2,'Lavadora',1,3,'Aqua20'),
(3,'Aire Acond.',3,4,'DX-200'),
(3,'Computadora',4,5,'ProDesk'),
(4,'Cocina',1,6,'CA-5599'),
(4,'Alexa echo pop',4,7,'c2h4r9'),
(5,'Secadora',1,8,'CE-8921'),
(6,'Camara de seguridad',4,9,'Hik-991'),
(7,'Microondas',1,6,'RA-T182'),
(7,'Duchas',4,10,'MY0912'),
(8,'Sensores de humo',4,11,'DC 9V'),
(8,'Difusor de aroma',4,12,'FG-1025'),
(9,'Consola de juegos',2,13,'PS4 Pro'),
(10,'Luces de emergencia',4,14,'FT9101'),
(10,'Proyector',4,15,'AKR07');

-- Consumo Energía
INSERT INTO Consumo_Energia (id_dispositivo, consumo_kwh, fecha_inicio_consumo, fecha_fin_consumo) VALUES
(1,150.75,'2025-09-01 20:07:01','2025-10-02 00:45:17'),
(2,220.4,'2025-09-01 20:07:01','2025-10-02 00:45:17'),
(3,95.6,'2025-10-31 21:47:57','2025-11-30 22:40:13'),
(4,180,'2025-11-30 18:27:02','2025-12-30 09:25:22'),
(5,210.5,'2025-11-30 18:27:02','2025-12-30 09:25:22'),
(6,200,'2025-11-29 17:12:45','2025-12-29 20:05:29'),
(7,80,'2025-06-29 17:12:45','2025-07-29 20:05:25'),
(8,180,'2025-03-30 08:51:55','2025-04-28 23:23:24'),
(9,136,'2025-04-29 05:44:27','2025-05-29 02:40:25'),
(10,133,'2025-05-29 04:13:48','2025-06-28 01:05:33'),
(11,224,'2025-05-29 04:13:48','2025-06-28 01:05:33'),
(12,92,'2025-07-28 11:38:16','2025-08-27 17:32:05'),
(13,161,'2025-07-28 11:38:16','2025-08-27 17:32:05'),
(14,82,'2025-09-26 12:05:35','2025-10-26 08:07:19'),
(15,173,'2025-10-26 20:39:56','2025-11-26 03:36:37'),
(16,247,'2025-10-26 20:39:56','2025-11-26 03:36:37');


-- Alertas
INSERT INTO Alertas (id_consumo, fecha_alerta, id_tipo_alerta, id_estado_alerta) VALUES
(1,'2025-09-09 20:48:19',2,1),
(2,'2025-09-09 09:37:25',1,2),
(3,'2025-11-03 05:32:11',2,1),
(4,'2025-12-02 23:20:22',1,1),
(5,'2025-12-23 02:12:53',1,2),
(6,'2026-02-13 10:29:06',1,1),
(7,'2026-02-07 17:18:21',2,2),
(8,'2026-04-24 03:28:22',1,1),
(9,'2026-05-06 06:33:42',2,2),
(10,'2026-06-05 03:39:17',2,2),
(11,'2026-06-07 18:52:41',1,1),
(12,'2026-08-24 10:15:01',2,1),
(13,'2026-08-05 01:33:12',1,1),
(14,'2026-10-21 05:27:17',2,2),
(15,'2026-11-07 07:23:06',1,2),
(16,'2026-10-27 05:50:23',1,1);

-- ¿Que dispositivos tienen mayor consumo energético?
EXPLAIN 
SELECT 
    d.nombre_dispositivo, 
    d.modelo, 
    m.nombre_marca, 
    ce.consumo_kwh
FROM consumo_energia AS ce
INNER JOIN dispositivos AS d
    ON ce.id_dispositivo = d.id_dispositivo
INNER JOIN marcas AS m
    ON d.id_marca = m.id_marca
ORDER BY ce.consumo_kwh DESC
LIMIT 3;


-- ¿Que hogares tienen patrones de consumo más eficiente?
EXPLAIN 
SELECT 
    sz.descripcion AS Sector_Zona, 
    h.direccion, 
    h.integrantes, 
    SUM(ce.consumo_kwh) AS consumo_total
FROM consumo_energia AS ce
INNER JOIN dispositivos AS d
    ON ce.id_dispositivo = d.id_dispositivo
INNER JOIN hogares AS h
    ON d.id_hogares = h.id_hogares
INNER JOIN sector_zona AS sz
    ON h.id_sector_zona = sz.id_sector_zona
GROUP BY h.id_hogares, sz.descripcion, h.direccion, h.integrantes
ORDER BY consumo_total ASC
LIMIT 3;


-- ¿Que dias y horas tienen mayor consumo energetico?
EXPLAIN 
SELECT 
    DATE(ce.fecha_inicio_consumo) AS dia,
    TIME(ce.fecha_inicio_consumo) AS hora,
    h.direccion AS hogar,
    sz.descripcion AS sector_zona,
    d.nombre_dispositivo,
    m.nombre_marca,
    SUM(ce.consumo_kwh) AS consumo_total,
    (SELECT ROUND(AVG(consumo_kwh), 2) FROM consumo_energia) AS promedio_general,
    SUM(ce.consumo_kwh) - (SELECT ROUND(AVG(consumo_kwh), 2) FROM consumo_energia) AS diferencia,
    ROUND(AVG(DATEDIFF(ce.fecha_fin_consumo, ce.fecha_inicio_consumo)), 0) AS dias_consumo
FROM consumo_energia AS ce
INNER JOIN dispositivos AS d
    ON ce.id_dispositivo = d.id_dispositivo
INNER JOIN marcas AS m
    ON d.id_marca = m.id_marca
INNER JOIN hogares AS h
    ON d.id_hogares = h.id_hogares
INNER JOIN sector_zona AS sz
    ON h.id_sector_zona = sz.id_sector_zona
GROUP BY dia, hora, hogar, sector_zona, d.nombre_dispositivo, m.nombre_marca
ORDER BY consumo_total DESC
LIMIT 3;


-- CREACIÓN DE ÍNDICES
-- CONSULTA 1: Dispositivos con mayor consumo energético
CREATE INDEX idx_consumo_dispositivo ON consumo_energia(id_dispositivo);
CREATE INDEX idx_dispositivo_marca ON dispositivos(id_marca);
CREATE INDEX idx_consumo_kwh ON consumo_energia(consumo_kwh);

-- CONSULTA 2: Hogares con consumo más eficiente
CREATE INDEX idx_dispositivo_hogar ON dispositivos(id_hogares);
CREATE INDEX idx_hogar_sector ON hogares(id_sector_zona);

-- CONSULTA 3: Días y horas con mayor consumo
CREATE INDEX idx_fecha_inicio_consumo ON consumo_energia(fecha_inicio_consumo);
CREATE INDEX idx_fecha_fin_consumo ON consumo_energia(fecha_fin_consumo);

