<?php 
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Content-Type: application/json; charset=utf-8");

    $Procedimiento =  "CALL SELECT_USER_BY_NAME_AND_PASSWORD(?, ?)";

    // Si la petición es OPTIONS, responde vacío y termina
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') 
    {
        http_response_code(200);
        exit;
    }

    //**************************************************************/
    //          Lee la informacion que se ha pasado
    $body = file_get_contents('php://input');

    $input = json_decode($body, true);

    // Verifica que el JSON es válido
    if (!is_array($input)) 
    {
        http_response_code(400); // Bad Request
        echo json_encode(['error' => 'JSON inválido o no recibido']);
        exit;
    }

    if (!isset($input['username']) || !isset($input['password'])) 
    {
        http_response_code(400);
        echo json_encode(['error' => 'No se han pasado los valores del nombre de usuario o de su clave']);
        exit;
    }

    $username = $input['username'];   //Guarda el valor pasado en el nombre de usuario
    $password = $input['password'];   //Guarda el valor pasado en la clave

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

    // Conecta con la base de datos
    $mysqli = new mysqli($host, $user, $pass, $dbname, $port);
    if ($mysqli->connect_errno) 
    {
        http_response_code(500);
        echo json_encode(['error' => 'Error de conexión: '.$mysqli->connect_error]);
        exit;
    }

    //Hace la llamada al procedimiento almacenado.
    if ($stmt = $mysqli->prepare($Procedimiento)) 
    {
        $stmt->bind_param('ss', $username, $password);
        $stmt->execute();

        // Obtiene el resultado
        $result = $stmt->get_result();
        if ($result && $result->num_rows > 0) 
        {
            $user = $result->fetch_assoc();

            // Código HTTP 200 OK
            http_response_code(200);

            // Respuesta JSON indicando éxito
            echo json_encode
            ([
                "resultado" => true,
                "mensaje"  => "success",
                "userid"  => $user
            ]);
        }
        else
        {
            // Si no hay resultados, también puedes responder con un JSON claro
            http_response_code(404);

            echo json_encode
            ([
                "resultado" => false,
                "status"  => "not_found",
                "mensaje" => "Usuario no encontrado"
            ]);
        }
        $stmt->close();
    } 
    else 
    {
        http_response_code(500);
        echo json_encode(['error' => 'Error al realizar la consulta']);
    }

    $mysqli->close();

?>