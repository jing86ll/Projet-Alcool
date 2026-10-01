# Projet-Alcool

https://trello.com/b/ySYtzdnq/projet-perso 

pour que le projet fonctionne il faut crée un fichier dbConfig.php avec cet form

define("DB_HOST", "");
define("DB_NAME", "");
define("DB_CHARSET", "");
define("DB_USER", "");
define("DB_PASS", "");


Diagramme de classe
classDiagram
direction TB
    class User {
	    -id
	    -name
	    -weight_kg
	    -gender
	    -token
	    +createAccount()
	    +getAll()
	    +login(name, pass)
	    +logout(name, pass)
    }
a
    class Drink {
	    -id
	    -session_id
	    -user_id
	    -volume_ml
	    -degree
	    -consumed_at
	    +getAllDrink()
	    +getDrinkByToken()
	    +getDrinkBySession()
	    +delete()
	    +update()
    }
a
    class Session {
	    -id
	    -title
	    -started_at
	    -is_active
	    +getAllSession()
	    +getSessionById()
	    +getAllParticipant()
	    +creatSession()
	    +closeSession()
    }
a
    class UserController {
	    +handleRequest()
    }
a
    class DrinkController {
	    +handleRequest()
    }
a
    class SessionController {
	    +handleRequest()
    }
a
    class index_php {
	    +index.php
    }
a
    User <|-- UserController : hérite / gère
    Drink <|-- DrinkController : hérite / gère
    Session <|-- SessionController : hérite / gère
    UserController --> index_php
    DrinkController --> index_php
    SessionController --> index_php
