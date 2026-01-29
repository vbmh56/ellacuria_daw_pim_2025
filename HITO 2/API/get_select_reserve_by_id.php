<?php
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Content-Type: application/json; charset=utf-8");

    // Guarda el nombde del procedimiento almacenado que ejecuta esta API.
    $Procedimiento = "CALL SELECT_RESERVE_BY_ID(?)";

    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') 
    {
        exit;
    }

    /********************************************************************************/
    // Verificación de valores pasados en GET y obtencion del ID pasado en el request
    if (!isset($_GET['id']) || !is_numeric($_GET['id'])) 
    {
        http_response_code(400);
        echo json_encode(['error' => 'Falta parámetro id o no es válido']);
        exit;
    }

    $id = intval($_GET['id']); //Obtiene el valor pasado para el ID.

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

    $resultado = false;
    $mensaje = "";

    /************************************************************/
    //           Conexion con la base de datos                  
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
    // Prepara la llamada al procedimiento almacenado.
    $stmt = $mysqli->prepare($Procedimiento);

    if (!$stmt) 
    {
        http_response_code(500);
        $resultado = false;
        $mensaje = 'Error preparando la consulta';
        $mysqli->close();

        echo json_encode(['resultado' => $resultado,
                          'mensaje' => $mensaje,
                          'data' => []]);
        exit;
    } 

    $stmt->bind_param('i', $id);

    if ($stmt->execute()) 
    {
        // Obtiene el resultado
        $result = $stmt->get_result();

                //Entra por aquí si ha podido ejecutar el procedimiento almacenado.
        if ($row = $result->fetch_assoc()) 
        {
            http_response_code(200);
            $response = 
            [
                "resultado" => true,
                "mensaje"   => "Consulta ejecutada correctamente",
                "data" =>['DS_AULA' => $row['DS_AULA'],  // Lee la columna DEL AULA.
                          'DS_NOMBRE' => $row['DS_NOMBRE'],           // Lee la columna DS_USUARIO.
                          'DS_APELLIDO1' => $row['DS_APELLIDO1'],   // Lee la columna DS_APELLIDO1.
                          'DS_APELLIDO2' => $row['DS_APELLIDO2'],  // Lee la columna DS_APELLIDO2
                          'ID_DT_RESERVA' => $row['ID_DT_RESERVA'],     // Lee la columna ID_DT_USUARIO.
                          'DS_RESERVA' => $row['DS_RESERVA'],  // Lee la columna CONSTRASEÑA
                          'FE_COMIENZO' => $row['FE_COMIENZO'],  // Lee la columna DS_EMAIL
                          'FE_FIN' => $row['FE_FIN']]  // Lee la columna DS_TELEFONO
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
        $resultado = false;
        $mensaje = 'Error al ejecutar el procedimiento almacenado.';
        $mysqli->close();

        echo json_encode(['resultado' => $resultado,
                          'mensaje' => $mensaje,
                          'data' => []]);
        exit;
    }

        /*Cierra la conexión a base de datos */
    $stmt->close();
    $mysqli->close();

    echo json_encode($response);

    /* Devuelve el resultado */
    return json_encode($response);
?>