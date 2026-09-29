<?php

final class Http
{
    public const OK = 200;                    // OK
    public const CREATED = 201;               // Resource ajouter
    public const NO_CONTENT = 204;            // Pas de contenu renvoyer
    public const BAD_REQUEST = 400;           // Erreur dans la requette
    public const UNAUTHORIZED = 401;          // Manque d'autentification
    public const FORBIDDEN = 403;             // Pas les droit requis
    public const NOT_FOUND = 404;             // Pas trouvé
    public const METHOD_NOT_ALLOWED = 405;   // Methode pas permise
    public const TROLL = 418;                 // Elle sert a rien
    public const INTERNAL_ERROR = 500;         // Error du programme

    /**
     * Crée la réponse pour les API.
     *
     * @param array $data Le tableau doit contenir le code d'erreur et la data.
     */
    public static function sendRequest(array $data): void
    {
        header('Content-Type: application/json');
        http_response_code($data['code']);
        echo json_encode($data['data']);
        exit;
    }

    /**
     * Lit le jeton dans l'entête de la requête HTTP.
     * Le jeton doit se trouver dans : 'Authorization' => 'Bearer <TOKEN>'
     *
     * @return string Le jeton trouvé. Une chaîne vide autrement.
     */
    public static function lireJetton(): string
    {
        $httpHeaders = getallheaders();
        $bearerString = $httpHeaders['Authorization'] ?? '';
        $bearer = explode(' ', $bearerString, 3);

        if ($bearer[0] !== 'Bearer' || count($bearer) != 2) {
            return '';
        }

        return $bearer[1];
    }

    public static function decodePost(): array
    {
        $body = file_get_contents('php://input');

        if ($body !== false && $body !== '') {
            $json = json_decode($body, true);
            return is_array($json) ? $json : [];
        }

        return [];
    }
}
