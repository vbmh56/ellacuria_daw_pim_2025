<?php
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Content-Type: application/json; charset=utf-8");

    
    
    // 1. Leer el JSON de entrada
    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) 
    {
        http_response_code(400);
        echo json_encode(["success" => false,
                          "message" => "JSON inválido o no proporcionado"]);
        exit;
    }

    // 2. Valida los parámetros pasados en el json.
    $required = ['P_ID_DT_AULA', 'P_ID_DT_USUARIO', 'P_DESDE', 'P_HASTA'];

    foreach ($required as $param) 
    {
        if (!isset($input[$param])) 
        {
            http_response_code(400);
            echo json_encode(["success" => false,
                              "message" => "Falta parámetro: $param"]);
            exit;
        }
    }

    $idAula = $input['P_ID_DT_AULA'];
    $idUsuario = $input['P_ID_DT_USUARIO'];
    $dsReserva = $input['P_DS_RESERVA'];
    $fedesde = $input['P_DESDE'];
    $fehasta= $input['P_HASTA'];

    // Guarda el nombde del procedimiento almacenado que ejecuta esta API.
    $Procedimiento = "CALL INSERT_RESERVA(?, ?, ?, ?, ?)";

    //*************************************************************/
    //              Lee el fichero de configuracion

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


    /************************************************************/
    //           Conexion con la base de datos                  
    $mysqli = new mysqli($host, $user, $pass, $dbname, $port);
    if ($mysqli->connect_errno) 
    {
        http_response_code(500);
        echo json_encode(['error' => 'Error de conexión: '.$mysqli->connect_error]);
        exit;
    }

    // Prepara la llamada al procedimiento almacenado.
    $stmt = $mysqli->prepare($Procedimiento);

    if (!$stmt) 
    {
        http_response_code(500);
        echo json_encode(['error' => 'Error preparando la consulta']);
        $mysqli->close();
        exit;
    } 

    // hace el bind de los parámetros
    $stmt->bind_param("iisss",$idAula, $idUsuario, $dsReserva, $fedesde, $fehasta);

    if ($stmt->execute()) 
    {
        $result = $stmt->get_result();     // Obteniene el resultado del SELECT.
        
        //Entra por aquí si ha podido ejecutar el procedimiento almacenado.
        if ($row = $result->fetch_assoc()) 
        {
            http_response_code(200);
            $response = 
            [
                'resultado' => (bool)$row['resultado'],     // Lee la columna resultado (solo puede ser true o false).
                'mensaje' => $row['mensaje']                // Lee la columna mensaje, con la descripción de lo ocurrido.
            ];
        }

        $result->free();
        while ($stmt->next_result()) 
        {
            $stmt->free_result();
        }
    } 
    else 
    {
        // Entra por aqui si no ha podido ejecutar el procedimiento almacenado.
        http_response_code(500);
        $response = 
        [
            'resultado' => false,
            'mensaje' => 'Error en la ejecución'
        ];
    }

    /*Cierra la conexión a base de datos */
    $stmt->close();
    $mysqli->close();

    echo json_encode($response);

    /* Devuelve el resultado */
    return json_encode($response);
?>