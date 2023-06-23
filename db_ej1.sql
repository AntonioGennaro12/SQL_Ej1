/* Crear una Base de Datos CINE */
CREATE DATABASE cine; /* Crea la base de Cine */

SHOW DATABASES;

USE cine; /*  inicio sesión con base de datos Cine */

SHOW TABLES;

/* Creo la tabla segun los datos mínimos requeridos */
CREATE TABLE peliculas(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    estreno YEAR NOT NULL,
    recaudacion INT NOT NULL,
    director VARCHAR(40) NOT NULL,
    streaming BOOLEAN, 
    PRIMARY KEY (id)
);

SHOW TABLES;

/* Describe la estructura de la tabla de datos */
DESCRIBE peliculas;

/*Muestra TODO(*) el contenido de la tabla indicada*/
SELECT * FROM peliculas;
/* indica "Empty set" */

/* Inserta varios registros en la tabla creada */
INSERT INTO peliculas (nombre, estreno, recaudacion, director, streaming) VALUES ("Avatar", 2009, 2847, "James Cameron", 1 );
SELECT * FROM tabla_datos;
/* muestra registro nro 1 OK */
INSERT INTO peliculas (nombre, estreno, recaudacion, director, streaming) VALUES ("Vengadores: Endgame", 2019, 2797, "Anthony Russo, Joe Russo", 1);
INSERT INTO peliculas (nombre, estreno, recaudacion, director, streaming) VALUES ("Titanic", 1997, 2242, "James Cameron"; FALSE);
SELECT * FROM peliculas;
/* muestra registros nro 1 a 3 OK */ 
/* Ahora agrego una columna más relativa a si tine o no Streaming */
ALTER TABLE peliculas ADD COLUMN tiene_stream BOOLEAN AFTER director;
SELECT * FROM peliculas;
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre              | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar              |    2009 |        2847 | James Cameron            |         NULL |         1 |
|  2 | Vengadores: Endgame |    2019 |        2797 | Anthony Russo, Joe Russo |         NULL |         1 |
|  3 | Titanic             |    1997 |        2242 | James Cameron            |         NULL |         0 |
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
/* Ahora debemos corregir los valores de la nueva columna en función del contenido de la columna streaming */
UPDATE peliculas
SET tiene_stream = CASE
    WHEN streaming = TRUE THEN TRUE
    WHEN streaming = FALSE THEN FALSE 
    END;
SELECT * FROM peliculas;
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre              | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar              |    2009 |        2847 | James Cameron            |            1 |         1 |
|  2 | Vengadores: Endgame |    2019 |        2797 | Anthony Russo, Joe Russo |            1 |         1 |
|  3 | Titanic             |    1997 |        2242 | James Cameron            |            0 |         0 |
+----+---------------------+---------+-------------+--------------------------+--------------+-----------+
/* Agrego dos nuevas películas dónde una no tiene plataforma de streaming */
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream, streaming) VALUES ("Star Wars: El Despertar de la Fuerza", 2015, 2068, "J.J. Abrams", TRUE, TRUE);
SELECT * FROM peliculas;
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream, streaming) VALUES ("Spider-Man: No Way Home", 2021, 1916, "Jon Watts", FALSE, NULL );
SELECT * FROM peliculas;
/* muestra los 5 registros correctamente ! */
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 |         1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 |         1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 |         0 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 |         1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 |      NULL |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
/* Sin embargo voy a modificar en la columna "streaming" que diga NULL en caso no tenga streaming */ 
UPDATE peliculas
SET streaming = CASE
    WHEN streaming = TRUE THEN TRUE
    WHEN streaming = FALSE THEN NULL 
    END;
SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 |         1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 |         1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 |      NULL |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 |         1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 |      NULL |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+

/* En la parte 3 del Ej 1 se pide que se indique con "No Tiene" cuando en realida no tiene una plataforma de streaming */
/* voy a cambiar el tipo de dato de Streaming que está en BOOLEAN a VARCHAR con capacidad de hasta 255 caracteres      */    
ALTER TABLE peliculas
MODIFY COLUMN streaming VARCHAR(255);
/* Ahora modifico los que estan en NULL a "no tiene" */
UPDATE peliculas
SET streaming = CASE
    WHEN streaming = TRUE THEN TRUE
    WHEN streaming IS NULL THEN "no tiene" 
    END;
SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1         |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1         |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene  |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1         |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene  |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+

/* pero tendría que modificar la tabla para hacer que se cargue autompaticamante */
/* Se gun chatGpt tendrái que crea un "TRIGGER" para que cada vez que se cargue ese campo realice otras acciones */ 

CREATE TRIGGER actualizar_streaming
AFTER INSERT OR UPDATE ON peliculas
FOR EACH ROW
BEGIN
    IF NEW.tiene_stream = TRUE THEN
        SET NEW.streaming = 'url_streaming';
    ELSE
        SET NEW.streaming = 'no tiene';
    END IF;
END;

/* esto da un error ......
   
    ->     IF NEW.tiene_stream = TRUE THEN
    ->         SET NEW.streaming = 'url_streaming';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OR UPDATE ON peliculas
FOR EACH ROW
BEGIN
    IF NEW.tiene_stream = TRUE THEN
  ' at line 2
mysql>     ELSE
    ->         SET NEW.streaming = 'no tiene';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'ELSE
        SET NEW.streaming = 'no tiene'' at line 1
mysql>     END IF;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'END IF' at line 1
mysql> END;  */

/* Consulto nuevamente ingresanod el error y me sugiere el siguiente comando con un cambio de delimitador a // */ 
DELIMITER //
CREATE TRIGGER actualizar_streaming BEFORE INSERT ON peliculas
FOR EACH ROW
BEGIN
    IF NEW.tiene_stream = TRUE THEN
        SET NEW.streaming = 'url_streaming';
    ELSE
        SET NEW.streaming = 'no tiene';
    END IF;
END //
DELIMITER ;

/* Funcionó pero tube que cambiar nuevamente para volver el delimitador a ";" */

DELIMITER ;
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1         |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1         |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene  |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1         |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene  |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+-----------+
/* Ahora agrego dos nuevas películas dónde una no tiene plataforma de streaming */
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream, streaming) VALUES ("Jurasic World", 2015, 1672, "Colin Trevorrow", TRUE, "Url stream-6");
SELECT * FROM peliculas;
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream) VALUES ("El Rey León", 2019, 1663, "Jon Favreau", FALSE);
SELECT * FROM peliculas;
/* muestra los 7 registros correctamente ! */

mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+
7 rows in set (0.00 sec)
/* Agregamos ahora una nueva columna "Valio la Pena" si recaudó más de un determinado valor */
ALTER TABLE peliculas
ADD valio_la_pena BOOLEAN DEFAULT FALSE;
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             0 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             0 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             0 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             0 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             0 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
/* Actualizo ahora la nueva columna con el valor si recaudó más de 1700 M de USD */ 
UPDATE peliculas
SET valio_la_pena = CASE
    WHEN recaudacion >= 1700 THEN TRUE
    WHEN recaudacion < 1700 THEN FALSE 
    END;

mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             1 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             1 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
/* Ahora agrego 2 nuevas películas, una con streaming y la otra por debajo del umbral de recaudación */

INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream, streaming) VALUES ("Furious 7", 2015, 1515, "James Wan", TRUE, "Url stream-9");
SELECT * FROM peliculas;
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             1 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             1 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
|  9 | Furious 7                            |    2015 |        1515 | James Wan                |            1 | Url stream-9 |             0 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream) VALUES ("Top Gun Maverik", 2022, 1701, "Joseph Kosinski", FALSE);
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             1 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             1 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
|  9 | Furious 7                            |    2015 |        1515 | James Wan                |            1 | Url stream-9 |             0 |
| 10 | Top Gun Maverik                      |    2022 |        1701 | Joseph Kosinski          |            0 | no tiene     |             0 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
/* muestra los 9 registros correctamente, excepto que en columna valió l pena no aparece en TRUE xq no se implemento con Trigger */
/* genero un TRIGGER */
DELIMITER //
CREATE TRIGGER actualizar_valio_la_pena BEFORE INSERT ON peliculas
FOR EACH ROW
BEGIN
    IF NEW.recaudacion >= 1700 THEN
        SET NEW.valio_la_pena = TRUE;
    ELSE
        SET NEW.valio_la_pena = FALSE;
    END IF;
END //
DELIMITER ;
/* Elimino e ingreso nuevamente la pelicula Nro 10 */
DELETE FROM peliculas
WHERE id = 10; 
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             1 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             1 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
|  9 | Furious 7                            |    2015 |        1515 | James Wan                |            1 | Url stream-9 |             0 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
/* ingreso nuevamente ahora queda con ID nro 11 */ 
INSERT INTO peliculas (nombre, estreno, recaudacion, director, tiene_stream) VALUES ("Top Gun Maverik", 2022, 1701, "Joseph Kosinski", FALSE);
mysql> SELECT * FROM peliculas;
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
| id | nombre                               | estreno | recaudacion | director                 | tiene_stream | streaming    | valio_la_pena |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
|  1 | Avatar                               |    2009 |        2847 | James Cameron            |            1 | 1            |             1 |
|  2 | Vengadores: Endgame                  |    2019 |        2797 | Anthony Russo, Joe Russo |            1 | 1            |             1 |
|  3 | Titanic                              |    1997 |        2242 | James Cameron            |            0 | no tiene     |             1 |
|  4 | Star Wars: El Despertar de la Fuerza |    2015 |        2068 | J.J. Abrams              |            1 | 1            |             1 |
|  5 | Spider-Man: No Way Home              |    2021 |        1916 | Jon Watts                |            0 | no tiene     |             1 |
|  7 | Jurasic World                        |    2015 |        1672 | Colin Trevorrow          |            1 | url-stream-7 |             0 |
|  8 | El Rey León                          |    2019 |        1663 | Jon Favreau              |            0 | no tiene     |             0 |
|  9 | Furious 7                            |    2015 |        1515 | James Wan                |            1 | Url stream-9 |             0 |
| 11 | Top Gun Maverik                      |    2022 |        1701 | Joseph Kosinski          |            0 | no tiene     |             1 |
+----+--------------------------------------+---------+-------------+--------------------------+--------------+--------------+---------------+
/* Ahí quedó perfecto! */
/*FIN*/