<?php


namespace app\utils;


/**
 * Class Config
 * @package app\utils
 */
class Config
{
    /**
     * @var array|null
     */
    private $Config = null;

    /**
     * Config constructor.
     * @param $ConfigFile
     */
    public function __construct($ConfigFile)
    {
        if (is_file($ConfigFile)) {
            $this->Config = json_decode(file_get_contents($ConfigFile), 1);
        }
    }

    /**
     * @return array|null
     */
    public function getConfig()
    {
        return $this->Config;
    }
}