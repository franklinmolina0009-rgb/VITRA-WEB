<?php
// Configuración local para XAMPP + MySQL Workbench.
$host = 'localhost';
$port = '3307'; // Puerto de tu servidor MySQL
$db   = 'vitra_db';
$user = 'root';
$pass = '123456789'; // Contraseña configurada

try {
    $pdo = new PDO(
        "mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4",
        $user,
        $pass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
} catch (PDOException $e) {
    http_response_code(500);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => false, 'mensaje' => 'No se pudo conectar con la base de datos: ' . $e->getMessage()]);
    exit;
}