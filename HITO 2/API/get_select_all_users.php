<?php
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Content-Type: application/json; charset=utf-8");

    $Procedimiento = "CALL SELECT_ALL_USUARIOS()";

    //*************************************************************/
    //              Lee el fichero de configuración

    // Busca y abre el fichero.
    $jsonString = file_get_contents('../Config/Config.json');
    if ($jsonString === false) 
    {
        die('No se puede leer el fichero de configuracion');
    }

    // Lee el fichero.
    $configuracion = json_decode($jsonString, true);
    if ($configuracion === null) 
    {
        die('Error al decodificar JSON: '. json_last_error_msg());
    }

    //Obtiene los valores de conexion a la base de datos a partir del fichero.
    $host = $configuracion['CONFIGURATION']['DATABASE_SERVER_NAME'];    // IP o nombre donde está la instancia de MySQL.
    $port = $configuracion['CONFIGURATION']['DATABASE_SERVER_PORT'];    // Puerto de la instancia de MySql.
    $dbname = $configuracion['CONFIGURATION']['DATABASE_NAME'];         // Nombre de la base de datos del proyecto.
    $user = $configuracion['CONFIGURATION']['DATABASE_USER'];           // Nombre de un usuario que pueda ver los objetos y datos de la base de datos.
    $pass = $configuracion['CONFIGURATION']['DATABASE_PASSWORD'];       // Contraseña del usuario que puede acceder al servidor de bases de datos.

    //Variables de control para la respuesta
    $resultado = false;
    $mensaje = "";

    // Conecta con la base de datos
    $mysqli = new mysqli($host, $user, $pass, $dbname, $port);

    if ($mysqli->connect_errno) 
    {
        http_response_code(500);
        $resultado = false;
        $mensaje = 'Error de conexión: '.$mysqli->connect_error;

        echo json_encode([
            'resultado' => $resultado,
            'mensaje' => $mensaje,
            'data' => []]);
        exit;
    }

    // Ejecutar el procedimiento almacenado sin parámetros
    if (!$mysqli->multi_query($Procedimiento)) 
    {
        http_response_code(500);
        $resultado = false;
        $mensaje = 'Error en la ejecución CALL: '.$mysqli->error;
        $mysqli->close();

        echo json_encode(['resultado' => $resultado,
                          'mensaje' => $mensaje,
                          'data' => []]);
        exit;
    }

    $data = [];

    // Recuperar todos los conjuntos de resultados (normalmente solo uno)
    do {
            if ($result = $mysqli->store_result()) 
            {
                while ($row = $result->fetch_assoc()) 
                {
                    $data[] = $row;
                }
                $result->free();

                // Resultado correcto
                $resultado = true;
                $mensaje = "Consulta ejecutada correctamente";
            }
        } 
    
    while ($mysqli->next_result());

    // Cerrar conexión
    $mysqli->close();

    // Devolver JSON
    echo json_encode(['resultado' => $resultado,
                      'mensaje' => $mensaje,
                      'data' => $data]);
?>