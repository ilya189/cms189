<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * ImageCMS
 * Widgets helper
 */
    
    if ( !function_exists('widget') )
    {
        /**
         * Run widget
         * 
         * @param string $name - widget name
         * @param integer $cache - cache ttl in minutes
         */
        function widget($name = FALSE, $cache = FALSE)
        {
            $ci =& get_instance(); 

            $ci->db->limit(1);
            $query = $ci->db->limit(1)->get_where('widgets', array('name' => $name));

            if ($query->num_rows() == 1)
            {
                $widget = $query->row_array();
            }
            else
            {
                log_message('error', 'Can\'t run widget <b>'.$name.'</b>');
            }

            if ( ($data = $ci->cache->fetch('widget'.$name, 'widgets')) != FALSE AND $cache != FALSE)
            {
                return $data;
            }
            else
            {	
                $widget['settings'] = unserialize($widget['settings']);

                switch ($widget['type'])
                {
                    case 'module':
                        $subpath = isset($widget['settings']['subpath'])?$widget['settings']['subpath'].'/':'';
                        $result = $ci->load->module($widget['data'].'/'.$subpath.$widget['data'].'_widgets')->$widget['method']($widget); 
                    break;

                    case 'html':
                        $result = $widget['data'];
                    break;
                }

                if ($cache != FALSE AND is_integer($cache))
                {
                    $ci->cache->store('widget'.$name, $result, $cache * 60, 'widgets');
                }

                return $result;       
            }
        }
    }

    if ( !function_exists('widget_status') )
    {
        function widget_status($name = FALSE)
        {
            $ci =& get_instance();

            $ci->db->limit(1);
            $query = $ci->db->limit(1)->get_where('widgets', array('name' => $name));

            if ($query->num_rows() == 1)
            {
                $widget = $query->row_array();
            }
            else
            {
                return FALSE;
            }

            return $widget['status'];
        }
    }

/* End of widget_helper.php */
