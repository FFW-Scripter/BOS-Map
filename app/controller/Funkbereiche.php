<?php

namespace app\controller;


use app\utils\DB;

/**
 * Class Funkbereiche
 * @package app\controller
 */
class Funkbereiche extends abstractController
{

    /**
     * @param $action
     */
    public function create($action)
    {
        if (array_key_exists('feature', $_POST) && array_key_exists(0, $_POST['feature']) && is_array($_POST['feature'][0])) {
            $feature = $_POST['feature'][0];

            foreach ($feature['geometry']['coordinates'][0] as $i => $v) {
                $feature['geometry']['coordinates'][0][$i][0] = floatval($v[0]);
                $feature['geometry']['coordinates'][0][$i][1] = floatval($v[1]);
            }

            $DB = DB::getInstance()->getConnection();
            $sql = 'INSERT INTO Points (ID, geometry)
        VALUES(
               ' . $DB->quote($feature['id']) . ',
            ST_GeomFromGeoJSON(' . $DB->quote(json_encode($feature['geometry'])) . ')
        );';
            $DB->exec($sql);
            $err = $DB->errorCode();

            $insert = array(
                'Name' => $DB->quote($_POST['Name']),
                'Crypto' => $DB->quote($_POST['Crypto']),
                'Baud' => $DB->quote($_POST['Baud']),
                'Frequenz' => $DB->quote(intval($_POST['Frequenz'])),
                'Organisation' => $DB->quote($_POST['Organisation']),
                'P_ID' => $DB->quote($feature['id']),
            );
            $DB->exec('Insert into Funkbereiche (' . implode(', ', array_keys($insert)) . ') values (' . implode(', ', $insert) . ')');

            $this->output['success'] = $err == 0 && $DB->errorCode() == 0;
            if ($this->output['success']) {
                $ID = $DB->query('Select ID from Funkbereiche where P_ID=' . $DB->quote($feature['id']))->fetch();
                $this->output['ID'] = $ID['ID'];
                $this->output['data'] = $this->get($this->output['ID']);
            }
        }
    }

    /**
     * @param $action
     */
    public function update($action)
    {
        $this->output['success'] = true;
    }

    /**
     * @param $action
     */
    public function delete($action)
    {
        $this->output['success'] = true;
    }

    /**
     * @param $action
     */
    public function getAll($action)
    {
        $DB = DB::getInstance()->getConnection();
        $Q = $DB->query('Select F.*, ST_AsGeoJSON(P.geometry) as geometry from Funkbereiche as F, Points as P where F.P_ID=P.ID');
        if ($Q->rowCount()) {
            $this->output['data'] = $Q->fetchAll();
            foreach ($this->output['data'] as $k => $v) {
                if (strlen($v['geometry'])) {
                    $this->output['data'][$k]['geometry'] = json_decode($v['geometry']);
                }
            }
        }

        $this->output['success'] = $DB->errorCode() == 0;
    }

    /**
     * @param $lastInsertId
     * @return mixed|null
     */
    private function get($lastInsertId)
    {
        $DB = DB::getInstance()->getConnection();
        $Q = $DB->query('Select F.*, ST_AsGeoJSON(P.geometry) as geometry from Funkbereiche as F, Points as P where F.ID=' . $DB->quote($lastInsertId) . ' and F.P_ID=P.ID');
        if ($Q->rowCount()) {
            $v=$Q->fetch();
            if (strlen($v['geometry'])) {
                $v['geometry'] = json_decode($v['geometry']);
            }
            return $v;
        }
        return null;
    }

}