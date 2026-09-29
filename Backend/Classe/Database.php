<?php
require_once __DIR__ . '/../dbConfig.php';

class Database {
    private static ?PDO $instance = null;

    public static function getConnection(): PDO {
        if (self::$instance === null) {
            $host = DB_HOST;
            $dbname = DB_NAME;
            $username = DB_USER;
            $password = DB_PASS;
            $charset = DB_CHARSET;

            try {
                self::$instance = new PDO("mysql:host=$host;dbname=$dbname;charset=$charset", $username, $password, [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
                ]);
            } catch (PDOException $e) {
                die("Erreur de connexion : " . $e->getMessage());
            }
        }
        return self::$instance;
    }
}
