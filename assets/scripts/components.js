const email = {
	props:['name','domain','mailto','text'],
	template:`<a :href="'mailto:'+name+'@'+domain"><span>{{text?text:name+'@'+domain}}</span></a>`
}

const youtube = {
	props:['id'],
	template:`<a class="c-youtube">
		<slot></slot>
		<iframe v-if="loaded" :src="'//www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&showinfo=0&modestbranding=1&playsinline=1&mute=1'" allow="encrypted-media; autoplay;" allowfullscreen></iframe>
	</a>`,
	data(){
		return{
			loaded: false
		}
	},
	methods:{
		load(){

			this.loaded = true
			this.$el.removeEventListener('click', this.load)
		}
	},
	mounted() {
		this.$el.addEventListener('click', this.load)
	}
}

export {email, youtube}
