export default {

    props: ['link'],

    template :
        `<button class="p-burger" @click="toggleVisibility">
          <span class="p-burger__link" v-if="link">{{ link }}</span>
          <span class="p-burger__icon"><i></i></span>
        </button>`
    ,

    methods:{

        toggleVisibility(){

            document.body.classList.toggle('burger-is-open');
        }
    }
}
