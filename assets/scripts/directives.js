import SplitType from 'split-type'
const split = {
	mounted(el, binding, vnode) {

		if( binding.value )
			binding.value.tagName = 'span'
		else
			binding.value = {tagName:'span'}

		const text = new SplitType(el,binding.value)
	}
};

export {split}
