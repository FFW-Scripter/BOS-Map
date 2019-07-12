<?php

namespace app\utils;

use PDO;

/**
 * Class DB
 */
class DB
{
    /**
     * @var DB
     */
    private static $Instance;

    /**
     * @var array
     */
    private $Connections = array();

    /**
     * @var string
     */
    private $lastConnection = null;

    /**
     * DB constructor.
     * @param Config $Config
     */
    public function __construct(Config $Config = null)
    {
        self::$Instance = $this;
        if ($Config instanceof Config) {
            $C = $Config->getConfig();
            foreach ($C as $conf) {
                $this->createConnection($conf);
            }
        }
    }

    /**
     * @return DB
     */
    public static function getInstance()
    {
        return self::$Instance;
    }

    /**
     * @param array $params
     * @return bool
     */
    private function createConnection(array $params)
    {
        $this->Connections[$params['db']] = new PDO(
            'mysql:host=' . $params['host'] . ';dbname=' . $params['db'] . ';charset=utf8mb4',
            $params['user'],
            $params['passwort'],
            array(
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            ));
        return $this->getConnection($params['db']) instanceof PDO;
    }

    /**
     * @param null $db
     * @return bool|PDO
     */
    public function getConnection($db = null)
    {
        if (is_null($db) && !is_null($this->lastConnection)) {
            $db = $this->lastConnection;
        } else {
            $this->lastConnection = $db;
        }

        if (!is_null($db)) {
            return $this->Connections[$db];
        }
        return false;
    }
}