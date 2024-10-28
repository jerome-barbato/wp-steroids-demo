<?php

/**
 * Shared code across projects, defines default behaviour for WordPress
 * Add most used twig functions and filters
 */

use Timber\Factory\PostFactory;
use Timber\Image;
use Timber\ImageHelper;
use Timber\Timber;
use Timber\URLHelper;

abstract class Kernel extends \Timber\Site {

    private $entrypoints;
    private $manifest;
    private $translations;

    private $options;

    /** Add timber support. */
    public function __construct() {

        $this->options = new Options();

        add_filter('network_site_url', [$this, 'networkSiteURL'] );
        add_filter('option_siteurl', [$this, 'optionSiteURL'] );

        add_filter('timber/post/pre_meta', function ($post_meta, $pid){

            $post = get_post($pid);

            if( $post->post_type == 'revision' && $post->post_parent )
                return get_post_meta($post->post_parent);

            return $post_meta;

        },10, 2);

        add_action( 'init', [$this, 'maintenance']);
        add_action( 'init', [$this, 'redirect']);
        add_action( 'init', [$this, 'get_translations']);

        add_filter( 'timber/context', [$this, 'addToContext'] );
        add_filter( 'timber/twig', [$this, 'addToTwig'] );
        add_filter( 'block_render_callback', [$this, 'renderBlock']);

        if( file_exists(__DIR__.'/../public/build/entrypoints.json'))
            $this->entrypoints = json_decode(file_get_contents(__DIR__.'/../public/build/entrypoints.json'), true);

        if( file_exists(__DIR__.'/../public/build/manifest.json'))
            $this->manifest = json_decode(file_get_contents(__DIR__.'/../public/build/manifest.json'), true);

        if( is_admin() )
            add_action('enqueue_block_editor_assets', [$this, 'enqueueBlockEditorAssets']);

        parent::__construct();
    }

    public function maintenance()
    {
        $path = rtrim($_SERVER['REQUEST_URI'], '/');

        if( function_exists('wp_maintenance_mode') && wp_maintenance_mode() && !is_admin() && !is_login() && !($path == '/edition' || $path == '/edition/') ){

            $templates = array( 'maintenance.twig' );
            $context = Timber::context();

            $context['wp_title'] = __( 'Maintenance' );

            if( $post_id = get_page_by_state('maintenance') )
                $context['post'] = \Timber::get_post($post_id);

            if( $html = Timber::compile( $templates, $context ) ){

                status_header(503);
                nocache_headers();

                echo $html;
                exit;
            }
            else{

                wp_die(__( 'Briefly unavailable for scheduled maintenance. Check back in a minute.' ), $context['wp_title'],503);
            }
        }
    }

    /**
     * @param $url
     * @return string
     */
    public function optionSiteURL($url)
    {
        return strpos($url, '/edition') === false ? $url.'/edition' : $url;
    }

    /**
     * @param $url
     * @return array|string|string[]
     */
    public function networkSiteURL($url)
    {
        if( strpos($url, '/edition') === false )
        {
            $url = str_replace('/wp-login', '/edition/wp-login', $url);
            return str_replace('/wp-admin', '/edition/wp-admin', $url);
        }
        else{

            return $url;
        }
    }

    public function redirect()
    {
        if( defined('DOING_CRON') && DOING_CRON )
            return;

        if( isset($_REQUEST['s']) && !is_admin() ){

            $permalink = get_search_link(sanitize_text_field($_REQUEST['s']));
            wp_redirect($permalink);
            exit;
        }

        $path = rtrim($_SERVER['REQUEST_URI'], '/');

        if( ($path == '/edition' || $path == '/edition/') && 'POST' !== $_SERVER['REQUEST_METHOD'] ){

            wp_redirect(is_user_logged_in() ? admin_url('index.php') : wp_login_url());
            exit;
        }
    }

    /**
     * @return void
     */
    function enqueueBlockEditorAssets() {

        if ( in_array($_SERVER['REMOTE_ADDR'], array('127.0.0.1', '::1')) ){

            wp_enqueue_style('block_editor_style','http://localhost:8080/build/bundle.css');
        }
        elseif( $path = $this->manifest['build/bundle.css']??false ){

            if( is_multisite() )
                wp_enqueue_style('block_editor_style', network_home_url($path));
            else
                wp_enqueue_style('block_editor_style', home_url($path));
        }
    }

    /**
     * @return false|int|mixed|string|null
     */
    public static function get_post_id() {

        if ( $post_id = get_the_ID() )
            return $post_id;

        $post_id = isset( $_GET['post'] ) && (int) $_GET['post'] > 0 ? (int) $_GET['post'] : null;

        if ( ! empty( $post_id ) )
            return $post_id;

        $admin_url = isset( $_SERVER['HTTP_REFERER'] ) && ! empty( $_SERVER['HTTP_REFERER'] ) ? $_SERVER['HTTP_REFERER'] : null;

        if ( ! empty( $admin_url ) ) {

            $parsed_url = parse_url( $admin_url );

            if ( isset( $parsed_url['query']) && ! empty( $parsed_url['query'] ) ) {

                $params = explode( '&', $parsed_url['query'] );

                foreach ( $params as $param ) {

                    $param = explode( '=', $param );

                    if ( $param[0] === 'post' )
                        $post_id = $param[1];
                }
            }
        }

        return $post_id;
    }

    /**
     * @param $block
     * @param $content
     * @param $is_preview
     * @return void
     */
    public static function renderBlock($block, $content = '', $is_preview = false){

        if( !($block['front']??true) && !is_admin() )
            return;

        $is_preview = $_REQUEST['query']['preview']??false;

        if( $is_preview && $image = $block['data']['_preview_image']??false ){

            echo '<img src="'.get_home_url().$image.'" style="width:100%;height:auto" class="preview_image"/>';
            return;
        }

        $context = Timber::context();

        if( $id = self::get_post_id() )
            $context['post'] = Timber::get_post($id);

        //todo: optimize to use $block['data']??
        $context['props'] = get_fields();

        // Store field values.
        $context['block'] = $block;

        // Store $is_preview value.
        $context['is_preview'] = $is_preview;
        $context['is_admin'] = is_admin();
        $context['is_front_page'] = is_front_page();

        // Render the block.
        $name = str_replace('_', '-', str_replace('acf/', '', $block['name']??''));

        Timber::render( 'block/'.$name.'/'.$name.'.twig', $context );
    }

    private function get_translations()
    {
        if( $translations = $this->options->get('translations') )
        {
            $this->translations = [];
            foreach ($translations as $translation)
            {
                $key = sanitize_title($translation['key']);
                $this->translations[$key] = $translation['translation'];
            }
        }
    }

    /** This is where you add some context
     *
     * @param array $context context['this'] Being the Twig's {{ this }}.
     */
    public function addToContext( $context ) {

        $context['environment'] = WP_ENV;
        $context['current_url'] = URLHelper::get_current_url();
        $context['blog'] = $this;
        $context['options'] = $this->options;

        if( is_archive() ){

            $archive_type = $this->getArchivePostType();
            $context['archive'] = $this->options->get($archive_type);

            if( is_array($context['archive']) ){

                $context['archive']['link'] = get_post_type_archive_link($archive_type);

                if( isset($context['archive']['title']) )
                    $context['wp_title'] = $context['archive']['title'];
            }
        }

        return $context;
    }

    /**
     * @param $entryName
     * @return string
     */
    public function renderWebpackLinkTags($entryName ) {

        $entries = $this->entrypoints['entrypoints'][$entryName]['css']??[];

        $styles = '';

        foreach ($entries as $entry)
            $styles .= "<link rel='stylesheet' href='{$entry}' type='text/css' media='all' />";

        return $styles;
    }

    /**
     * @param $entryName
     * @return string
     */
    public function renderWebpackScriptTags($entryName ) {

        $entries = $this->entrypoints['entrypoints'][$entryName]['js']??[];

        $styles = '';

        foreach ($entries as $entry)
            $styles .= "<script type='text/javascript' src='{$entry}' defer></script>";

        return $styles;
    }

    /**
     * @param $entryName
     * @param $version
     * @return false|mixed
     */
    public function asset($entryName, $version=0) {

        $url = $this->manifest['build/'.$entryName]??false;
        $url = $url?:'/static/' . $entryName;

        if( $version )
            $url .= (strpos($url, '?' ) !== false ? '&v=' : '?v=' ).$version;

        return $url;
    }

    /**
     * @param $object
     * @param $property
     * @param $value
     */
    public function assign($object, $property, $value) {

       if( is_object($object) )
           $object->$property = $value;

       return $object;
    }

    /**
     * @param $src
     * @param $width
     * @param $height
     * @param $sources
     * @param $alt
     * @param $loading
     * @return string
     */
    public function generateFigure($src, $width, $height=0, $sources=[], $alt=false, $loading='lazy') {

        $post_id = false;
        $html = '';

        if( $src instanceof Image )
            $post_id = $src->id;
        elseif( is_array($src) )
            $post_id = $src['ID']??false;
        elseif( is_int($src) )
            $post_id = $src;

        if( $post_id ){

            $post = get_post($post_id);

            $image = $this->generatePicture($src, $width, $height, $sources, $alt, $loading);
            $html = '<figure class="figure'.(strlen($post->post_excerpt)?' has-caption':'').'">';
            $html .= $image;

            if( strlen($post->post_excerpt) )
                $html .= '<figcaption>'.$post->post_excerpt.'</figcaption>';

            $html .= '</figure>';
        }

        return $html;
    }

    /**
     * @param $width
     * @param int $height
     * @return string
     */
    public function generatePlaceholder($width, $height=0) {

        $params = '';

        if( !$width ){

            $params = '?text=0x'.$height;
            $width = $height;
        }

        if( !$height ){

            $params = '?text='.$width.'x0';
            $height = $width;
        }

        $height = !$height?$width:$height;
        $width = !$width?$height:$width;

        return 'https://placehold.co/'.$width.'x'.$height.$params;
    }

    /**
     * @param $src
     * @param $width
     * @param int $height
     * @param string $crop
     * @return string
     */
    public function resizeImage($src, $width, $height=0, $crop='center') {

        $debug = ($_GET['debug']??false) == 'image' && defined('WP_DEBUG') && WP_DEBUG;

        if( $debug )
            return $this->generatePlaceholder($width, $height);
        else
            return ImageHelper::resize($src, $width, $height, $crop);
    }

    /**
     * @param $image
     * @param $width
     * @param int $height
     * @param bool $ext
     * @return string
     */
    public function cropImage($image, $width, $height=0, $ext=false) {

        $post_id = false;
        $debug = ($_GET['debug']??false) == 'image' && defined('WP_DEBUG') && WP_DEBUG;
        $crop = 'center';

        if( $image instanceof Image )
            $post_id = $image->id;
        elseif( is_array($image) )
            $post_id = $image['ID']??false;
        elseif( is_int($image) )
            $post_id = $image;

        if( $post_id ){

            $src = wp_get_original_image_path($post_id);
            if( !file_exists($src) )
                return '';

            if( $_crop = get_post_meta($post_id, 'crop', true) )
                $crop = $_crop;

            if( !is_array($image) or !isset($image['url'], $image['alt'], $image['mime_type']) ){

                $attachment = get_post( $post_id );

                $image = wp_get_attachment_url( $attachment->ID );
            }
        }

        if( !$image )
            return '';

        $src = $ext == 'webp' && function_exists('imagewebp') ? ImageHelper::img_to_webp($image['url']) : $image['url'];

        return $debug ? $this->generatePlaceholder($width, $height) : $this->resizeImage($src, $width, $height, $crop);
    }

    /**
     * @param $image
     * @param $width
     * @param $height
     * @param $sources
     * @param $alt
     * @param $loading
     * @return string
     */
    public function generatePicture($image, $width, $height=0, $sources=[], $alt=false, $loading='lazy') {

        $post_id = false;
        $debug = ($_GET['debug']??false) == 'image' && defined('WP_DEBUG') && WP_DEBUG;
        $crop = 'center';

        if( $image instanceof Image )
            $post_id = $image->id;
        elseif( is_array($image) )
            $post_id = $image['ID']??false;
        elseif( is_int($image) )
            $post_id = $image;

        if( isset($sources['lazy']) ){

            if( !$sources['lazy'] )
                $loading = 'eager';

            unset( $sources['lazy'] );
        }

        if( isset($sources['alt']) ){

            $alt = $sources['alt'];
            
            unset( $sources['alt'] );
        }

        if( $post_id ){

            $src = wp_get_original_image_path($post_id);
            if( !file_exists($src) )
                return '';

            if( $_crop = get_post_meta($post_id, 'crop', true) )
                $crop = $_crop;

            if( !is_array($image) or !isset($image['url'], $image['alt'], $image['mime_type']) ){

                $attachment = get_post( $post_id );

                $image = [
                    'url' => wp_get_attachment_url( $attachment->ID ),
                    'alt' => get_post_meta( $attachment->ID, '_wp_attachment_image_alt', true ),
                    'mime_type' => $attachment->post_mime_type
                ];
            }
        }

        if( !$image )
            return '';

        $image['alt'] = htmlspecialchars($alt?:$image['alt'], ENT_QUOTES, 'UTF-8');

        $ext = function_exists('imagewebp') ? 'webp' : null;
        $mime = function_exists('imagewebp') ? 'image/webp' : $image['mime_type'];

        $html = '<picture class="responsive-picture">';

        if($image['mime_type'] == 'image/svg+xml' || $image['mime_type'] == 'image/svg' || $image['mime_type'] == 'image/gif' ){

            $img_src = $debug ? $this->generatePlaceholder($width, $height) : $image['url'];
            $html .= '<img loading="'.$loading.'" src="'.$img_src.'" alt="'.$image['alt'].'" '.($width?'width="'.$width.'"':'').' '.($height?'height="'.$height.'"':'').'/>';
        }
        else {

            $webp_src = $ext ? ImageHelper::img_to_webp($image['url']) : false;

            if ($sources && is_array($sources)) {

                foreach ($sources as $media => $size) {

                    if (is_int($media))
                        $media = 'max-width: ' . $media . 'px';

                    $target_width = $size[0] ?? 0;
                    $target_height = $size[1] ?? 0;

                    if ( $webp_src ) {

                        $url = $this->resizeImage($webp_src, $size[0] ?? 0, $size[1] ?? 0, $crop);

                        if( ($target_width > 0 && $target_width < 960 && $target_height < 960) || ($target_height > 0 && $target_height < 960 && $target_width < 960) ) {

                            $url_2x = $this->resizeImage($webp_src, $target_width * 2, $target_height * 2, $crop);
                            $html .= '<source media="(' . $media . ')" srcset="' . $url . ' 1x, ' . $url_2x . ' 2x" type="' . $mime . '"/>';
                        }
                        else{

                            $html .= '<source media="(' . $media . ')" srcset="' . $url . '" type="' . $mime . '"/>';
                        }
                    }

                    $url = $this->resizeImage($image['url'], $size[0] ?? 0, $size[1] ?? 0, $crop);

                    if( ($target_width > 0 && $target_width < 960 && $target_height < 960) || ($target_height > 0 && $target_height < 960 && $target_width < 960) ){

                        $url_2x = $this->resizeImage($image['url'], $target_width*2, $target_height*2, $crop);
                        $html .= '<source media="(' . $media . ')" srcset="' . $url . ' 1x, '.$url_2x.' 2x" type="' . $image['mime_type'] . '"/>';
                    }
                    else{

                        $html .= '<source media="(' . $media . ')" srcset="' . $url . '" type="' . $image['mime_type'] . '"/>';
                    }
                }
            }

            if ( $webp_src ) {

                $url = $this->resizeImage($webp_src, $width, $height, $crop);

                if( ( $width> 0 && $width < 960 && $height < 960 ) || ( $height > 0 && $height < 960 && $width < 960 ) ){

                    $url_2x = $this->resizeImage($webp_src, $width*2, $height*2, $crop);
                    $html .= '<source srcset="' . $url . ' 1x, '.$url_2x.' 2x" type="image/webp"/>';
                }
                else{

                    $html .= '<source srcset="' . $url . '" type="image/webp"/>';
                }
            }

            $url = $this->resizeImage($image['url'], $width, $height, $crop);

            $au = ImageHelper::analyze_url($url);
            $upload_dir = wp_upload_dir();

            if( !$image_info = getimagesize($upload_dir['basedir'].$au['subdir'].'/'.$au['basename']) )
                return '';

            $html .= '<img loading="' . $loading . '" src="' . $url . '" alt="' . $image['alt'] . '" '.($image_info[0]?'width="'.$image_info[0].'"':'').' '.($image_info[1]?'height="'.$image_info[1].'"':'').'/>';
        }

        $html .='</picture>';

        return $html;
    }

    /**
     * @param $text
     * @param array $params
     * @return string
     */
    public function translate($text, $params=[])
    {
        $key = sanitize_title($text);
        $params = (array)$params;

        if( isset($this->translations[$key]) ){

            return vsprintf($this->translations[$key], $params);
        }
        else{

            $debug = ($_GET['debug']??false) == 'translation' && defined('WP_DEBUG') && WP_DEBUG;

            if( $debug )
                return '{{'.htmlspecialchars($text).'}}';

            return vsprintf($text, $params);
        }
    }

    /**
     * Email string verification.
     *
     * @param        $text
     * @return mixed
     */
    public function protectEmail($text)
    {
        if( !$text )
            return;

        preg_match_all( '/<a (.*)href="mailto:([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})"(.*)>(.*)<\/a>/', $text, $potentialEmails, PREG_SET_ORDER );

        $potentialEmailsCount = count( $potentialEmails );

        for ( $i = 0; $i < $potentialEmailsCount; $i++ )
        {
            $potentialEmail = $potentialEmails[$i];

            if ( filter_var( $potentialEmail[2], FILTER_VALIDATE_EMAIL ) )
            {
                $email = $potentialEmail[2];
                $email = explode( '@', $email );

                if( filter_var( $potentialEmail[4], FILTER_VALIDATE_EMAIL ) )
                    $text = str_replace( $potentialEmail[0], '<email ' . $potentialEmail[1] .$potentialEmail[3] . ' name="' . $email[0] . '" domain="' . $email[1] . '" text="">@</email>', $text );
                else
                    $text = str_replace( $potentialEmail[0], '<email ' . $potentialEmail[1] .$potentialEmail[3] . ' name="' . $email[0] . '" domain="' . $email[1] . '" text="'.$potentialEmail[4].'">@' . $potentialEmail[4] . '</email>', $text );
            }
        }

        preg_match_all( '/([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})/', $text, $potentialEmails, PREG_SET_ORDER );

        $potentialEmailsCount = count( $potentialEmails );

        for ( $i = 0; $i < $potentialEmailsCount; $i++ )
        {
            if ( filter_var( $potentialEmails[$i][0], FILTER_VALIDATE_EMAIL ) )
            {
                $email = $potentialEmails[$i][0];
                $email = explode( '@', $email );

                $text = str_replace( $potentialEmails[$i][0], '<email name="' . $email[0] . '" domain="' . $email[1] . '" text="">@' . $email[0] . '</email>', $text );
            }
        }

        return new \Twig\Markup($text, 'UTF-8');;
    }


    /**
     * Returns the video ID of a youtube video.
     *
     * @param $url
     * @return string
     */
    public function youtubeID($url)
    {
        preg_match( '/^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)\/))([^\?&">]+)/', $url, $matches );

        return count( $matches ) > 1 ? $matches[1] : '';
    }


    /**
     * Returns the video ID of a vimeo video.
     *
     * @param $url
     * @return string
     */
    public function vimeoID($url)
    {
        preg_match( "/^(?:http(?:s)?:\/\/)?(?:www\.)?(?:player\.)?vimeo\.com\/([0-9]{6,11})[?]?.*/", $url, $matches );
        return count( $matches ) > 1 ? $matches[1] : '';
    }


    /**
     * @param $text
     * @return mixed
     */
    public function encode($text)
    {
        return substr($text, 0,1).base64_encode(str_replace('@','$', $text));
    }

    /**
     * @return string
     */
    public function formatPhone($text)
    {
        return chunk_split($text, 2, ' ');
    }

    /**
     * @param $text
     * @return \Twig\Markup
     */
    public function spaceToSpan($text)
    {
        $text = explode(' ', $text);
        $html = '<span>'.implode('</span><span>', $text).'</span>';

        return new \Twig\Markup($html, 'UTF-8');
    }

    /**
     * @param $text
     * @return \Twig\Markup
     */
    public function lineBreakToP($text)
    {
        $text = explode("\n", $text);
        $html = '<p>'.implode('</p><p>', array_filter($text)).'</p>';
        $html = str_replace("<p>\r</p>", '', $html);

        return new \Twig\Markup($html, 'UTF-8');
    }

    /**
     * @param $text
     * @return \Twig\Markup
     */
    public function lineBreakToSpan($text)
    {
        $text = explode("\n", $text);
        $html = '<span>'.implode('</span><span>', array_filter($text)).'</span>';
        $html = str_replace("<span>\r</span>", '', $html);

        return new \Twig\Markup($html, 'UTF-8');
    }


    /**
     * Returns a proper url
     *
     * @param $url
     * @param bool $full
     * @return string
     */
    public function parseUrl($url, $full=true)
    {
        $parsed_url = parse_url($url);

        $scheme   = isset($parsed_url['scheme']) ? $parsed_url['scheme'] . '://' : 'https://';
        $host     = $parsed_url['host'] ?? '';
        $port     = isset($parsed_url['port']) ? ':' . $parsed_url['port'] : '';
        $user     = $parsed_url['user'] ?? '';
        $pass     = isset($parsed_url['pass']) ? ':' . $parsed_url['pass']  : '';
        $pass     = ($user || $pass) ? "$pass@" : '';
        $path     = $parsed_url['path'] ?? '';
        $query    = isset($parsed_url['query']) ? '?' . $parsed_url['query'] : '';
        $fragment = isset($parsed_url['fragment']) ? '#' . $parsed_url['fragment'] : '';

        if( $full )
            return $scheme.$user.$pass.$host.$port.$path.$query.$fragment;
        else
            return str_replace('www.', '', empty($host)?$path:$host);
    }

    /**
     * @param $objects
     * @param $attrs
     * @return mixed
     * @internal param $text
     */
    public function bind($objects, $attrs)
    {
        $binded_objects = [];
        $objects = (array)$objects;

        foreach ($objects as $object)
        {
            if( is_array($attrs) )
            {
                $binded_object = [];
                foreach ($attrs as $dest=>$source)
                {
                    if( is_object($object)){

                        $method = 'get'.ucfirst($attrs);
                        $binded_objects[$dest] = method_exists($object,$method)?$object->$method(): false;
                    }
                    else{

                        $binded_object[$dest] = isset($object[$source]) ? $object[$source] : false;
                    }
                }

                $binded_objects[] = array_filter($binded_object);
            }
            else
            {
                if( is_object($object)){

                    $method = 'get'.ucfirst($attrs);
                    $binded_objects[] = method_exists($object,$method)?$object->$method(): false;
                }
                else
                    $binded_objects[] = isset($object[$attrs]) ? $object[$attrs] : false;
            }
        }

        return array_filter($binded_objects);
    }

    /**
     * @param $object
     * @return string
     */
    public function generateTable($object){

        $html = '<table>';

        if( !empty($object['caption']) )
            $html .= '<caption>'.$object['caption'].'</caption>';

        if( !empty($object['header']) ){

            $html .= '<thead><tr>';

            foreach ($object['header'] as $col){
                $html .= '<th>'.$col['c'].'</th>';
            }

            $html .= '</tr></thead>';
        }

        $html .= '<tbody>';

        foreach ($object['body'] as $row){

            $html .= '<tr>';

            foreach ($row as $col)
                $html .= '<td>'.$col['c'].'</td>';

            $html .= '</tr>';
        }

        $html .= '</tbody></table>';

        return $html;
    }

    /**
     * @param $string
     * @return false|string
     */
    public function encrypt($string){

        return openssl_encrypt($string, "AES-128-CTR", getenv('APP_SECRET'), 0, '1234567891011121');
    }

    /**
     * @param $string
     * @return false|string
     */
    public function nonce($string){

        return wp_create_nonce($string);
    }

    /**
     * @param $page
     * @param $by
     * @return false|string
     */
    public function getPermalink($page, $by=false )
    {
        switch ( $by ){

            case 'state':

                if( !function_exists('get_page_by_state') )
                    return false;

                $page = get_page_by_state($page);
                break;

            case 'path':

                $page = get_page_by_path($page);
                break;

            case 'title':

                $page = get_page_by_title($page);
                break;

            case 'slug':

                if( !is_array($page) or count($page) != 2 )
                    return false;

                $post_ids = get_posts([
                    'name'   => $page[0],
                    'post_type'   => $page[1],
                    'numberposts' => 1,
                    'fields' => 'ids'
                ]);

                if( count($post_ids) )
                    $page = $post_ids[0];
        }

        if( $page ){

            $link = get_permalink($page);

            if( !is_string($link) )
                return false;

            return $link;
        }
        else
            return false;
    }

    /**
     * @param $post
     * @param $name
     * @return bool
     */
    public function hasBlock($post, $name=false){

        if( !$post || !$post->post_content || !has_blocks($post) )
            return false;

        if( !$name )
            return true;

        $blocks = parse_blocks($post->post_content);

        foreach ($blocks as $block){

            if( $block['blockName'] == $name || $block['blockName'] == 'acf/'.$name)
                return true;
        }

        return false;
    }

    /**
     * @param $post
     * @param bool $field
     * @return mixed
     */
    public function getFirstBlock($post, $field=false){

        $blocks = $this->getBlocks($post);

        if( !$field )
            return $blocks[0]['attrs']??false;

        return $blocks[0]['attrs']['data'][$field]??null;
    }

    /**
     * @param $hex
     * @return bool
     */
    function isColorDark($hex)
    {
        $average = 381; // range 1 - 765

        if(strlen(trim($hex)) == 4)
            $hex = "#" . substr($hex,1,1) . substr($hex,1,1) . substr($hex,2,1) . substr($hex,2,1) . substr($hex,3,1) . substr($hex,3,1);

        return hexdec(substr($hex,1,2))+hexdec(substr($hex,3,2))+hexdec(substr($hex,5,2)) < $average;
    }

    /**
     * @param WPS_Post $post
     * @param $taxonomy
     * @return int|string|null
     */
    function getPostPositionInTaxonomy($post, $taxonomy ) {

        if( !$post instanceof \Timber\Post )
            return null;

        $terms = wp_get_post_terms( $post->id, $taxonomy );

        if ( !empty( $terms ) && !is_wp_error( $terms ) ) {

            $term_id = $terms[0]->term_id;

            $args = array(
                'post_type' => $post->post_type,
                'posts_per_page' => -1,
                'tax_query' => array(
                    array(
                        'taxonomy' => $taxonomy,
                        'field'    => 'term_id',
                        'terms'    => $term_id,
                    ),
                ),
                'fields'  => 'ids'
            );

            $post_ids = get_posts( $args );

            $position = array_search( $post->id, $post_ids );

            if ( $position !== false )
                return $position + 1;
        }

        return null;
    }

    /**
     * @param $post
     * @return array
     */
    public function getBlocks($post){

        if( !$post || !$post->post_content || !has_blocks($post) )
            return [];

        return parse_blocks($post->post_content);
    }

    public function enqueue_contact_form_scripts(){

        if ( function_exists( 'wpcf7_enqueue_scripts' ) )
            wpcf7_enqueue_scripts();

        if ( function_exists( 'wpcf7_enqueue_styles' ) )
            wpcf7_enqueue_styles();
    }

    /**
     * Generate transparent pixel base64 image
     * @param $w
     * @param $h
     * @return string
     */
    public function generatePixel($w = 1, $h = 1) {

        ob_start();

        if( $h == 0 )
            $h = $w;
        elseif( $w == 0 )
            $w = $h;

        $img = imagecreatetruecolor($w, $h);
        imagetruecolortopalette($img, false, 1);
        imagesavealpha($img, true);
        $color = imagecolorallocatealpha($img, 0, 0, 0, 127);
        imagefill($img, 0, 0, $color);
        imagepng($img, null, 9);
        imagedestroy($img);

        $imagedata = ob_get_contents();
        ob_end_clean();

        return 'data:image/png;base64,' . base64_encode($imagedata);
    }

    /**
     * @param $picture
     * @return string
     */
    public function placeholder($picture){

        if( empty($picture) )
            $picture = '<span class="image-placeholder"></span>';

        return $picture;
    }

    /**
     * @param $file
     * @param int $max_w
     * @param int $max_h
     * @return string
     */
    public function generateLottiePlaceholder($file, $max_w=0, $max_h=0){

        $json = json_decode(file_get_contents($file), true);
        $w = $json['w']??800;
        $h = $json['h']??600;

        return '<img src="'.$this->generatePixel($w, $h).'" style="'.($max_h?'max-height:'.$max_h.'px':'').($max_w?';max-width:'.$max_w.'px':'').'"/>';
    }

    /**
     * @param $state
     * @return object|bool
     */
    public function getPageByState($state){

        $postFactory = new PostFactory();

        if( $post = get_page_by_state($state) )
            return $postFactory->from($post);

        return false;
    }

    /**
     * @return false|mixed
     */
    public function getArchivePostType(){

        global $wp_query;

        return $wp_query->query['post_type']??false;
    }

    /** This is where you can add your own functions to twig.
     *
     * @param Twig_Environment $twig get extension.
     */
    public function addToTwig( $twig ) {

        $twig->addExtension( new Twig\Extension\StringLoaderExtension() );

        $twig->addFunction( new Twig\TwigFunction( 'encore_entry_link_tags', [$this, 'renderWebpackLinkTags'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'encore_entry_script_tags', [$this, 'renderWebpackScriptTags'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'enqueue_contact_form_scripts', [$this, 'enqueue_contact_form_scripts'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'asset', [$this, 'asset'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'nonce', [$this, 'nonce'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'archive_url', 'get_post_type_archive_link' ) );
        $twig->addFunction( new Twig\TwigFunction( 'search_url', 'get_search_link' ) );
        $twig->addFunction( new Twig\TwigFunction( 'post_query', function ($query){ return Timber::get_posts($query); }) );
        $twig->addFunction( new Twig\TwigFunction( 'term_query', function ($query){ return Timber::get_terms($query); }) );
        $twig->addFunction( new Twig\TwigFunction( 'get_object_terms', 'wp_get_object_terms') );
        $twig->addFunction( new Twig\TwigFunction( 'post_url',  [$this, 'getPermalink']) );
        $twig->addFunction( new Twig\TwigFunction( 'permalink', 'get_permalink' ) );
        $twig->addFunction( new Twig\TwigFunction( 'calculated_carbon', 'get_calculated_carbon' ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_front_page',  'is_front_page' ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_404',  'is_404' ) );
        $twig->addFunction( new Twig\TwigFunction( 'archive_post_type',  [$this, 'getArchivePostType'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_archive',  'is_archive' ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_sticky',  'is_sticky' ) );
        $twig->addFunction( new Twig\TwigFunction( 'archive_title',  'get_the_archive_title' ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_singular',  'is_singular' ) );
        $twig->addFunction( new Twig\TwigFunction( 'get_page_by_state',  [$this, 'getPageByState'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'get_position_in_tax',  [$this, 'getPostPositionInTaxonomy'] ) );
        $twig->addFunction( new Twig\TwigFunction( 'is_dark',  [$this, 'isColorDark'] ) );

        $twig->addFilter( new Twig\TwigFilter( 'assign', [$this, 'assign'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'intval', 'intval' ) );
        $twig->addFilter( new Twig\TwigFilter( 'placeholder', [$this, 'placeholder'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'has_block', [$this, 'hasBlock'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'first_block', [$this, 'getFirstBlock'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'get_blocks', [$this, 'getBlocks'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'lottie_placeholder', [$this, 'generateLottiePlaceholder'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'handle', 'sanitize_title' ) );
        $twig->addFilter( new Twig\TwigFilter( 'table', [$this, 'generateTable'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'picture', [$this, 'generatePicture'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'crop', [$this, 'cropImage'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'figure', [$this, 'generateFigure'] ) );
        $twig->addFilter( new Twig\TwigFilter( 't', [$this,'translate'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'ucfirst', 'ucfirst' ) );
        $twig->addFilter( new Twig\TwigFilter( 'encrypt', [$this,'encrypt'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'protect', [$this,'protectEmail'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'encode', [$this,'encode'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'bind', [$this,'bind'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'nl2p', [$this,'lineBreakToP'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'nl2span', [$this,'lineBreakToSpan'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'space2span', [$this,'spaceToSpan'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'parse_url', [$this,'parseUrl'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'phone', [$this,'formatPhone'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'youtube_id', [$this, 'youtubeId'] ) );
        $twig->addFilter( new Twig\TwigFilter( 'vimeo_id', [$this, 'vimeoID'] ) );

        return $twig;
    }
}
