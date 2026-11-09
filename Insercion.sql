USE hotel;
 
-- 1. TIPO_HABITACION
INSERT INTO tipo_habitacion (id_tipo, nombre, descripcion, capacidad, tarifa_noche) VALUES
    (1, 'Simple',   'Habitación con una cama de plaza y media, baño privado y TV',            1,  35.00),
    (2, 'Doble',    'Habitación con cama matrimonial o dos camas, baño privado y escritorio',  2,  55.00),
    (3, 'Suite',    'Suite con sala, cama king, jacuzzi y vista a la ciudad',                  2, 110.00),
    (4, 'Familiar', 'Habitación amplia con una cama matrimonial y dos camas individuales',     4,  80.00);
 
-- 2. HABITACION
INSERT INTO habitacion (numero, piso, estado, id_tipo) VALUES
    (101, 1, 'disponible',    1),
    (102, 1, 'disponible',    1),
    (103, 1, 'disponible',    2),
    (201, 2, 'ocupada',       2),
    (202, 2, 'mantenimiento', 2),
    (203, 2, 'disponible',    4),
    (204, 2, 'disponible',    4),
    (205, 2, 'disponible',    1),
    (301, 3, 'ocupada',       3),
    (302, 3, 'disponible',    3);
 
-- 3. HUESPED
INSERT INTO huesped (cedula_pasaporte, nombres, apellidos, nacionalidad, correo) VALUES
    ('1104567821', 'Ana Lucía',        'Torres Jaramillo', 'Ecuatoriana',     'ana.torres@correo.ec'),
    ('1103456789', 'Marco Antonio',    'Vélez Cueva',      'Ecuatoriana',     'marco.velez@correo.ec'),
    ('1105678934', 'Sofía Elizabeth',  'Ordóñez Ruiz',     'Ecuatoriana',     'sofia.ordonez@correo.ec'),
    ('1102345678', 'Diego Armando',    'Pineda Lara',      'Ecuatoriana',     'diego.pineda@correo.ec'),
    ('US4587123',  'John Michael',     'Smith',            'Estadounidense',  'john.smith@mail.com'),
    ('CO7712345',  'María Fernanda',   'Gómez Restrepo',   'Colombiana',      'mafe.gomez@mail.com'),
    ('DE55013947', 'Lukas',            'Meyer',            'Alemana',         'lukas.meyer@mail.de'),
    ('IT9087341',  'Valentina',        'Rossi',            'Italiana',        'valentina.rossi@mail.it');
 
-- 4. TELEFONO_HUESPED (atributo multivaluado)
INSERT INTO telefono_huesped (cedula_pasaporte, telefono) VALUES
    ('1104567821', '0991234567'),
    ('1104567821', '072570123'),
    ('1103456789', '0987654321'),
    ('1105678934', '0998765432'),
    ('1102345678', '0963217854'),
    ('1102345678', '072611456'),
    ('US4587123',  '+1 305 555 0142'),
    ('CO7712345',  '+57 310 555 0187'),
    ('CO7712345',  '+57 601 555 0123'),
    ('DE55013947', '+49 151 5550 1234'),
    ('IT9087341',  '+39 333 555 0166'),
    ('IT9087341',  '+39 06 5550 1877');
 
-- 5. EMPLEADO (superclase)
INSERT INTO empleado (codigo, cedula, nombre, sueldo) VALUES
    ('E001', '1102345671', 'Patricia Alexandra Cueva Armijos',  520.00),
    ('E002', '1103456782', 'Jorge Luis Armijos Salinas',        500.00),
    ('E003', '1104567893', 'Daniela Estefanía Moreno Castillo', 500.00),
    ('E004', '1105678904', 'Andrés Felipe Jiménez Pardo',       500.00),
    ('E005', '1106789015', 'Karla Michelle Sarango Ochoa',      480.00),
    ('E006', '1107890126', 'Rosa Elena Granda Paladines',       460.00),
    ('E007', '1108901237', 'Luis Fernando Macas Quizhpe',       460.00),
    ('E008', '1109012348', 'Gladys Maribel Zhingre Jaramillo',  460.00),
    ('E009', '1100123459', 'Segundo Manuel Condoy Puglla',      470.00),
    ('E010', '1101234560', 'Martha Isabel Yaguana Ríos',        460.00);
 
-- 5.1 RECEPCIONISTA
INSERT INTO recepcionista (codigo, turno) VALUES
    ('E001', 'Mañana'),
    ('E002', 'Tarde'),
    ('E003', 'Noche'),
    ('E004', 'Mañana'),
    ('E005', 'Tarde');
 
-- 5.2 PERSONAL_LIMPIEZA
INSERT INTO personal_limpieza (codigo, piso_asignado) VALUES
    ('E006', 1),
    ('E007', 1),
    ('E008', 2),
    ('E009', 2),
    ('E010', 3);
 
-- 6. SERVICIO
INSERT INTO servicio (id_servicio, nombre, precio) VALUES
    (1, 'Desayuno',               6.50),
    (2, 'Lavandería',             8.00),
    (3, 'Spa',                   35.00),
    (4, 'Transporte al aeropuerto', 15.00),
    (5, 'Cena',                  12.00),
    (6, 'Tour por la ciudad de Loja', 25.00);
 
-- 7. RESERVA (1-7 finalizadas, 8-10 confirmadas, 11 pendiente, 12 cancelada)
INSERT INTO reserva (id_reserva, fecha_reserva, fecha_entrada, fecha_salida, estado, cedula_pasaporte, codigo_recepcionista) VALUES
    ( 1, '2026-08-28', '2026-09-05', '2026-09-08', 'finalizada', '1104567821', 'E001'),
    ( 2, '2026-09-01', '2026-09-10', '2026-09-12', 'finalizada', '1103456789', 'E002'),
    ( 3, '2026-09-15', '2026-09-20', '2026-09-25', 'finalizada', 'US4587123',  'E001'),
    ( 4, '2026-09-25', '2026-10-01', '2026-10-05', 'finalizada', 'DE55013947', 'E003'),
    ( 5, '2026-10-02', '2026-10-08', '2026-10-10', 'finalizada', '1105678934', 'E002'),
    ( 6, '2026-10-10', '2026-10-15', '2026-10-18', 'finalizada', 'CO7712345',  'E004'),
    ( 7, '2026-10-20', '2026-10-24', '2026-10-27', 'finalizada', 'IT9087341',  'E003'),
    ( 8, '2026-10-25', '2026-11-05', '2026-11-10', 'confirmada', '1102345678', 'E004'),
    ( 9, '2026-10-30', '2026-11-06', '2026-11-12', 'confirmada', 'US4587123',  'E005'),
    (10, '2026-11-01', '2026-11-20', '2026-11-23', 'confirmada', '1104567821', 'E001'),
    (11, '2026-11-05', '2026-12-05', '2026-12-08', 'pendiente',  '1103456789', 'E002'),
    (12, '2026-10-28', '2026-11-15', '2026-11-17', 'cancelada',  '1105678934', 'E004');
 
-- 8. RESERVA_HABITACION (tarifa congelada al momento de reservar)
INSERT INTO reserva_habitacion (id_reserva, numero_habitacion, tarifa_noche) VALUES
    ( 1, 103,  50.00),
    ( 2, 301, 100.00),
    ( 3, 201,  50.00),
    ( 3, 202,  50.00),
    ( 4, 302, 100.00),
    ( 5, 101,  30.00),
    ( 6, 203,  75.00),
    ( 6, 204,  75.00),
    ( 7, 301, 110.00),
    ( 7, 302, 110.00),
    ( 8, 201,  55.00),
    ( 9, 301, 110.00),
    (10, 203,  80.00),
    (10, 204,  80.00),
    (11, 102,  35.00),
    (12, 205,  35.00);
 
-- 9. CONSUMO (precio vigente al momento del consumo)
INSERT INTO consumo (id_reserva, id_servicio, fecha_consumo, cantidad, precio_unitario) VALUES
    (1, 1, '2026-09-06', 2,  6.00),
    (1, 1, '2026-09-07', 2,  6.00),
    (1, 2, '2026-09-07', 1,  7.50),
    (2, 5, '2026-09-11', 2, 11.00),
    (2, 4, '2026-09-12', 1, 15.00),
    (3, 1, '2026-09-21', 4,  6.00),
    (3, 2, '2026-09-22', 2,  7.50),
    (3, 3, '2026-09-23', 2, 32.00),
    (3, 4, '2026-09-25', 1, 15.00),
    (4, 1, '2026-10-02', 2,  6.50),
    (4, 3, '2026-10-03', 1, 35.00),
    (4, 4, '2026-10-05', 1, 15.00),
    (6, 1, '2026-10-16', 4,  6.50),
    (6, 6, '2026-10-17', 4, 25.00),
    (7, 1, '2026-10-25', 2,  6.50),
    (7, 5, '2026-10-25', 2, 12.00),
    (7, 3, '2026-10-26', 2, 35.00),
    (7, 2, '2026-10-26', 1,  8.00),
    (8, 1, '2026-11-06', 1,  6.50),
    (8, 1, '2026-11-07', 1,  6.50),
    (9, 5, '2026-11-07', 2, 12.00),
    (9, 6, '2026-11-08', 2, 25.00);
 
-- 10. FACTURA (solo reservas finalizadas)
INSERT INTO factura (id_factura, fecha, forma_pago, id_reserva) VALUES
    (1, '2026-09-08', 'efectivo',      1),
    (2, '2026-09-12', 'tarjeta',       2),
    (3, '2026-09-25', 'tarjeta',       3),
    (4, '2026-10-05', 'transferencia', 4),
    (5, '2026-10-10', 'efectivo',      5),
    (6, '2026-10-18', 'tarjeta',       6),
    (7, '2026-10-27', 'transferencia', 7);
 
-- 11. ABONO (varios abonos por reserva)
INSERT INTO abono (id_abono, fecha, monto, id_reserva) VALUES
    ( 1, '2026-08-28',  60.00, 1),
    ( 2, '2026-09-08', 121.50, 1),
    ( 3, '2026-09-01', 100.00, 2),
    ( 4, '2026-09-12', 137.00, 2),
    ( 5, '2026-09-15', 200.00, 3),
    ( 6, '2026-09-22', 200.00, 3),
    ( 7, '2026-09-25', 218.00, 3),
    ( 8, '2026-09-25', 150.00, 4),
    ( 9, '2026-10-05', 313.00, 4),
    (10, '2026-10-10',  60.00, 5),
    (11, '2026-10-10', 200.00, 6),
    (12, '2026-10-18', 376.00, 6),
    (13, '2026-10-20', 300.00, 7),
    (14, '2026-10-27', 475.00, 7),
    (15, '2026-11-05',  50.00, 8),
    (16, '2026-10-30', 220.00, 9),
    (17, '2026-11-01', 100.00, 10);
 
-- 12. MANTENIMIENTO (limpieza y reparaciones)
INSERT INTO mantenimiento (numero_habitacion, codigo_limpieza, fecha, observacion) VALUES
    (103, 'E007', '2026-09-08', 'Limpieza posterior al check-out'),
    (201, 'E008', '2026-09-25', 'Limpieza posterior al check-out'),
    (302, 'E010', '2026-10-05', 'Limpieza posterior al check-out'),
    (101, 'E006', '2026-10-10', 'Limpieza profunda posterior a la salida del huésped'),
    (203, 'E008', '2026-10-18', 'Limpieza posterior al check-out'),
    (204, 'E009', '2026-10-18', 'Cambio de bombillos y limpieza'),
    (301, 'E010', '2026-10-27', 'Limpieza y reposición de amenidades'),
    (202, 'E009', '2026-10-28', 'Reparación de fuga en lavamanos'),
    (202, 'E009', '2026-11-02', 'Cambio de grifería; pendiente de revisión final'),
    (102, 'E007', '2026-11-04', 'Mantenimiento preventivo del aire acondicionado');
