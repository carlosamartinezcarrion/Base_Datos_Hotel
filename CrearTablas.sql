CREATE DATABASE hotel;
   
USE hotel;


-- 1. TIPO_HABITACION
CREATE TABLE tipo_habitacion (
    id_tipo       INT           NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(20)   NOT NULL,
    descripcion   VARCHAR(200)  NOT NULL,
    capacidad     TINYINT       NOT NULL,
    tarifa_noche  DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (id_tipo),
    UNIQUE (nombre)
);


-- 2. HABITACION
CREATE TABLE habitacion (
    numero    SMALLINT     NOT NULL,
    piso      TINYINT      NOT NULL,
    estado    VARCHAR(15)  NOT NULL DEFAULT 'disponible',
    id_tipo   INT          NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (id_tipo) REFERENCES tipo_habitacion (id_tipo)
);


-- 3. HUESPED
CREATE TABLE huesped (
    cedula_pasaporte  VARCHAR(20)  NOT NULL,
    nombres           VARCHAR(60)  NOT NULL,
    apellidos         VARCHAR(60)  NOT NULL,
    nacionalidad      VARCHAR(40)  NOT NULL,
    correo            VARCHAR(100),
    PRIMARY KEY (cedula_pasaporte),
    UNIQUE (correo)
);


-- 4. TELEFONO_HUESPED (atributo multivaluado de HUESPED)
CREATE TABLE telefono_huesped (
    cedula_pasaporte  VARCHAR(20)  NOT NULL,
    telefono          VARCHAR(20)  NOT NULL,
    PRIMARY KEY (cedula_pasaporte, telefono),
    FOREIGN KEY (cedula_pasaporte)
        REFERENCES huesped (cedula_pasaporte)
);


-- 5. EMPLEADO (superclase) y sus subclases
CREATE TABLE empleado (
    codigo  VARCHAR(10)   NOT NULL,
    cedula  CHAR(10)      NOT NULL,
    nombre  VARCHAR(100)  NOT NULL,
    sueldo  DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE (cedula)
);


CREATE TABLE recepcionista (
    codigo  VARCHAR(10)  NOT NULL,
    turno   VARCHAR(10)  NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo) REFERENCES empleado (codigo)
);


CREATE TABLE personal_limpieza (
    codigo         VARCHAR(10)  NOT NULL,
    piso_asignado  TINYINT      NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo) REFERENCES empleado (codigo)
);


-- 6. RESERVA
CREATE TABLE reserva (
    id_reserva            INT          NOT NULL AUTO_INCREMENT,
    fecha_reserva         DATE         NOT NULL,
    fecha_entrada         DATE         NOT NULL,
    fecha_salida          DATE         NOT NULL,
    estado                VARCHAR(15)  NOT NULL DEFAULT 'pendiente',
    cedula_pasaporte      VARCHAR(20)  NOT NULL,
    codigo_recepcionista  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (id_reserva),
    FOREIGN KEY (cedula_pasaporte)
        REFERENCES huesped (cedula_pasaporte),
    FOREIGN KEY (codigo_recepcionista)
        REFERENCES recepcionista (codigo)
);


-- 7. RESERVA_HABITACION (relación M:N "incluye")
--    tarifa_noche = tarifa congelada al momento de reservar
CREATE TABLE reserva_habitacion (
    id_reserva         INT           NOT NULL,
    numero_habitacion  SMALLINT      NOT NULL,
    tarifa_noche       DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (id_reserva, numero_habitacion),
    FOREIGN KEY (id_reserva)
        REFERENCES reserva (id_reserva),
    FOREIGN KEY (numero_habitacion)
        REFERENCES habitacion (numero)
);


-- 8. SERVICIO (catálogo de servicios adicionales)
CREATE TABLE servicio (
    id_servicio  INT           NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(60)   NOT NULL,
    precio       DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (id_servicio),
    UNIQUE (nombre)
);


-- 9. CONSUMO (relación M:N "consume")
--    precio_unitario = precio vigente al momento del consumo
CREATE TABLE consumo (
    id_reserva       INT           NOT NULL,
    id_servicio      INT           NOT NULL,
    fecha_consumo    DATE          NOT NULL,
    cantidad         INT           NOT NULL DEFAULT 1,
    precio_unitario  DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (id_reserva, id_servicio, fecha_consumo),
    FOREIGN KEY (id_reserva)
        REFERENCES reserva (id_reserva),
    FOREIGN KEY (id_servicio)
        REFERENCES servicio (id_servicio)
);


-- 10. FACTURA (relación 1:1 con RESERVA; el total es derivado)
CREATE TABLE factura (
    id_factura  INT          NOT NULL AUTO_INCREMENT,
    fecha       DATE         NOT NULL,
    forma_pago  VARCHAR(15)  NOT NULL,
    id_reserva  INT          NOT NULL,
    PRIMARY KEY (id_factura),
    UNIQUE (id_reserva),
    FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva)
);


-- 11. ABONO (una reserva puede pagarse en varios abonos)
CREATE TABLE abono (
    id_abono    INT            NOT NULL AUTO_INCREMENT,
    fecha       DATE           NOT NULL,
    monto       DECIMAL(10,2)  NOT NULL,
    id_reserva  INT            NOT NULL,
    PRIMARY KEY (id_abono),
    FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva)
);


-- 12. MANTENIMIENTO (relación M:N entre HABITACION y PERSONAL_LIMPIEZA)
CREATE TABLE mantenimiento (
    numero_habitacion  SMALLINT      NOT NULL,
    codigo_limpieza    VARCHAR(10)   NOT NULL,
    fecha              DATE          NOT NULL,
    observacion        VARCHAR(200),
    PRIMARY KEY (numero_habitacion, codigo_limpieza, fecha),
    FOREIGN KEY (numero_habitacion) REFERENCES habitacion (numero),
    FOREIGN KEY (codigo_limpieza)   REFERENCES personal_limpieza (codigo)
);
