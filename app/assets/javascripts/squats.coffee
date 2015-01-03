# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addSquat = (squat) ->
  if squat.latlng
    m = L.marker squat.latlng
    m.bindPopup squat.name.link(squat.url)
    m.on "mouseover", (e) ->
      this.openPopup()
    m.addTo map

$(->
  squats_url = $("#map").data("squats-url")
  if squats_url
    $.ajax(squats_url).success((squats)->
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
)