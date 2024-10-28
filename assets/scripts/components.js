const email = {
	props:['name','domain','mailto','text'],
	template:'<a :href="\'mailto:\'+name+\'@\'+domain"><span>{{text?text:name+\'@\'+domain}}</span></a>'
}

export {email}
