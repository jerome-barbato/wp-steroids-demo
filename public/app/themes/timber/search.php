<?php
/**
 * Search results page
 *
 * Methods for TimberHelper can be found in the /lib sub-directory
 *
 * @package  WordPress
 * @subpackage  Timber
 * @since   Timber 0.1
 */

use Timber\Timber;

$templates = array( 'search.twig', 'archive.twig', 'index.twig' );

$context                 = Timber::context();
$context['title']        = 'Search results for ' . get_search_query();
$context['search_query'] = get_search_query();
$context['search_count'] = 0;

$sorted_posts = [];

foreach ($context['posts'] as $post){

    $sorted_posts[$post->post_type][] = $post;
    $context['search_count']++;
}

$context['posts'] = $sorted_posts;

Timber::render( $templates, $context );
