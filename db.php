<?php
// db.php
// Funciones de acceso a la base de datos (MySQL) para la tabla rooms

function getDbConnection() {
    static $db = null;

    if ($db === null) {
        $host = 'localhost';
        $dbname = 'rooms_db';
        $user = 'root';
        $pass = ''; // Cambia esto según tu entorno

        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";

        try {
            $db = new PDO($dsn, $user, $pass);
            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Error de conexión a la base de datos']);
            exit;
        }
    }

    return $db;
}

/**
 * Devuelve todas las aulas (rooms) como array asociativo.
 */
function getAllRooms() {
    $db = getDbConnection();

    $stmt = $db->prepare('SELECT id, name, capacity FROM rooms');
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

/**
 * Devuelve una aula por su id o null si no existe.
 */
function getRoomById($id) {
    $db = getDbConnection();

    $stmt = $db->prepare('SELECT id, name, capacity FROM rooms WHERE id = ?');
    $stmt->execute([$id]);

    return $stmt->fetch(PDO::FETCH_ASSOC);
}

/**
 * Crea una nueva aula y devuelve el id generado.
 */
function createRoom($name, $capacity) {
    $db = getDbConnection();

    $stmt = $db->prepare('INSERT INTO rooms (name, capacity) VALUES (?, ?)');
    $stmt->execute([$name, $capacity]);

    return $db->lastInsertId();
}
