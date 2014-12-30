# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addSquat = (squat) ->
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
)