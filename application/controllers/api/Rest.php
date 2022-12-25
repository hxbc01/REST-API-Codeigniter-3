<?php
defined('BASEPATH') or exit('No direct script access allowed');



require APPPATH . '/libraries/REST_Controller.php';


use Restserver\Libraries\REST_Controller;

class Rest extends REST_Controller
{


    public function __construct()
    {
        parent::__construct();

        $this->load->library('form_validation');
        $this->load->model('m_login');
    }
    public function index_get()
    {
        $id = $this->get('nis');

        // If the id parameter doesn't exist return all the users

        if ($id === NULL) {

            $siswa = $this->db->get("siswa")->result_array();
            // Check if the users data store contains users (in case the database result returns NULL)
            if ($siswa) {
                // Set the response and exit
                $this->response($siswa, REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
            } else {
                // Set the response and exit
                $this->response([
                    'status' => FALSE,
                    'message' => 'Data tidak ditemukan !!'
                ], REST_Controller::HTTP_NOT_FOUND); // NOT_FOUND (404) being the HTTP response code
            }
        }

        // Find and return a single record for a particular user.
        else {


            // Validate the id.
            if ($id <= 0) {
                // Invalid id, set the response and exit.
                $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST); // BAD_REQUEST (400) being the HTTP response code
            }

            // Get the user from the array, using the id as key for retrieval.
            // Usually a model is to be used for this.
            $this->db->where(array("nis" => $id));
            $mapel = $this->db->get("siswa")->row_array();

            $this->response($mapel, REST_Controller::HTTP_OK);
        }
    }

    public function index_post()
    {
        // $this->some_model->update_user( ... );
        $data = [
            'nis' => $this->post('nis'),
            'password' => $this->post('password'),
            'nama' => $this->post('nama'),
            'kelas' => $this->post('kelas')

        ];

        $this->db->insert("siswa", $data);

        $this->set_response($data, REST_Controller::HTTP_CREATED);
    }
    public function index_delete()
    {
        $nis = $this->delete('nis');

        $data = [
            'nis' => $nis,

        ];

        $this->db->delete("siswa", $data);

        $this->set_response($data, REST_Controller::HTTP_NO_CONTENT); // NO_CONTENT (204) being the HTTP response code

        $data = (array("status" => "Data Successfully delete"));
    }
    public function index_put()
    {
        $where = array(
            "nis" => $this->put("nis")
        );
        $data = array(
            "password" => $this->put("password"),
            "nama" => $this->put("nama"),
            "kelas" => $this->put("kelas")

        );

        $this->db->update("siswa", $data, $where);

        $this->set_response($data, REST_Controller::HTTP_CREATED);
    }

    function login_post()
    {
        $nis = $this->post('nis');
        $password = $this->post('password');

        $data = $this->m_login->login($nis, $password);


        if (empty($data)) {
            $output = array(
                'success' => false,
                'message' => 'nis/password is invalid',
                'data' => null
            );

            $this->response($output, REST_Controller::HTTP_OK);
            $this->output->_display();
            exit();
        } else {
            $jwt = new JWT();

            $secret_key = 'jkg43hfkdkhhksd128jnjnnasfkfghcbvksaxmklkmfnjnkmknmsdnf3245';

            $date = new DateTime();

            $payload = array(
                'nis' => $data['nis'],
                'password' => $data['password'],
                'kelas' => $data['kelas'],
            );

            $result = array(
                'success' => true,
                'message' => 'login success',
                'data' => $data,
                'token' => $jwt->encode($payload, $secret_key)
            );
            $this->response($result, REST_Controller::HTTP_OK);
        }
    }

    function token_check()
    {
        $token = $this->input->get_request_header('authorization');

        if (!empty($tkoen)) {
            $token = explode('', $token);
        }

        $jwt = new JWT();

        $secret_key = 'jkg43hfkdkhhksd128jnjnnasfkfghcbvksaxmklkmfnjnkmknmsdnf3245';

        $token_decode = $jwt->decode($token, $secret_key);
    }
}
