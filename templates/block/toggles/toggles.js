
export default {
    template:`<div class="c-toggles"><slot :update="update" :opened="opened"></slot></div>`,
    data(){
        return {
            opened: 1
        }
    },
    methods:{
        update(index){
            this.opened = index
        }
    }
}
