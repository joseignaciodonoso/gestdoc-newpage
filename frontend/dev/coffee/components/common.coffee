
app.common =
	init: ->
		console.log "test js update 19/05/2022"

		$("[data-open-login]").click (e) ->
			$(".login").addClass("login--show")
			$(".login__front--login").addClass("login__front--show")
			$(".login").addClass("login--show--in")
			$("#sections").addClass("sections--left")
			$("header").addClass("header--left")

		$(".login .login__back").click ->	
			$(".login").addClass("login--show--out")
			$(".login").removeClass("login--show--in")
			$("#sections").removeClass("sections--left")
			$("header").removeClass("header--left")
			setTimeout ->
				$(".login").removeClass("login--show")
				$(".login__front").removeClass("login__front--show")
			,500

		$("[data-open-register]").click (e) ->
			$(".login").addClass("login--show")
			$(".login__front--register").addClass("login__front--show")
			$(".login").addClass("login--show--in")
			$("#sections").addClass("sections--left")
			$("header").addClass("header--left")

		$(".login .login__back").click ->	
			$(".login").addClass("login--show--out")
			$(".login").removeClass("login--show--in")
			$("#sections").removeClass("sections--left")
			$("header").removeClass("header--left")
			setTimeout ->
				$(".login").removeClass("login--show")
				$(".login__front").removeClass("login__front--show")
			,500

		$(".section__search__input input").focus ->
			$(".section__search__back").addClass("section__search__back--show")


		$(".section__search__back").click ->
			$(".section__search__back").addClass("section__search__back--out")
			$(".section__search__results").removeClass("section__search__results--show")
			$(".section__search").removeClass("section__search--openinfo")
			setTimeout ->
				$(".section__search__back").removeClass("section__search__back--out section__search__back--show")
			,500

		$(".clear-info-box").click ->
			$(".section__search").removeClass("section__search--openinfo")
			$(".modal--docs .modal__front").removeClass("modal__front--openinfo")
		


		$("[data-modal-login]").click (e) ->
			e.preventDefault()
			app.common.open(".modal--login")

		$(".modal__close").click ->
			app.common.close $(this).closest(".modal")
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
		