<?php


namespace app\controller;


use app\utils\Config;

class Map extends abstractController
{
    protected $template = 'Map.tpl';

    /**
     * Map constructor.
     * @param $action
     */
    public function __construct($action)
    {
        parent::__construct($action);
        $Map_Config = new Config('config/Mapbox.json');
        $this->output['Config'] = $Map_Config->getConfig();
    }
}