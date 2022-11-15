

app.scroll =

	init: ->

		#if $(window).width()>=960
		app.scroll.dscroll(0)
		app.scroll.parallax(0)
		$(window).scroll ->
			scroll = $(window).scrollTop()
			app.scroll.dscroll(scroll)
			app.scroll.parallax(scroll)

		#else
		#	$(".dscroll").addClass("dscroll--in")

		# Go to
		$("[data-goto]").click (e) ->
			to = $( $(this).attr "data-goto" )
			app.scroll.goto to
			$("header").removeClass("header--nav-in")
			$("header").addClass("header--nav-out")
			setTimeout ->
				$("header").removeClass("header--nav-in header--nav-out")
			,200
			e.preventDefault()


	dscroll: (scroll=false) ->

		scroll = $(window).scrollTop() if !scroll

		# Mostrar en scroll

		if $(".dscroll").length
			element_top_prev  = 0
			element_top_delay = 0

			$(".dscroll:visible").each ->
				element = $(this)
				element_top = element.offset().top

				if scroll + $(window).height() > element_top
					element.addClass "dscroll--in"

					if element_top >= element_top_prev - 25 && element_top <= element_top_prev + 25
						element_top_delay++
						delay = element_top_delay*0.2
						element.css
							'-webkit-animation-delay': delay+"s"
							'animation-delay': delay+"s"
					else
						element_top_delay=0

					element_top_prev = element_top

				if scroll + $(window).height() <= element_top
					element.removeClass "dscroll--in"

	parallax: (scroll) ->

		if $("[parallax]").length

			$("[parallax]").each ->

				vals = $(this).attr("parallax").split(",")
				x    = parseFloat vals[0]
				y    = parseFloat vals[1]
				valX = scroll * x
				valY = scroll * y

				$(this).css
					"-webkit-transform": "translate("+valX+"px,"+valY+"px)"
					"-ms-transform": "translate("+valX+"px,"+valY+"px)"
					"transform": "translate("+valX+"px,"+valY+"px)"



	goto: (to,add=false,seconds=1000) ->
		#add = $("header").height() if !add
		add = 60 if !add
		top = to.offset().top - add
		$("body,html").animate
			scrollTop: top
		,seconds
