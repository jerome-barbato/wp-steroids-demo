
import { Vue3SlideUpDown } from "vue3-slide-up-down";

export default {
    props:{
        title:String,
        current:{
            type:Number,
            default:-1
        },
        opened:Number
    },
    components:{'slide-up-down':Vue3SlideUpDown},
    template:`<div class="c-dropdown">
      <a class="c-dropdown__toggle" :class="{'is-open':isOpen}" href="#" role="button" @click.prevent="toggle">{{ title }}</a>
      <slide-up-down :opacityClosed="1" v-model="isOpen"><div class="c-dropdown__content"><slot></slot></div></slide-up-down>
    </div>
    `,
    computed:{
        isOpen(){
            return (this.current === -1 && this.clicked) || (this.current >= 0 && this.current === this.opened)
        }
    },
    data(){
        return {
            clicked: false
        }
    },
    methods:{
        toggle() {
            this.clicked = !this.clicked
            this.$emit('toggle', this.current);
        }
    }
}
