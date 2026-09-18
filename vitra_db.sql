-- =========================================================
-- VITRA / ZENITH - Base de datos MySQL
-- Ejecutar TODO este archivo en MySQL Workbench.
-- =========================================================

CREATE DATABASE IF NOT EXISTS vitra_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE vitra_db;

CREATE TABLE IF NOT EXISTS tipos_proyecto (
    id_tipo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS solicitudes_demo (
    id_solicitud BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    correo VARCHAR(150) NULL,
    fecha_preferida DATE NOT NULL,
    hora_preferida TIME NOT NULL,
    id_tipo INT UNSIGNED NOT NULL,
    necesidad TEXT NULL,
    estado ENUM('Pendiente','Contactado','Aprobado','Rechazado','Completado') NOT NULL DEFAULT 'Pendiente',
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_solicitud_tipo FOREIGN KEY (id_tipo)
      REFERENCES tipos_proyecto(id_tipo)
      ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_solicitudes_estado (estado),
    INDEX idx_solicitudes_fecha (fecha_preferida),
    INDEX idx_solicitudes_correo (correo)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuarios_admin (
    id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('Administrador','Operador') NOT NULL DEFAULT 'Operador',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO tipos_proyecto (codigo, nombre, descripcion)
VALUES
 ('lentes', 'ZENITH S - proximidad y alertas', 'Propuesta orientada a proximidad y alertas.'),
 ('prototipo', 'ZENITH D - asistencia de color', 'Propuesta orientada a asistencia de color.'),
 ('software', 'Software e integración', 'Integración de software y servicios tecnológicos.'),
 ('alianza', 'Alianza estratégica', 'Colaboración o alianza con el proyecto VITRA.')
ON DUPLICATE KEY UPDATE
 nombre = VALUES(nombre), descripcion = VALUES(descripcion), activo = TRUE;

-- Comprobación rápida
SELECT * FROM tipos_proyecto;
SELECT * FROM solicitudes_demo ORDER BY id_solicitud DESC;
