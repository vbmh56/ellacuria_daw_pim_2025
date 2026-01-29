Para poder ejecutar el código enviado son necesarios los siguientes elementos:

- Ordenador basado en windows 10 u 11.
- MySql Server 8.4.6.
- Cliente de MySql para poder ejecutar los scripts de creación y relleno de la base de datos (recomendable MySQL WorkBench).
- Un servidor Web que pueda ejecutar código PHP y que se pueda instalar en windows (preferiblemente el paquete XAAMP incluyendo PHP y APACHE).

El paquete que se entrega, incluye la base de datos, las API y la colección de pruebas REST hechas con BRUNO, de la aplicación FULL STACK de reserva de AULAS.

Estructura de carpetas del paquete:

-----------------------
../API
../Bruno Api Collection
../Config
../Screen Capture
../Scripts BBDD
Readme.md
-----------------------

- API: contiene todas las API en PHP.
- Bruno Api Collection: contiene la colección de pruebas solicitadas en este hito, en la que se puede ver el correcto funcionamiento de las API REST que gestionan las aulas. Incluye pantallazos.
- Config: contiene el fichero de configuración que cada una de las API leeran para saber cómo acceder a la base de datos y a la información contenida en ella.
- Screen Capture: contiene pantallazos de los pasos seguidos en el despliegue del software incluido en este paquete y de las pruebas de las api realizadas con BRUNO.
- Scripts BBDD: contiene los scripts de creación y rellenado de la base de datos.

En los pasos que se van a describir a continuación, se asume que ya se tienen instalados y configurados previamente MySQL y XAAMP, si no es así, acuda a la sección de ANEXOS al final de 
este documento, en donde se explica como hacer la instalación de estos productos.

-------------------------------------------------
1: Creación y rellenado de la base de datos MySQL
-------------------------------------------------

    - En un ordenador/servidor que tenga instalado MySQL Server 8.4.6. nos conectamos con un usuario que tenga permisos administrativos y utilizando un cliente que pueda ejecutar scripts.
    - Una vez conectado, en una nueva pestaña o apartado en el que se puedan ejecutar consultas, pegaremos y ejecutaremos todo el contenido del fichero "../Scripts BBDD/Schema.sql", esto debe
    crear una nueva base de datos llamada "bd_aulas" que contendrá tanto las tablas como los procedimientos almacenados necesarios para que funcione la aplicación correctamente.

    La estructura de tablas de la base de datos debe ser:

        bd_aulas
           |
           |----> dt_aulas
           |----> dt_datos_contacto
           |----> dt_reservas
           |----> dt_usuarios
           |----> re_usuarios_datos_contacto
           |----> tm_avatar

    La lista de procedimientos almacenados debe ser:

        DELETE_AULA_BY_ID
        DELETE_RESERVE_BY_ID
        DELETE_USUARIO_BY_ID
        INSERT_AULA
        INSERT_RESERVA
        INSERT_USUARIO
        SELECT_ALL_AULAS
        SELECT_ALL_AVATARS
        SELECT_ALL_RESERVES
        SELECT_ALL_USUARIOS
        SELECT_AULA_BY_ID
        SELECT_AVATAR_BY_ID
        SELECT_RESERVE_BY_ID
        SELECT_TODAY_RESERVES
        SELECT_USER_BY_NAME_AND_PASSWORD
        SELECT_USUARIO_BY_ID
        UPDATE_AULAS_BY_ID
        UPDATE_RESERVA_BY_ID
        UPDATE_USUARIO_BY_ID

    - Tras la correcta ejecución del script anterior, ahora en un nuevo apartado para realizar consultas copiaremos y ejecutaremos en contenido del otro script "../Scripts BBDD/Seed.sql". 
    Este script debe: 
    
        - Rellenar la tabla "tm_avatar".
        - crear 2 aulas nuevas en la "tabla dt_aulas".
        - crear un usuario "admin" con contraseña "1234" en la tabla "dt_usuarios".
        - crear los datos de contacto del usuario admin en la tabla "dt_datos_contacto".
        - rellenar la tabla que relaciona los usuarios con sus datos de contacto "re_usuarios_datos_contacto".


------------------------------
2: DESPLIEGUE DE TODAS LAS API
------------------------------

	- En un ordenador que tenga intalado XAAMP, crearemos dentro de la ruta  "..\xampp\htdocs\" una nueva carpeta, y dentro de esta misma copiaremos las carpetas "API" y "Config" de este
    paquete o entrega. Durante la elaboración de este documento, se ha utilizado la siguiente ruta:

        "C:\Xaamp\htdocs\PFG\"

    Al realizar el paso anterior, la estructura de carpetas debe quedar así:

        C:\Xaamp\htdocs\PFG\
                          |
                          |---> API
                          |---> Config


---------------------------
3: CONFIGIRACIÓN DE LAS API
---------------------------

Todas las API entregadas en el paquete tiene que poder acceder a la información contenida en la base de datos, para poder configurarlas todas ellas de una forma cómoda, se ha optado por la
creación de un fichero llamado "config.json" que se encuentra dentro de la carpeta Config que hemos copiado en el paso anterior. Toda la configuración necesaria para que la aplicación funcione
correctamente se encuentra en este fichero, pero en este punto nos centramos en la parte referente a la base de datos:

    "CONFIGURATION":
    {
        "DATABASE_SERVER_NAME": "Localhost",
        "DATABASE_SERVER_PORT": "1433",
        "DATABASE_NAME": "BD_AULAS",
        "DATABASE_USER": "Bruno",
        "DATABASE_PASSWORD": "Melon2025?",
        "APP_PAGES_URL":"http://INFOMusic/PFG/Pages/",
        "APP_MAIN_URL":"http://INFOMusic/PFG/pages/main.html",
        "APP_LOGIN_URL":"http://INFOMusic/PFG/pages/login.html",
        "API_BASE_URL":"http://INFOMusic/PFG/API/"
    }

    DATABASE_SERVER_NAME: debe ser el nombre del servidor que tiene instalado el motor de  la base de datos de MySQL y en el que hemos desplegado la base de datos del punto 1 de este documento.
    DATABASE_SERVER_PORT: debe ser el puerto TCP en donde escucha el motor de base de datos, en MySql por defecto es 3306.
    DATABASE_NAME: debe ser el nombre de la base de datos creada en el paso 1, si al ejecutar el primer script del paso 1 no se ha cambiado nada, el nombre de la base de datos es "bd_aulas".
    DATABASE_USER: es el nombre de algún usuario de MySQL que puede leer el contenido de la base de datos.
    DATABASE_PASSWORD: es la contraseña del usuario de MySQL que puede leer la base de datos.

    ********
    OPCIONAL
    ********

    API_BASE_URL: aunque en este momento aún no es necesario configurar este parámetro (lo utilizará mas adelante la aplicación web para encontrar la ruta de las API), si se desea se puede
    dejar ya configurado este parámetro. Indica la ruta BASE de donde vamos a publicar mediante HTTP todas las API entregadas en este paquete, durante la redacción de este documento copiamos
    todas las api en la ruta "c:\xaamp\htdocs   "\PFG\API\.....", esto significa que el servidor web apache la publicará a partir de la carpeta "PFG", respetando el nombre del servidor, en
    nuestro ejemplo:

        HTTP://INFOMUSIC/PFG/API/aqui_va_el_nombre_de_cada_api.php

    nota: admite utilizar "Localhost" en lugar del nombre real del servidor.

    Una vez hemos configurado este fichero, guardaremos los cambios y a partir de este momento ya estarán en funcionamiento todas las API.




--------------------------------------------------
ANEXO 1: INSTACIÓN Y CONFIGURACIÓN DE MYSQL SERVER
--------------------------------------------------

Para instalar MySql hay que descargarlo desde la siguiente URL: https://dev.mysql.com/downloads/mysql/8.0.html y después sigue el orden de las capturas de pantalla entregadas en este paquete en la ruta: "..\Screen Capture\MySQL\".

Para facilitar las operaciones de administración y gestión de las bases de datos, se recomienda descargar e instalar el cliente oficial de MySQL desde "https://dev.mysql.com/downloads/workbench/";


-------------------------------------------
ANEXO 2: INSTACIÓN Y CONFIGURACIÓN DE XAAMP
-------------------------------------------

Para instalar MySql hay que descargarlo desde la siguiente URL: https://www.apachefriends.org/es/download.html y después sigue el orden de las capturas de pantalla entregadas en este paquete en la ruta: "..\Screen Capture\XAAMP\".