<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if (!function_exists('image_resize'))
{
    function image_resize($file,$size,$fill = false)
    {
        $ci =& get_instance();
        $ci->load->library('lib_upload');
        $image = $ci->lib_upload;

        if (substr($file,0,1) == '/') $file = substr($file,1);
        $full_path = realpath($file);
        $full_file = basename($file);
        $file_name = substr($full_file, 0, strrpos($full_file, '.'));
        $file_ext = substr($full_file, strrpos($full_file, '.') ? strrpos($full_file, '.') + 1 : iconv_strlen($full_file,'UTF-8'));
        if ($file_ext != '') $file_ext = ".".strtolower($file_ext);
        $file_size = filesize($full_path);
        $prefix = $size."_";
        $new_file_name = $prefix . md5($file_name.$file_ext.$file_size);

        $file_dir = 'uploads/imagecache/' . str_replace($full_file,'',$file);

        preg_match('/(\d*)([x]{1,2})(\d*)/',$size,$resize_info);

        if (is_file($file_dir . $new_file_name . $file_ext)) return $file_dir . $new_file_name . $file_ext;

        $image->upload($full_path,'ru_RU');
        if ($image->uploaded)
        {
            $image->file_new_name_body = $new_file_name;
            $image->file_safe_name = false;
            $image->file_force_extension = false;
            $image->file_overwrite = true;
            $image->image_resize = true;
            $image->image_ratio = true;
            if ($fill) $image->image_ratio_fill = true;
            if ($resize_info[2] == 'xx') $image->image_ratio_crop = true;
            if ($resize_info[1]) $image->image_x = (int)$resize_info[1]; else $image->image_ratio_x = true;
            if ($resize_info[3]) $image->image_y = (int)$resize_info[3]; else $image->image_ratio_y = true;

            $image->Process($file_dir);

            if ($image->processed)
            {
                return $file_dir . $new_file_name . $file_ext;
            }
            else
            {
                return $image->error;
            }
        }
        else
        {
            return $image->error;
        }
    }



}

?>
