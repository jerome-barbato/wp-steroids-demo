const email = {
	props:['name','domain','mailto','text'],
	template:`<a :href="'mailto:'+name+'@'+domain"><span>{{text?text:name+'@'+domain}}</span></a>`
}

const youtube = {
	props:['id','cover','alt'],
	template:`<a class="c-youtube">
		<img v-if="cover" class="c-youtube__cover" :src="cover" :alt="alt" loading="lazy" width="1280" height="720"/>
		<img v-else class="c-youtube__cover c-youtube__cover--hosted" :src="'//img.youtube.com/vi/'+id+'/maxresdefault.jpg'" :alt="alt" loading="lazy" width="1280" height="720"/>
		<iframe v-if="loaded" class="c-youtube__iframe" :src="'//www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&showinfo=0&modestbranding=1&playsinline=1&mute=1'" allow="encrypted-media; autoplay;" allowfullscreen></iframe>
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

		const $img = this.$el.querySelector('.c-youtube__cover--hosted');

		$img.addEventListener("load", function() {
			if( $img.naturalHeight <= 90 )
				$img.src = '//img.youtube.com/vi/'+this.id+'/hqdefault.jpg'
		})
	}
}

export {email, youtube}
