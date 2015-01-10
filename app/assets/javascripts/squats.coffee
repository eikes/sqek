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
    m.bindPopup squat.popup
    m.on "click", (e) ->
      document.location.hash = squat.slug
    m.addTo map
    squat.marker = m

$(->
  squats_url = $("#map").data("squats-url")
  if squats_url
    $.ajax(squats_url).success((squats)->
      window.squats = squats
      addSquat squat for squat in squats
    )

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
  
  )