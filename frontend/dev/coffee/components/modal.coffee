
app.modal =
	init: ->
		$("[data-modal-login]").click (e) ->
			e.preventDefault()
			app.modal.open(".modal--login")

		$("[data-modal-docs]").click (e) ->
			console.log "open modal docs"
			e.preventDefault()
			app.modal.open(".modal--docs")

		$("[data-modal-plan]").click (e) ->
			console.log "open modal docs"
			e.preventDefault()
			app.modal.open(".modal--plan")


		$(".modal__close").click ->
			app.modal.close $(this).closest(".modal")
			$(".modal--docs .modal__front").removeClass("modal__front--openinfo")


	open: (elementclass) ->
		$(elementclass).addClass("modal--in")
			

	close: (modal=false) ->

		modal = $(".modal") if !modal

		modal
			.removeClass("modal--in")
			.addClass("modal--out")

		setTimeout ->
			modal.removeClass("modal--out")
		,200

