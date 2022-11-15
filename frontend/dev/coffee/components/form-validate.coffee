
app.form =

	init: ->
		$(app.form.classes.container).each ->

			app.form.assign $(this)

	classes:
		container: ".form"
		item:      ".form__element"
		inputs:    "input,select,textarea"

	assign: (form,callback) ->

		# FOCUS

		form.find(app.form.classes.inputs).on "blur", ->
			app.form.validate( $(this).closest(app.form.classes.item))


		# SUBMIT

		#if form.is("form")


			#form.on "submit", (e) ->

				#e.preventDefault()

				#if app.form.validateGroup(form)

					#if form.is(".form--ajax")

						#$.ajax
							#type: "POST"
							#url:  form.attr("action")
							#data: form.serialize()
							#success: ->
								#callback() if callback

		#else
			#form.find(".form__submit button").click ->

				#if app.form.validateGroup(form)
					#callback() if callback
				#return true



	validateGroup: (container) ->

		pass = true

		container.find(app.form.classes.item).each ->
			if !app.form.validate( $(this) )
				pass = false
			return true

		return pass


	validate: (el) ->

		input = el.find(app.form.classes.inputs)

		pass  = true

		if !input.val()
			pass = false

		#if input.val().length < 2
		#	pass = false

		if input.attr("type")=='email' && !( /\S+@\S+\.\S+/.test(input.val()) )
			
			pass = false


		# Validar RUT
		if input.attr("type")=='rut'
			rut = input.val()
			if app.form.validaRut(rut) == true
				rut_nuevo = app.form.formateaRut(rut)
				$(".input-rut").val(rut_nuevo)
			else
				$(".input-rut").val("")
				pass = false


		if !pass
			el.addClass(app.form.classes.item.replace(".","")+"--error")

		else
			el.removeClass(app.form.classes.item.replace(".","")+"--error")

		return pass

	validaRut: (rut) ->
		T = rut.replace(/[^0-9kK]+/g, "").slice(0,-1)
		P = parseInt(T)
		M = 0
		S = 1
		while T
			S = (S + T % 10 * (9 - (M++ % 6))) % 11
			T = Math.floor(T / 10)
		if S
			V = S - 1
		else
			V = 'K'

		if (V=="K" && rut.slice(-1).toUpperCase()==V) || (V!="K" && parseInt(rut.slice(-1))==V)
			#if !company
			return true
			#else
			#	if P ==x
		else
			return false


	formateaRut: (rut) ->
		actual = rut.replace(/^0+/, '')
		if actual != '' and actual.length > 1
			sinPuntos = actual.replace(/\./g, '')
			actualLimpio = sinPuntos.replace(/-/g, '')
			inicio = actualLimpio.substring(0, actualLimpio.length - 1)
			rutPuntos = ''
			i = 0
			j = 1
			i = inicio.length - 1
			while i >= 0
				letra = inicio.charAt(i)
				rutPuntos = letra + rutPuntos
				if j % 3 == 0 and j <= inicio.length - 1
					rutPuntos = '.' + rutPuntos
				j++
				i--
			dv = actualLimpio.substring(actualLimpio.length - 1)
			rutPuntos = rutPuntos + '-' + dv
		rutPuntos			


