
app = []

#=include components/*.coffee

$(document).ready ->

	for component, properties of app		
		properties.init() if properties.init
		
	$('.yt-video:not(.played)').click ->
		console.log "video youtube"

		id = $(this).attr("data-id")
		$(this).addClass("played")


		options = [
			'rel=0'
			'controls=1'
			'showinfo=0'
			'autoplay=1'
			'autohide=1'
			'iv_load_policy=3'
		]

		url = 'https://www.youtube.com/embed/'+id+'?' + options.join('&')
		iframe = '<iframe width="420" height="315" src="'+url+'" frameborder="0" allowfullscreen id="yt'+id+'"></iframe>'

		$(this).append iframe