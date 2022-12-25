<?php
defined('BASEPATH') or exit('No direct script access allowed');

require APPPATH . 'controller/rest.php';

class Api extends Rest
{

    function __construct($config = 'rest')
    {
        parent::__construct($config);
        $this->load->database('jadwal_siswa');
    }

    function index_get($table = 'siswa', $nis = 'nis')
    {
        if ($table == '') {
            redirect(base_url());
        } else {
            $get_id = 'nis_' . $table;
            if ($nis == '') {

                $data = $this->db->get($table)->result();
            } else {

                $this->db->where($get_id, $nis);
                $data = $this->db->get($table)->result();
            }
            $this->response($data, 200);
        }
    }

    function index_post($table = 'siswa')
    {
        $insert = $this->db->insert($table, $this->post('siswa'));
        $nis = $this->db->insert_id('nis');
        if ($insert) {
            $response = array(
                'data' => $this->post(),
                'table' => $table,
                'nis' => $nis,
                'status' => 'success'
            );
            $this->response($response, 200);
        } else {
            $this->response(array('status' => 'fail', 502));
        }
    }
    function index_put($table = 'siswa', $nis = 'nis')
    { // baseurl/nama_table/id
        $get_id = 'nis_' . $table;
        $this->db->where($get_id, $nis);
        $update = $this->db->update($table, $this->put('siswa'));
        if ($update) {
            $response = array(
                'data' => $this->put('siswa'),
                'siswa' => $table,
                'nis' => $nis,
                'status' => 'success'
            );
            $this->response($response, 200);
        } else {
            $this->response(array('status' => 'fail', 502));
        }
    }
    function index_delete($table = 'siswa', $nis = 'nis')
    {
        $get_id = 'nis_' . $table;
        $this->db->where($get_id, $nis);
        $delete = $this->db->delete($table);
        if ($delete) {
            $response = array(
                'siswa' => $table,
                'nis' => $nis,
                'status' => 'success'
            );
            $this->response($response, 201);
        } else {
            $this->response(array('status' => 'fail', 502));
        }
    }
}
