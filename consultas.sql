-- =====================================================================
-- 03_queries.sql  |  Base de datos hotel (MySQL 8.0)
-- Consultas de álgebra relacional traducidas a SQL
-- Ejecutar después de 01_schema.sql y 02_data.sql
-- =====================================================================
USE hotel;

-- ---------------------------------------------------------------------
-- Consulta 1 — Selección (σ), Proyección (π) y Reunión natural (⋈)
-- Huéspedes extranjeros con reservas no canceladas que incluyen una
-- habitación tipo Suite (tarifa congelada al reservar). Reúne 5 tablas.
-- Resultado esperado: 4 filas
-- ---------------------------------------------------------------------
SELECT h.nombres,
       h.apellidos,
       h.nacionalidad,
       r.id_reserva,
       hb.numero      AS habitacion,
       t.nombre       AS tipo,
       r.fecha_entrada,
       r.fecha_salida,
       rh.tarifa_noche
FROM huesped h
JOIN reserva            r  ON r.cedula_pasaporte = h.cedula_pasaporte
JOIN reserva_habitacion rh ON rh.id_reserva      = r.id_reserva
JOIN habitacion         hb ON hb.numero          = rh.numero_habitacion
JOIN tipo_habitacion    t  ON t.id_tipo          = hb.id_tipo
WHERE h.nacionalidad != 'Ecuatoriana'
  AND r.estado != 'cancelada'
  AND t.nombre = 'Suite';

-- ---------------------------------------------------------------------
-- Consulta 2 — Diferencia (−)
-- Huéspedes que nunca han consumido un servicio adicional.
-- Resultado esperado: 1 fila (Sofía Elizabeth Ordóñez Ruiz)
-- ---------------------------------------------------------------------
SELECT h.cedula_pasaporte, h.nombres, h.apellidos, h.correo
FROM huesped h
WHERE NOT EXISTS (SELECT 1
                  FROM reserva r
                  JOIN consumo c ON c.id_reserva = r.id_reserva
                  WHERE r.cedula_pasaporte = h.cedula_pasaporte);

-- ---------------------------------------------------------------------
-- Consulta 3 — Producto cartesiano (×), Diferencia (−) y Proyección (π)
-- División relacional: huéspedes que han consumido TODOS los servicios
-- del catálogo (doble NOT EXISTS).
-- Resultado esperado: 1 fila (John Michael Smith)
-- ---------------------------------------------------------------------
SELECT h.cedula_pasaporte, h.nombres, h.apellidos
FROM huesped h
WHERE NOT EXISTS (SELECT 1
                  FROM servicio s
                  WHERE NOT EXISTS (SELECT 1
                                    FROM reserva r
                                    JOIN consumo c ON c.id_reserva = r.id_reserva
                                    WHERE r.cedula_pasaporte = h.cedula_pasaporte
                                      AND c.id_servicio      = s.id_servicio));

-- ---------------------------------------------------------------------
-- Consulta 4 — Unión (∪)
-- Personal de refuerzo: recepcionistas del turno de noche más personal
-- de limpieza asignado a los pisos 2 y 3.
-- Resultado esperado: 4 filas (E003, E008, E009, E010)
-- ---------------------------------------------------------------------
SELECT e.codigo, e.nombre, 'Recepcionista' AS rol, CONCAT('Turno ', rc.turno) AS detalle
FROM empleado e
JOIN recepcionista rc ON rc.codigo = e.codigo
WHERE rc.turno = 'Noche'
UNION
SELECT e.codigo, e.nombre, 'Personal de limpieza', CONCAT('Piso ', pl.piso_asignado)
FROM empleado e
JOIN personal_limpieza pl ON pl.codigo = e.codigo
WHERE pl.piso_asignado >= 2;

-- ---------------------------------------------------------------------
-- Consulta 5 — Selección (σ), Proyección (π) y Reunión natural (⋈)
-- Consumos cuyo precio pactado difiere del precio actual del catálogo.
-- Reúne 4 tablas.
-- Resultado esperado: 7 filas (Ana Lucía Torres, Marco Antonio Vélez,
-- John Michael Smith)
-- ---------------------------------------------------------------------
SELECT h.nombres,
       h.apellidos,
       r.id_reserva,
       s.nombre          AS servicio,
       c.fecha_consumo,
       c.precio_unitario AS precio_pactado,
       s.precio          AS precio_actual
FROM servicio s
JOIN consumo c ON c.id_servicio      = s.id_servicio
JOIN reserva r ON r.id_reserva       = c.id_reserva
JOIN huesped h ON h.cedula_pasaporte = r.cedula_pasaporte
WHERE c.precio_unitario != s.precio;
