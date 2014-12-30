# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  if window.squats
    for squat in window.squats
      m = L.marker squat.latlng
      m.bindPopup squat.popup
      m.on "mouseover", (e) ->
        this.openPopup()
      m.addTo map
)