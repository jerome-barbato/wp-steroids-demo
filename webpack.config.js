const Encore = require('@symfony/webpack-encore');
const webpack = require('webpack');

const globSassImporter = require('node-sass-glob-importer');
const path = require('path');

// Manually configure the runtime environment if not already configured yet by the "encore" command.
// It's useful when you use tools that rely on webpack.config.js file.
if (!Encore.isRuntimeEnvironmentConfigured())
    Encore.configureRuntimeEnvironment(process.env.NODE_ENV || 'dev');

Encore
    // directory where compiled assets will be stored
    .setOutputPath('public/build/')
    // public path used by the web server to access the output path
    .setPublicPath('/build')
    // only needed for CDN's or sub-directory deploy
    //.setManifestKeyPrefix('build/')

    /*
     * ENTRY CONFIG
     *
     * Each entry will result in one JavaScript file (e.g. app.js)
     * and one CSS file (e.g. app.css) if your JavaScript imports CSS.
     */
    .addEntry('bundle', './assets/index.js')

    // When enabled, Webpack "splits" your files into smaller pieces for greater optimization.
    //.splitEntryChunks()

    // will require an extra script tag for runtime.js
    // but, you probably want this, unless you're building a single-page app
    .disableSingleRuntimeChunk()

    /*
     * FEATURE CONFIG
     *
     * Enable & configure other features below. For a full
     * list of features, see:
     * https://symfony.com/doc/current/frontend.html#adding-more-features
     */
    .cleanupOutputBeforeBuild()
    //.enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    // enables hashed filenames (e.g. app.abc123.css)
    .enableVersioning(Encore.isProduction())

    .configureDevServerOptions(options => {
        options.allowedHosts = 'all';
        options.client = {
            logging : 'warn',
            overlay: false
        };
    })

    // enables Sass/SCSS support
    .enableSassLoader((options) => {
        options.sassOptions = {
            importer: globSassImporter(),
            includePaths: [path.resolve(process.cwd(), '')]
        };
    }, {})

    .addPlugin(new webpack.DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: !Encore.isProduction(),
        __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: !Encore.isProduction()
    }))

    .enablePostCssLoader()

    .configureImageRule({
        // tell Webpack it should consider inlining
        type: 'asset',
        maxSize: 4 * 1024, // 4 kb - the default is 8kb
    })

    .copyFiles({
        from: './assets/media/images',

        // optional target path, relative to the output dir
        to: 'images/[path][name].[ext]',

        // if versioning is enabled, add the file hash too
        //to: 'images/[path][name].[hash:8].[ext]',

        // only copy files matching this pattern
        //pattern: /\.(png|jpg|jpeg)$/
    })

    .configureFontRule({
        type: 'asset',
        maxSize: 4 * 1024
    })

    // uncomment if you use TypeScript
    //.enableTypeScriptLoader()

    // uncomment to get integrity="..." attributes on your script & link tags
    // requires WebpackEncoreBundle 1.4 or higher
    //.enableIntegrityHashes(Encore.isProduction())
;

let config = Encore.getWebpackConfig();
config.resolve.alias["vue"] = 'vue/dist/vue.esm-bundler';

module.exports = config;
