<?php

use app\utils\Autoloader;
use app\utils\Config;
use app\utils\DB;

ob_start('ob_gzhandler');

chdir('../');

require_once 'app/utils/Autoloader.php';
Autoloader::init();

$DB_Config = new Config('config/DB.json');
$DB = new DB($DB_Config);

if (!array_key_exists('controller', $_GET) || !strlen($_GET['controller'])) {
    $_GET['controller'] = 'Map';
}

$controller = explode('/', trim($_GET['controller'], '/'));
$NS = 'app\\controller\\' . $controller[0];
if (class_exists($NS)) {
    $action = new $NS($controller);
} else {
    echo 'Controller: "' . $controller[0] . '" nicht gefunden!';
}