<?php
spl_autoload_register(function($classe){
    $path = str_replace('\\', DIRECTORY_SEPARATOR, $classe);
    require 'Classes/' . $path . '.php';
    
}); 