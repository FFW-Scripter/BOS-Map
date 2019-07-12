<?php

namespace app\utils;


use Exception;

/**
 * Class Autoloader
 * @package app\utils
 */
class Autoloader
{
    /**
     *
     */
    static function init()
    {
        spl_autoload_register(function ($class) {
            $file = realpath('./' . str_replace('\\', '/', $class) . '.php');
            if (file_exists($file)) {
                require_once $file;
            } else {
                new Exception('Klasse nicht gefunden: ' . $class . ' (' . $file . ')');
            }
        }, true);
    }
}