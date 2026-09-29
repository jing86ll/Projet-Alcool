<?php

require_once "./autoload.php";

$db = Database::getConnection();

Http::sendRequest([
    'code' => Http::OK,
    'data' => ['success' => true]
]);

$token = Http::lireJetton();
$data = Http::decodePost();