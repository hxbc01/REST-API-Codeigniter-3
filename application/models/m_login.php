<?php
defined('BASEPATH') or exit('No direct script access allowed');

class m_login extends CI_Model
{

    function login($nis, $password)
    {
        $this->db->where('nis', $nis);
        $this->db->where('password', $password);
        $data = $this->db->get('siswa');

        return $data->row_array();
    }
}
