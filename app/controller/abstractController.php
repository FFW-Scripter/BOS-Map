<?php

namespace app\controller;


use Exception;
use ReflectionException;
use ReflectionMethod;
use Smarty;

/**
 * Class abstractController
 * @package app\controller
 */
abstract class abstractController
{
    /**
     * @var null
     */
    protected $action = null;

    /**
     * @var null
     */
    protected $smarty = null;

    /**
     * @var array
     */
    protected $css = array();

    /**
     * @var array
     */
    protected $js = array();

    /**
     * @var array
     */
    protected $title = array();

    /**
     * @var string
     */
    protected $template = null;

    /**
     * @var array
     */
    protected $output = array();

    /**
     * @var bool
     */
    protected $debug = true;

    /**
     * abstractController constructor.
     * @param null $action
     */
    public function __construct($action)
    {
        $this->action = $action;

        if (array_key_exists(1, $action) && method_exists($this, $action[1])) {
            try {
                $Reflection = new ReflectionMethod($this, $action[1]);
                if ($Reflection->isPublic()) {
                    $this->{$action[1]}($action);
                }
            } catch (ReflectionException $e) {
            }
        }
    }

    /**
     *
     */
    public function __destruct()
    {
        if (!is_null($this->template) && strlen($this->template)) {
            require_once dirname(__DIR__) . '/utils/smarty/libs/bootstrap.php';
            $smarty = new Smarty;
            $smarty->caching = false;
            $smarty->debugging = $this->debug;

            $smarty->setCacheDir(dirname(dirname(__DIR__)) . '/templates_c/');
            $smarty->setCompileDir(dirname(dirname(__DIR__)) . '/templates_c/');

            if ($this->debug) {
                $smarty->error_reporting = E_ALL | ~E_NOTICE;
            } else {
                $smarty->error_reporting = null;
            }

            $smarty->setTemplateDir(dirname(__DIR__) . '/view/');

            $smarty->assign('css', $this->css);
            $smarty->assign('js', $this->js);
            $smarty->assign($this->output);

            try {
                $smarty->display($this->template);
            } catch (Exception $e) {
                if ($this->debug) {
                    var_dump($e);
                }
            }
        } else {
            header('Content-Type: application/json;charset=utf-8');
            echo json_encode($this->json_array_types($this->output));
        }
    }


    /**
     * @param $return
     * @return array
     */
    public function json_array_types(array $return)
    {
        foreach ($return as $k => $v) {
            if (!is_array($v) && !is_object($v)) {
                if (gettype($v) == 'boolean' || gettype($v) == 'NULL') {
                    //nichts zu tun nur ausklammern das der typ nicht in int umgewandelt wird
                } elseif (preg_match('/^\d+$/', $v) && strlen(intval($v)) == strlen($v) && $v == intval($v)) {
                    $return[$k] = intval($v);
                } elseif (preg_match('~\d+(?:\.\d+)?~', $v) && strlen(floatval($v)) == strlen($v) && $v == floatval($v)) {
                    $return[$k] = floatval($v);
                } else { //String
                    $return[$k] = $this->setUTF8($v);
                }
            } else {
                $return[$k] = $this->json_array_types((array)$v);
            }
        }
        return $return;
    }


    /**
     * @param $string
     * @return string
     */
    public function setUTF8($string)
    {
        if (!mb_check_encoding($string, 'UTF-8')) {
            $string = utf8_encode($string);
        }
        return iconv('UTF-8', 'UTF-8//IGNORE', $string);
    }
}