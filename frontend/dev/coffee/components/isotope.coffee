app.isotope =
  init: ->
    # external js: isotope.pkgd.js
    # store filter for each group
    buttonFilters = {}
    buttonFilter = undefined
    # quick search regex
    qsRegex = undefined
    # init Isotope
    $grid = $('.grid').isotope(
      itemSelector: '.col-xs-6'
      layoutMode: 'masonry'
      filter: ->
        $this = $(this)
        searchResult = if qsRegex then $this.text().match(qsRegex) else true
        buttonResult = if buttonFilter then $this.is(buttonFilter) else true
        searchResult and buttonResult
    )
    # flatten object by concatting values

    concatValues = (obj) ->
      value = ''
      for prop of obj
        value += obj[prop]
      value

    # debounce so filtering doesn't happen every millisecond

    debounce = (fn, threshold) ->
      timeout = undefined
      threshold = threshold or 100
      ->

        delayed = ->
          fn.apply _this, args
          return

        clearTimeout timeout
        args = arguments
        _this = this
        timeout = setTimeout(delayed, threshold)
        return

    $('.filters-select').change ->
      $this = $(this)
      # get group key
      $buttonGroup = $this.parents('.button-group')
      filterGroup = $buttonGroup.attr('data-filter-group')
      # set filter for group
      buttonFilters[filterGroup] = $this.val()
      # combine filters
      buttonFilter = concatValues(buttonFilters)
      # Isotope arrange
      $grid.isotope()
      app.scroll.dscroll 
      return

    $('.section__filters').on 'click', '.section__filter', ->
      $this = $(this)
      $buttonGroup = $this.parents('.button-group')
      filterGroup = $buttonGroup.attr('data-filter-group')
      buttonFilters[filterGroup] = $this.attr('data-filter')
      buttonFilter = concatValues(buttonFilters)
      $grid.isotope()
      app.scroll.dscroll
      $(this).parents(".section__filters").find(".current").removeClass("current")
      $(this).addClass("current")
      return  


    # use value of search field to filter
    $quicksearch = $('.quicksearch').keyup(debounce(->
      qsRegex = new RegExp($quicksearch.val(), 'gi')
      $grid.isotope()
      return
    ))


    # change is-checked class on buttons
    $('.button-group').each (i, buttonGroup) ->
      $buttonGroup = $(buttonGroup)
      $buttonGroup.on 'click', 'button', ->
        $buttonGroup.find('.is-checked').removeClass 'is-checked'
        $(this).addClass 'is-checked'
        return
      return

