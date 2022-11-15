
app.modal =
	init: ->
        if $('span.words-alternate').length > 0
            $this = $('span.words-alternate')
            words = $this.attr('data-words')
            delay = if $this.attr('data-delay') then $this.attr('data-delay') else 4000
            arrayWords = words.split(',')
            console.log arrayWords
            i = 0
            setInterval (->
                $('span.words-alternate').fadeOut ->
                    $(this).html(arrayWords[i = (i + 1) % arrayWords.length]).fadeIn()
            ), delay

# ---
# generated by js2coffee 2.2.0