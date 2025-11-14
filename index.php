<?php
// index.php
// API sencilla para gestionar aulas (rooms) con MySQL

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/db.php';

$method = $_SERVER['REQUEST_METHOD'];
$uri    = $_SERVER['REQUEST_URI'];

// Quitamos parámetros de la URL si los hubiera (por ejemplo ?page=2)
$path = parse_url($uri, PHP_URL_PATH);

// Rutas previstas:
// GET  /api/rooms        -> lista de aulas
// POST /api/rooms        -> crear aula nueva
// GET  /api/rooms/3      -> obtener aula con id 3

// 1. Listar aulas: GET /api/rooms
if ($path === '/api/rooms' && $method === 'GET') {
    $rooms = getAllRooms();
    echo json_encode($rooms);
    exit;
}

// 2. Crear aula: POST /api/rooms
if ($path === '/api/rooms' && $method === 'POST') {
    // Leemos el cuerpo de la petición (JSON)
    $rawBody = file_get_contents('php://input');
    $data = json_decode($rawBody, true);

    // Validación sencilla
    $name = $data['name'] ?? null;
    $capacity = $data['capacity'] ?? null;

    if (!$name) {
        http_response_code(400);
        echo json_encode(['error' => 'El campo name es obligatorio']);
        exit;
    }

    // Si capacity llega vacío, lo ponemos a null
    if ($capacity === '') {
        $capacity = null;
    }

    $newId = createRoom($name, $capacity);

    http_response_code(201);
    echo json_encode([
        'id'       => (int)$newId,
        'name'     => $name,
        'capacity' => $capacity
    ]);
    exit;
}

// 3. Obtener aula concreta: GET /api/rooms/{id}
if (preg_match('#^/api/rooms/(\d+)$#', $path, $matches) && $method === 'GET') {
    $id = (int) $matches[1];

    $room = getRoomById($id);

    if (!$room) {
        http_response_code(404);
        echo json_encode(['error' => 'Aula no encontrada']);
        exit;
    }

    echo json_encode($room);
    exit;
}

// Si llega aquí, la ruta o el método no coinciden con nada definido
http_response_code(404);
echo json_encode(['error' => 'Ruta no encontrada']);
