<?php
header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['ok' => false, 'mensaje' => 'Método no permitido.']);
    exit;
}

require __DIR__ . '/conexion.php';

$nombre    = trim($_POST['customerName'] ?? '');
$telefono  = trim($_POST['customerPhoneNo'] ?? '');
$correo    = trim($_POST['customerEmail'] ?? '');
$fecha     = trim($_POST['bookingDate'] ?? '');
$hora      = trim($_POST['bookingTime'] ?? '');
$tipo      = trim($_POST['projectType'] ?? '');
$necesidad = trim($_POST['specialRequest'] ?? '');

if ($nombre === '' || $telefono === '' || $fecha === '' || $hora === '' || $tipo === '') {
    http_response_code(422);
    echo json_encode(['ok' => false, 'mensaje' => 'Completa todos los campos obligatorios.']);
    exit;
}

if ($correo !== '' && !filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    echo json_encode(['ok' => false, 'mensaje' => 'El correo electrónico no es válido.']);
    exit;
}

try {
    $buscarTipo = $pdo->prepare('SELECT id_tipo FROM tipos_proyecto WHERE codigo = ? AND activo = 1 LIMIT 1');
    $buscarTipo->execute([$tipo]);
    $tipoProyecto = $buscarTipo->fetch();

    if (!$tipoProyecto) {
        http_response_code(422);
        echo json_encode(['ok' => false, 'mensaje' => 'El tipo de proyecto no es válido.']);
        exit;
    }

    $sql = 'INSERT INTO solicitudes_demo
            (nombre, telefono, correo, fecha_preferida, hora_preferida, id_tipo, necesidad)
            VALUES (?, ?, ?, ?, ?, ?, ?)';
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        $nombre,
        $telefono,
        $correo !== '' ? $correo : null,
        $fecha,
        $hora,
        $tipoProyecto['id_tipo'],
        $necesidad !== '' ? $necesidad : null
    ]);

    echo json_encode([
        'ok' => true,
        'mensaje' => 'Solicitud guardada correctamente.',
        'id_solicitud' => $pdo->lastInsertId()
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'mensaje' => 'No se pudo guardar la solicitud.']);
}
