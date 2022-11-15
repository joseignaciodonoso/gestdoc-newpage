
app.forms =
	init: ->


		$("form").each ->

			form = $(this)

			# Autocomplete off fix

			form.find("[autocomplete='off']").each ->
				input = $(this)
				setTimeout ->
					input.val("")
					input.closest(".form__element").removeClass("form__element--filled")
				,400


			form.find("input,select,textarea").on "focus", ->
				$(this).closest(".form__element").addClass("form__element--focused")

			form.find("input,select,textarea").on "blur", ->

				formEl = $(this).closest(".form__element")

				formEl.removeClass("form__element--focused")

				if $(this).val()
					formEl.addClass("form__element--filled")
				else
					formEl.removeClass("form__element--filled")


			# Checkbox condition

			ck = form.find("input[type='checkbox'][data-show]")

			if ck.length
				app.forms.checkboxCondition(ck)
				ck.change ->
					app.forms.checkboxCondition(ck)


		app.forms.prettySelect.init()


	checkboxCondition: (chkbx) ->

		clss = chkbx.attr("data-show")

		if chkbx.is(":checked")
			$(clss).show()
		else
			$(clss).hide()

	prettySelect:

		init: ->
			this.create()
			this.events()

		create: ->

			$(".form__select").each ->

				options = []

				$(this).find("select option").each ->
					if $(this).val() && $(this).text()
						options.push "<div class='form__select__option' value='"+$(this).val()+"'>"+$(this).text()+"</div>"

				html_value   = "<div class='form__select__value'></div>"
				html_options = "<div class='form__select__options'>"+options.join("")+"</div>"
				html_icon    = "<div class='form__select__icon'><span class='fa fa-angle-down'></span></div>"

				$(this).append html_value + html_options + html_icon

				if $(".form--filterinvestors").attr("data-filter")
					console.log "entro a la condicion"
					
					$(".form__select__option").each ->
						console.log "entro al each"
						datafilter = $(".form--filterinvestors").attr("data-filter")
						console.log datafilter
						console.log $(this).text()
						if $(this).text() == datafilter
							$(this).addClass("selected")
							$(".form__select__value").text(datafilter)


		events: ->

			$(document).on "click", (e) ->
				app.forms.prettySelect.blur()

			$(".form__select").click (e) ->
				e.stopPropagation()
				app.forms.prettySelect.blur()
				app.forms.prettySelect.focus $(this)

			$(".form__select__option").click (e) ->
				e.stopPropagation()

				$(this).siblings().removeClass("selected")
				$(this).addClass("selected")

				formSelect = $(this).closest(".form__select")
				formSelect.find("select").val $(this).attr("value")
				formSelect.find(".form__select__value").html $(this).text()

				app.forms.prettySelect.blur()

			$('.form--filterinvestors .form__select__option').on 'click', ->
				
				valor = $(this).text()

				if valor == "Todas"

					url = $('.form--filterinvestors').data('url')

					urlfinal = url + "?filter=" + "all"

					if $(this).parents(".form--filterinvestors").attr("data-type") == "event"
						urlfinal = urlfinal + "&type=event"
						window.location.href = urlfinal
					else	

						window.location.href = urlfinal

				else

					console.log  $(this).parents(".form--filterinvestors").attr("data-type") 

					url = $('.form--filterinvestors').data('url')

					urlfinal = url + "?filter=" + valor

					if $(this).parents(".form--filterinvestors").attr("data-type") == "event"
						urlfinal = urlfinal + "&type=event"
						window.location.href = urlfinal

					else	
						window.location.href = urlfinal


		focus: (el) ->
			el.addClass("opened")
			el.closest(".form__element").addClass("form__element--focused")


		blur: () ->

			$(".form__select").each ->

				$(this)
					.removeClass("opened")
					.closest(".form__element")
					.removeClass("form__element--focused")

				if $(this).find("select").val()
					$(this)
						.closest(".form__element")
						.addClass("form__element--filled")	

				

