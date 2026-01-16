-- INSERT DE CARGA DE DATOS INCIAL GRUPO#5

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