# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

icons = {}
getIcon = (icon_path) ->
  if !icons[icon_path]
    icons[icon_path] =
      L.icon({
        iconUrl: icon_path,
        iconSize: [35, 30],
        iconAnchor: [17, 20]
      })
  return icons[icon_path]

addSquat = (squat) ->
  if squat.latlng
    m = L.marker squat.latlng
    if (squat.icon)
      m.setIcon getIcon(squat.icon)
    m.on "click", (e) ->
      document.location.hash = squat.slug
    m.addTo map
    squat.marker = m

popup = L.popup()

opening_popup = false
hashchange = ->
  slug = document.location.hash.replace '#', ''
  if slug.length == 0
    map.closePopup()
  if slug.length > 0
    for squat in squats when squat.slug == slug
      popup.setLatLng squat.latlng
      popup.setContent squat.popup
      opening_popup = true
      popup.openOn map
      opening_popup = false
$(window).on "hashchange", hashchange

$(->
  map.on "popupclose", (e) ->
    if !opening_popup
      document.location.hash = ""

  squats_url = $("#map").data("squats-url")
  if squats_url
    $.ajax(squats_url).success (squats) ->
      window.squats = squats
      addSquat squat for squat in squats
      hashchange()

  $('#set-lat-lng').click (e) ->
    e.preventDefault()
    lat = parseFloat($('[name*=lat]').val().replace(",", "."))
    lng = parseFloat($('[name*=lng]').val().replace(",", "."))
    latlng = {lat: lat, lng: lng}
    if lat && lng
      update_marker latlng
      map.panTo latlng

  $(".show-diff").click (e) ->
    $(this).next("pre").toggle()

  filter_state = {
    year: undefined,
    tags: []
  }

  filter = ->
    for squat in squats
      visible = false
      # first show the squat if it was squatted in the given year
      if filter_state.year
        for period in squat.periods
          if filter_state.year >= period.start_year and (filter_state.year <= period.end_year or !period.end_year)
            visible = true
      else
        visible = true
      # secondly only show the squat if it matches any of the selected tags
      if visible and filter_state.tags.length > 0
        visible = false
        for tag in squat.tags
          if $.inArray(tag, filter_state.tags) != -1
            visible = true
      # hide or show the squat
      if visible
        $(squat.marker._icon).show()
      else
        $(squat.marker._icon).hide()


  showSquatsInYear = (year) ->
    $('#year').html(year)
    filter_state.year = year
    filter()

  all_years = $('#year').text()
  showAllSquats = () ->
    $('#year').html(all_years)
    filter_state.year = undefined
    filter()

  $('#slider').slider({
    min: parseInt($('#slider').data("from")),
    max: parseInt($('#slider').data("to")),
    slide: ( event, ui ) ->
      $('#all_years').prop("checked", false)
      showSquatsInYear(ui.value)
  })

  $('#all_years').change ->
    if $(this).is(":checked")
      showAllSquats()
    else
      year = $('#slider').slider("value")
      showSquatsInYear(year)

  $('.tag-filter input').change ->
    key = this.name
    if $(this).is(":checked")
      # add tag to filters
      filter_state.tags.push(key)
    else
      # remove tag from filters
      filter_state.tags = filter_state.tags.filter (tag) -> tag isnt key
    filter()

  $('.dynamic_menu').click (e) ->
    e.preventDefault()
    $('#sidebar').show()
    target = $(this).attr("href")
    $("#sidebar .sidebar-content").hide()
    $(target).show()
  $('#close_legend').click (e) ->
    $('#legend-label').click()
  $('#close_sidebar').click (e) ->
    $('#sidebar').hide()
  $('#legend-label').click (e) ->
    e.preventDefault()
    $('#legend').toggleClass('hidden')
    $(this).css("top", $('#legend').outerHeight() + $('#header').outerHeight())
  $('#filter-label').click (e) ->
    e.preventDefault()
    $('#footer').toggleClass('hidden')
    $(this).css("bottom", $('#footer').outerHeight())
    $(window).resize()

)