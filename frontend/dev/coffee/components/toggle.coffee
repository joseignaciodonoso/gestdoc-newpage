
app.toggle =
	init: ->

		$("[open-toggle-section]").click (e) ->
			$(this).parents(".section__body").siblings(".section__toggle").slideToggle()



