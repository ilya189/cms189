<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * Image CMS
 * Module Frame
 */
class Basket extends MY_Controller {

    public $me_mail = 'site.soft@mail.ru';
    public $admin_mail = '2904750@mail.ru';

    public function __construct()
    {
        parent::__construct();
        $this->load->library('cart');
    }

    public function index()
    {
        $tpl_data['cart_items'] = $this->fetch_tpl('cart/items',array('cart' => $this->cart));
        $tpl_data['cart_form'] = $this->fetch_tpl('cart/form',array('cart' => $this->cart));
        //$tpl_data['cart'] = $this->cart;
        $this->template->add_array($tpl_data);

        $this->display_tpl('cart');
    }

    public function add()
    {
        if (! $this->input->is_ajax_request() || ! $data = $this->input->post()) return;

        $price_type = ((int)$data['price']) ? 1 : 0;

        $this->db->select('*');
        $this->db->select('CONCAT_WS("", cat_url, url) as full_url');
        $page = $this->db->get_where('content', array('id' => (int)$data['id']))->row_array();
        $page = $this->load->module('cfcm')->connect_fields($page, 'page');

        $data_cart = array(
            'id'      => $page['id'],
            'qty'     => 1,
            'price'   => $price_type ? $page['field_new_price'] : $page['field_old_price'],
            'name'    => $page['title'],
            'options' => array("price" => $price_type),
            'img'     => $page['field_image'],
            'url'     => $page['full_url']
        );

        $result =  $this->cart->get_code($data_cart);

        if ($result == FALSE)
        {
            $success = $this->cart->insert($data_cart);
            $type = 1;
        }
        else
        {
            $data_cart = array(
                'rowid' => $result['code'],
                'qty'   => $result['qty'] + 1
            );
            $success = $this->cart->update($data_cart);
            $type = 2;
        }

        echo json_encode(array(
            'success' => $success,
            'data' => $data_cart,
            'type' => $type,
            'cart' => $this->cart->contents()
        ));
        exit;
    }

    public function delete()
    {
        if (! $this->input->is_ajax_request() || ! $data = $this->input->post()) return;

        $data_cart = array(
            'rowid' => $data['rowid'],
            'qty'   => 0
        );
        $this->cart->update($data_cart);

        $tpl_data['cart_items'] = $this->fetch_tpl('cart/items',array('cart' => $this->cart));
        $tpl_data['cart_form'] = $this->fetch_tpl('cart/form',array('cart' => $this->cart));

        echo json_encode(array(
            'cart' => $this->fetch_tpl('cart',$tpl_data),
        ));
        exit;
    }

    public function update()
    {
        if (! $this->input->is_ajax_request() || ! $data = $this->input->post()) return;

        $data_cart = array(
            'rowid' => $data['rowid'],
            'qty'   => $data['count']
        );
        $this->cart->update($data_cart);

        $tpl_data['cart_items'] = $this->fetch_tpl('cart/items',array('cart' => $this->cart));
        $tpl_data['cart_form'] = $this->fetch_tpl('cart/form',array('cart' => $this->cart));

        echo json_encode(array(
            'cart' => $this->fetch_tpl('cart',$tpl_data),
        ));
        exit;
    }

    public function destroy()
    {
        if (! $this->input->is_ajax_request()) return;

        $this->cart->destroy();

        $tpl_data['cart_items'] = $this->fetch_tpl('cart/items',array('cart' => $this->cart));
        $tpl_data['cart_form'] = $this->fetch_tpl('cart/form',array('cart' => $this->cart));

        echo json_encode(array(
            'cart' => $this->fetch_tpl('cart',$tpl_data),
        ));
        exit;
    }

    public function widget_update() {
        if (! $this->input->is_ajax_request()) return;

        $total_items = $this->cart->total_items();
        $total = $this->cart->total();

        echo json_encode(array(
            'total_items' => $total_items,
            'total' => $total
        ));
        exit;
    }

    public function show()
    {
        echo "<pre>";print_r($this->cart->contents());echo "</pre>";exit;
    }

    public function submit()
    {
        if (! $this->input->is_ajax_request()) return;

        $error = false;
        $this->load->library('form_validation');

        $form_keys = array(
            'fio','org','phone','email','toadres','comment'
        );

        if (count($_POST) > 0)
        {
            $this->form_validation->set_rules('fio', 'ФИО', 'trim|required|max_length[50]|xss_clean');
            $this->form_validation->set_rules('org', 'Организация', 'trim|max_length[200]|xss_clean');
            $this->form_validation->set_rules('phone', 'Телефон', 'trim|required|is_natural|xss_clean');
            $this->form_validation->set_rules('email', 'E-mail', 'max_length[100]|valid_email|xss_clean');
            $this->form_validation->set_rules('toadres', 'Адрес доставки', 'trim|max_length[200]|xss_clean');
            $this->form_validation->set_rules('comment', 'Комментарии к заказу', 'trim|max_length[4000]|xss_clean');

            if ($this->form_validation->run($this) == FALSE)
            {
                $this->template->assign('form_errors', validation_errors('<div style="color:red">', '</div>'));
                $this->template->add_array(
                    $this->_valid_array($form_keys,'error')
                );
                $this->template->add_array(
                    $this->_valid_array($form_keys,'value')
                );
                $error = true;
            }
            else
            {
                $this->template->add_array(
                    $this->_valid_array($form_keys,'value')
                );
                $tpl_data['cart'] = $this->cart;
                $this->message = $this->fetch_tpl('cart/message',$tpl_data);

                $this->_send_message("admin");
                $this->_send_message("me");
                if ($this->input->post('email')) $this->_send_message("buyer");

                $this->cart->destroy();

                $tpl_data['send_message'] = "Заявка отправлена!";
            }
        }
        else return;

        $tpl_data['cart_items'] = $this->fetch_tpl('cart/items',array('cart' => $this->cart));
        $tpl_data['cart_form'] = $this->fetch_tpl('cart/form',array('cart' => $this->cart));

        echo json_encode(array(
            'cart' => $this->fetch_tpl('cart',$tpl_data),
            'form' => $tpl_data['cart_form'],
            'error' => $error,
        ));
        exit;
    }

    private function _valid_array($keys = array(),$function)
    {
        $result = array();

        foreach ($keys as $key)
        {
            if ($function == "error") $result['error_'.$key] = form_error($key);
            if ($function == "value") $result[$key] = set_value($key);
        }

        return $result;
    }

    private function _send_message($to)
    {
        $config['charset'] = 'UTF-8';
        $config['wordwrap'] = FALSE;
        $config['mailtype'] = 'html';

        $this->load->library('email');
        $this->email->initialize($config);

        switch ($to)
        {
            case 'buyer':
                $this->email->from("no-reply@lestnisa.net", "lestnisa.net");
                $this->email->to($this->input->post('email'));
                $this->email->subject("Заказ на сайте lestnisa.net");
                break;
            case 'me':
                $this->email->from("no-reply@lestnisa.net", "lestnisa.net");
                $this->email->to($this->me_mail);
                $this->email->subject("Заказ на сайте lestnisa.net");
                break;
            default:
                $email = ($this->input->post('email')) ? $this->input->post('email') : "no-reply@lestnisa.net";
                $this->email->from($email, $this->input->post('fio'));
                $this->email->to($this->admin_mail);
                $this->email->subject("Заказ с сайта lestnisa.net");
                break;
        }

        $this->email->message($this->message);

        $this->email->send();
    }

    public function autoload()
    {
        
    }

    public function _install()
    {
        /** We recomend to use http://ellislab.com/codeigniter/user-guide/database/forge.html */

          $this->load->dbforge();
        /**
          $fields = array(
          'id' => array('type' => 'INT', 'constraint' => 11, 'auto_increment' => TRUE,),
          'name' => array('type' => 'VARCHAR', 'constraint' => 50,),
          'value' => array('type' => 'VARCHAR', 'constraint' => 100,)
          );

          $this->dbforge->add_key('id', TRUE);
          $this->dbforge->add_field($fields);
          $this->dbforge->create_table('mod_empty', TRUE);
         */

          $this->db->where('name', 'basket')
          ->update('components', array('in_menu' => '1', 'enabled' => '1'));

    }

    public function _deinstall()
    {
        /**
          $this->load->dbforge();
          $this->dbforge->drop_table('mod_empty');
         *
         */
    }

    /**
     * Display template file
     */
    private function display_tpl($file = '')
    {
        $file = realpath(dirname(__FILE__)) . '/templates/' . $file;
        $this->template->show('file:' . $file);
    }

    /**
     * Fetch template file
     */
    private function fetch_tpl($file = '', $data = array())
    {
        $this->template->add_array($data);

        $file = realpath(dirname(__FILE__)) . '/templates/' . $file . '.tpl';
        return $this->template->fetch('file:' . $file);
    }

}

/* End of file sample_module.php */
