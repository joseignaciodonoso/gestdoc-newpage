

app.shares =

	init: ->

		if !app.isMobile()
			$(".share-whatsapp").parents(".section__social__logo").remove()


		$(".share").click (e) ->
			e.preventDefault()
			app.shares.go $(this)


	go: (element) ->

		share_url  = encodeURIComponent(element.attr("href")) if !share_url
		share_text = encodeURIComponent($("h1").text())
		share_text = encodeURIComponent(element.attr("data-text")) if element.attr("data-text")

		if element.is(".share-whatsapp")
			window.location.href = "whatsapp://send?text="+share_text+encodeURIComponent(" ")+share_url

		if !app.isMobile()

			if element.is(".share-facebook")
				app.shares.popup "https://www.facebook.com/sharer/sharer.php?u="+share_url, 500, 310

			if element.is(".share-twitter")
				app.shares.popup "https://twitter.com/intent/tweet?source=webclient&text="+share_text+"&url="+share_url, 500, 310

		else
			if element.is(".share-facebook")
				window.open "https://www.facebook.com/sharer/sharer.php?u="+share_url

			if element.is(".share-twitter")
				window.open "https://twitter.com/intent/tweet?source=webclient&text="+share_text+"&url="+share_url


	popup: (url, w, h) ->
		left = ( $(window).width() / 2 )  - (w / 2)
		top  = ( $(window).height() / 2 ) - (h / 2)
		return window.open(url, "Compartir", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left)

