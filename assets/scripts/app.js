/**
 * Application
 *
 * Copyright (c) 2024 - Metabolism
 *
 * License: GPL
 * Version: 2
 *
 * Requires:
 *   - VueJS3
 *
 **/

'use strict';

import 'regenerator-runtime/runtime'

// load browser detection
import Bowser from "bowser";
const browser = Bowser.getParser(window.navigator.userAgent);

// load Vuejs
import { createApp } from 'vue'

const app = createApp({
    delimiters: ['[[', ']]'],
    data(){
        return{
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
            }
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

            this.heights.footer = this.$refs.footer ? this.$refs.footer.clientHeight : 0;
            this.heights.header = this.$refs.header.clientHeight;
        },
        handleHash(){

        },
        addBrowserClasses(){

            if( !browser.satisfies({"internet explorer": ">11", safari: '>=13', chrome: ">=85", firefox: ">=83", edge: ">=84"}) ){

                document.body.classList.add('unsupported-browser')
            }
            else{

                document.body.classList.add(browser.getPlatformType(true))
                document.body.classList.add(browser.getOSName(true))
            }
        }
    },
    mounted(){

        document.documentElement.style.setProperty('--app-init-height', `${window.innerHeight}px`);

        this.catchScroll(false);
        this.catchResize();
        this.handleHash();

        document.body.classList.remove('loading');
        document.body.classList.add('loaded');
    },
    created() {

        this.addBrowserClasses();

        window.addEventListener('scroll', this.catchScroll);
        window.addEventListener('resize', this.catchResize);
        window.addEventListener('hashchange', this.handleHash);
    }
});

// load components
import {email, youtube} from './components'
app.component('email', email);
app.component('youtube', youtube);

// load directives
import {split} from './directives'
app.directive('split', split);

// register Swiper custom elements
import { register } from 'swiper/element/bundle';
register();

// load blocks
let blocks = require.context("../../templates", true, /^\.\/[^.]+\.js$/);
blocks.keys().forEach(fileName => {

    const blockConfig = blocks(fileName)
    const blockName = blockConfig.default.name || fileName.split('/').pop().replace(/\.\w+$/, '')

    //create global block
    app.component(blockName, blockConfig.default || blockConfig)
});

// load plugins
import VueAOS from './plugins/aos';
app.use(VueAOS);

// start app
app.mount('#root')

export default app
