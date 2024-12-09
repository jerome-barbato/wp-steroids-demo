import { defineConfig } from 'vite'
import sassGlobImports from 'vite-plugin-sass-glob-import';

// https://vite.dev/config/
export default defineConfig(({ command }) =>{
  return{
    plugins: [
      sassGlobImports(),
      {
        name: 'twig',
        handleHotUpdate({ file, server }) {
          if (file.endsWith('.twig')) {
            server.ws.send({ type: 'full-reload' });
          }
        },
      },
    ],
    resolve: {
      alias:{
        vue: 'vue/dist/vue.esm-bundler.js'
      }
    },
    define: {
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: command!=='build',
      __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: command!=='build'
    },
    base: '/build',
    css: {
      devSourcemap: true,
    },
    server:{
      host: 'localhost',
      strictPort: true,
      port: 8080
    },
    build: {
      target: 'esnext',
      manifest: true,
      copyPublicDir: false,
      assetsDir: '',
      outDir: './public/build',
      emptyOutDir: true,
      rollupOptions: {
        input: {
          script: './assets/scripts/app.js',
          style: './assets/styles/app.scss'
        }
      }
    }
  }
})
