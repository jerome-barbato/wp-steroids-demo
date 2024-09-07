<?php

class Options
{
    /**
     * Magic method to get property
     *
     * @param $name
     * @return bool
     */
    public function __get($name) {

        return $this->get($name);
    }

    public function __isset($id) {

        //todo:
        return true;
    }

    public function get($name)
    {
        if( function_exists('get_field') ){

            //get options using acf
            return get_field('option', $name);
        }
        elseif( function_exists('carbon_get_theme_option') ){

            //get options using carbon fields
            return carbon_get_theme_option($name);
        }

        return false;
    }
}
