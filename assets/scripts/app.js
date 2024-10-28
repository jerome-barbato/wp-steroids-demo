/**
 * Application
 *
 * Copyright (c) 2024 - Metabolism
 *
 * License: GPL
 * Version: 2
 *
 * Requires:
 *   - VueJS
 *
 **/

'use strict';

// load Vuejs
import Vue from 'vue';

const upperFirst = str => `${str.charAt(0).toUpperCase()}${str.slice(1)}`
import camelCase from 'just-camel-case';

import 'regenerator-runtime/runtime'

Vue.config.productionTip = false;

// load components
import {email} from './components'
Vue.component('email', email);

// load directives
import {youtube, anchor, link, table, split} from './directives'
Vue.directive('youtube', youtube);
Vue.directive('anchor', anchor);
Vue.directive('link', link);
Vue.directive('table', table);
Vue.directive('split', split);

// load filters
import {hash, formatNumber} from './filters'
Vue.filter('hash', hash);
Vue.filter('formatNumber', formatNumber);

import Plugins from './plugins'
Vue.use(Plugins);

import store from './store'

// load design system atoms, molecules, organisms
let blocks = require.context("../../templates", true, /^\.\/[^.]+\.js$/);
blocks.keys().forEach(fileName => {

    const blockConfig = blocks(fileName)
    const blockName = blockConfig.default.name || upperFirst(camelCase(fileName.split('/').pop().replace(/\.\w+$/, '')))

    //create global block
    Vue.component(blockName, blockConfig.default || blockConfig)
});

import VueResource from 'vue-resource';
Vue.use(VueResource);

import SsrCarousel from 'vue-ssr-carousel';
Vue.component('ssr-carousel', SsrCarousel);

import SlideUpDown from 'vue-slide-up-down'
Vue.component('slide-up-down', SlideUpDown)

import VueObserveVisibility from 'vue-observe-visibility'
Vue.use(VueObserveVisibility)

import Vue2TouchEvents from 'vue2-touch-events';
import eventBus from "./event-bus";
Vue.use(Vue2TouchEvents);

import VueAOS from './plugins/aos';
Vue.use(VueAOS);

Vue.http.interceptors.push((req, next) => {
    next((res) => {

        //if (res.status === xxx)

        return res
    })
})

// start app
let app = new Vue({
    store,
    el: '#root',
    delimiters: ['[[', ']]'],
    data(){
        return{
            isMobile: window.innerWidth<768,
            isTablet: window.innerWidth<=1024,
            popin: false,
            sticky: false,
            sticky_bottom: false,
            scroll: 0,
            scroll_timer: 0,
            scrolled: 0,
            scroll_down: false,
            heights: {
                footer: 0,
                header: 0
            },
        }
    },
    methods:{
        toggle(classname, e) {

            if( e ){

                e.target.classList.toggle('is-'+classname)
            }
            else{

                if( this.popin === classname)
                    this.popin = false;
                else
                    this.popin = classname;

                document.body.classList.toggle('has-'+classname)
            }
        },
        catchScroll(e) {

            clearTimeout(this.scroll_timer);

            if(!document.body.classList.contains('disable-hover'))
                document.body.classList.add('disable-hover')

            this.scroll_timer = setTimeout(function(){
                document.body.classList.remove('disable-hover')
            }, 200);

            let scroll = document.documentElement.scrollTop || document.body.scrollTop
            let sticky = scroll>150
            let scrolled = scroll>1000
            let timeout = false;

            if( scrolled && !this.scrolled )
                document.body.classList.add('has-seen-page')

            this.scrolled = scrolled;

            if( sticky && sticky !== this.sticky ){

                document.body.classList.add('has-scrolled')

                this.sticky = sticky;
            }

            if( !scroll ){

                if( timeout )
                    clearTimeout(timeout);
                timeout = setTimeout(function (){
                    document.body.classList.remove('has-seen-page')
                },300)

                document.body.classList.remove('has-scrolled')
                document.body.classList.remove('has-scrolled--down')
                document.body.classList.remove('has-scrolled--up')
                document.body.classList.remove('has-scrolled--changed')

                this.sticky = false;
            }

            if( sticky ){

                if( this.scroll > scroll ){

                    if( this.scroll_down === true ){

                        document.body.classList.add('has-scrolled--up')

                        if( document.body.classList.contains('has-scrolled--down') ){

                            document.body.classList.add('has-scrolled--changed')
                            document.body.classList.remove('has-scrolled--down')
                        }
                    }
                }
                else{

                    if( this.scroll_down === false ){

                        document.body.classList.add('has-scrolled--down')

                        if( document.body.classList.contains('has-scrolled--up') ){

                            document.body.classList.add('has-scrolled--changed')
                            document.body.classList.remove('has-scrolled--up')
                        }
                    }
                }

                this.scroll_down = scroll > this.scroll
            }

            if( document.documentElement.offsetHeight - window.innerHeight - scroll < this.heights.footer && document.body.offsetHeight > window.innerHeight )
            {
                if( !this.sticky_bottom ){

                    document.body.classList.add('has-scrolled--bottom')
                    this.sticky_bottom = true;
                }
            }
            else{

                if( this.sticky_bottom ){

                    document.body.classList.remove('has-scrolled--bottom')
                    this.sticky_bottom = false;
                }
            }

            this.scroll = scroll;
        },
        catchResize(){

            document.documentElement.style.setProperty('--app-height', `${window.innerHeight}px`);

            this.isMobile = window.innerWidth<768;
            this.isTablet = window.innerWidth<=1024;

            this.heights.footer = this.$refs.footer ? this.$refs.footer.clientHeight : 0;
            this.heights.header = this.$refs.header.clientHeight;
        },
        handleHash(){

        },
        emit(event, params){
            eventBus.$emit(event, params);
        }
    },
    mounted(){

        document.documentElement.style.setProperty('--app-init-height', `${window.innerHeight}px`);

        this.catchScroll(false);
        this.catchResize();
        this.handleHash();

        let body_classList = document.body.classList;
        body_classList.remove('loading');
        body_classList.add('loaded');

        let is_desktop = false

        if( typeof navigator.userAgentData == 'undefined' )
            is_desktop = navigator.userAgent.toLowerCase().indexOf("android") === -1 && navigator.userAgent.toLowerCase().indexOf("iphone") === -1
        else
            is_desktop = !navigator.userAgentData.mobile

        body_classList.add(is_desktop?'desktop':'mobile')
    },
    created() {

        window.addEventListener('scroll', this.catchScroll);
        window.addEventListener('resize', this.catchResize);
        window.addEventListener('hashchange', this.handleHash);

        eventBus.$on('popin', (html)=>{

            this.popin = html
        })
    }
});

export default app
