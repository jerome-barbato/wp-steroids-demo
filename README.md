## Overview

Bedrock is a modern WordPress stack that helps you get started with the best development tools and project structure.

This is a modified version using [Timber](https://fr.wordpress.org/plugins/timber-library/), [WP Steroid](https://github.com/wearemetabolism/wp-steroids). 

This project is designed to bootstrap a custom-made website without using a theme, utilizing custom fields with [ACF](https://www.advancedcustomfields.com) or [Carbon Fields](https://carbonfields.net) instead.

![](.demo/screenshot.png)

![](.demo/code.png)

## Features

- Better folder structure
- YML configuration
- Permalink configuration for custom post types and taxonomies
- Maintenance mode
- Backup download in dev mode
- Build hook
- Disabled automatic updates
- Enhanced security
- Better GUID using RFC 4122 compliant UUID version 5
- Multisite images sync (for multisite as multilingual)
- SVG support
- Better performance
- Radio type for taxonomies
- Multisite post deep copy (with multisite-language-switcher plugin)
- Custom datatable support with view and delete actions in admin
- Google Translate or DeepL integration
- Optimizations
- Dependency management with [Composer](https://getcomposer.org)
- Easy WordPress configuration with environment specific files
- Environment variables with [Dotenv](https://github.com/vlucas/phpdotenv)
- Enhanced security (separated web root and secure passwords with [wp-password-bcrypt](https://github.com/roots/wp-password-bcrypt))

### The YML file allows you to configure:

- Image options
- Maintenance support
- Admin pages removal
- WYSIWYG MCE editor
- Feature support
- Multisite configuration
- ACF configuration
- Menu
- Custom post types
- Custom taxonomies
- Blocks
- Page, post, and taxonomy templates
- Page state
- Post format
- External table viewer
- Advanced roles

## Server requirements

- PHP >= 8.1 with GD ( jpeg, webp ), pdo_mysql, mysqli
- Curl, Git, Zip, Composer 2
- Node 18
- Mysql >= 5.7 or Maria DB >= 10.4
- Nginx or Apache with mod_rewrite module

## Fresh install

1. Install vendor
   ```sh
   $ composer install
   ```

2. Update environment variables in the `.env` file. Wrap values that may contain non-alphanumeric characters with quotes, or they may be incorrectly parsed.

- Database variables
    - `DB_NAME` - Database name
    - `DB_USER` - Database user
    - `DB_PASSWORD` - Database password
    - `DB_HOST` - Database host
    - Optionally, you can define `DATABASE_URL` for using a DSN instead of using the variables above (e.g. `mysql://user:password@127.0.0.1:3306/db_name`)
- `WP_ENV` - Set to environment (`development`, `staging`, `production`)
- `WP_HOME` - Full URL to WordPress home (http://wordpress.io)
- `AUTH_KEY`, `SECURE_AUTH_KEY`, `LOGGED_IN_KEY`, `NONCE_KEY`, `AUTH_SALT`, `SECURE_AUTH_SALT`, `LOGGED_IN_SALT`, `NONCE_SALT`
    - Generate with [WordPress salts generator](https://roots.io/salts.html)

3. Build sources
   ```sh
   $ npm install && npm run build
   ```

4. Set the document root on your webserver to `public` folder: `/path/to/site/public/`

5. Allow 'write' permissions to `/path/to/site/var/` and `/path/to/site/public/app/uploads`

6. Go to the `WP_HOME` url and install WordPress

7. Remove `.demo` folder

## Install using demo file

1. Do a `Fresh install`, from step 1 to 5

2. Import `.demo/database.sql` file in your database ( demo url in sql file is http://wordpress.io, admin login : demo/demo ) or install WordPress

If you need to change the url, perform a search & replace in the demo.sql, and execute in bash `php bin/fix-serialisation .demo/database.sql`

3. Remove `.demo` folder

## Development

1. Edit `/config/app.yml` to edit WordPress configuration ( custom post type, custom taxonomy and so much more )
1. Edit twig files in `/templates`
2. Add specific site functions in `/src/Site.php`
3. Edit page context in `/src/Controller`
4. Run dev server do rebuild sources
   ```sh
   $ npm run dev-server
   ```

## Using Carbon fields

Edit composer.json, replace `"wpackagist-plugin/advanced-custom-fields": "^6.3.6"` with `"htmlburger/carbon-fields": "^3.6"`

You can also add `"metabolism/carbon-fields-urlpicker": "^3.0"` to add an url picker field

## Using ACF PRO

ACF PRO can be installed using Composer, similar to how the free plugin can be installed using WordPress Packagist.

Please read the [documentation](https://www.advancedcustomfields.com/resources/installing-acf-pro-with-composer/) on ACF Website

## Docker

Project is shipped with Docker files samples.

Feel free to update WP_HOME and WP_SITEURL in `docker-compose.yml` and server_name in `.docker/nginx/default.conf`

Run the project using 

```sh
 docker-compose build
 docker-compose up -d
```

Access WordPress admin at `http://localhost:8000`

### Useful Docker commands ( use with caution )

**Stop containers**
```sh
docker-compose down
```

**Remove all stopped containers**
```sh
docker system prune -a
```

**Remove orphaned volumes**
```sh
docker volume rm $(docker volume ls -q)
```