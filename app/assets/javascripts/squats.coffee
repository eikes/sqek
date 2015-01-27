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

openSquatFromHash = ->
  slug = document.location.hash.replace '#', ''
  for squat in squats when squat.slug == slug
    popup.setLatLng squat.latlng
    popup.setContent squat.popup
    popup.openOn map
    map.panTo squat.latlng

$(window).on "hashchange", openSquatFromHash

$(->
  squats_url = $("#map").data("squats-url")
  if squats_url
    $.ajax(squats_url).success (squats) ->
      window.squats = squats
      addSquat squat for squat in squats
      openSquatFromHash()

  $('#geocode').click (e) ->
    e.preventDefault()
    address = $('#squat_address').val().replace("\n", ", ") + ", " + $(this).data("city-name")
    $.ajax({
      url: "http://nominatim.openstreetmap.org/search.php?format=json&q=" + address,
      dataType: "jsonp",
      jsonp: "json_callback"
    }).success((data)->
    if data.length
      latlng = {lat: data[0].lat, lng: data[0].lon}
      update_marker latlng
      map.panTo latlng
    )

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

  showSquatsInYear = (year) ->
    $('#year').html(year)
    for squat in squats
      visible = false
      for period in squat.periods
        if year >= period.start_year and (year <= period.end_year or !period.end_year)
          visible = true
      if visible
        $(squat.marker._icon).show()
      else
        $(squat.marker._icon).hide()

  all_years = $('#year').text()
  showAllSquats = () ->
    $('#year').html(all_years)
    for squat in squats
      $(squat.marker._icon).show()

  $('#slider').slider({
    min: parseInt($('#slider').data("from")),
    max: parseInt($('#slider').data("to")),
    slide: ( event, ui ) ->
      $('#all_years').prop("checked", false)
      showSquatsInYear(ui.value)
  })

  $('#all_years').change( ->
    if $(this).is(":checked")
      showAllSquats()
    else
      year = $('#slider').slider("value")
      showSquatsInYear(year)
  )

  $('.dynamic_menu').click( (e) ->
    e.preventDefault()
    $($(this).attr("href")).toggle()
  )
)