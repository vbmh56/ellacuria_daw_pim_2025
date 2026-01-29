<?php
    header("Content-Type: application/json; charset=utf-8");
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Content-Type: application/json; charset=utf-8");
   
    // 1. Lee el JSON de entrada
    
    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) 
    {
        http_response_code(400);
        echo json_encode(["success" => false,
                          "message" => "JSON inválido o no proporcionado"]);
        exit;
    }
    
    if (json_last_error() !== JSON_ERROR_NONE) 
    {
        http_response_code(400);
        echo json_encode(["success" => false,
                          "message" => "JSON inválido: " . json_last_error_msg()]);
        exit;
    }

// 2. Valida parámetros obligatorios.
    $required = 
    [
        'P_ID_USUARIO',
        'P_DS_NOMBRE',
        'P_DS_APELLIDO1',
        'P_DS_LOGIN',
        'P_DS_CLAVE'
    ];

    foreach ($required as $param) 
    {
        if (!isset($input[$param]) || trim($input[$param]) === '') 
        {
            http_response_code(400);
            echo json_encode(["success" => false,"message" => "Falta o está vacío el parámetro: $param"]);
            exit;
        }
    }

    // 3. Obtiene todos los valores
    $idUsuario    = $input['P_ID_USUARIO'];
    $dsNombre     = $input['P_DS_NOMBRE'];
    $dsApellido1  = $input['P_DS_APELLIDO1'];
    $dsApellido2  = $input['P_DS_APELLIDO2'];
    $dsLogin      = $input['P_DS_LOGIN'];
    $dsClave      = $input['P_DS_CLAVE'];
    $dsIdAvatar   = $input['P_ID_AVATAR'];
    $dsEmail      = $input['P_DS_EMAIL'];
    $dsTelefono   = $input['P_DS_TELEFONO'];
    $dsInstagram  = $input['P_DS_INSTAGRAM'];
    $dsFacebook   = $input['P_DS_FACEBOOK'];
    $bHabilitado = $input['P_B_HABILITADO'];

    // Guarda el nombde del procedimiento almacenado que ejecuta esta API.
    $Procedimiento = "CALL UPDATE_USUARIO_BY_ID(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
    $stmt->bind_param("isssssissssi",$idUsuario, 
                                     $dsNombre,
                                     $dsApellido1,
                                     $dsApellido2, 
                                     $dsLogin,
                                     $dsClave,
                                     $dsIdAvatar,
                                     $dsEmail,
                                     $dsTelefono,
                                     $dsInstagram,
                                     $dsFacebook,
                                     $bHabilitado);

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