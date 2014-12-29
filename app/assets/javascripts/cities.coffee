# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  if window.cities
    for city in window.cities
      m = L.marker city.latlng
      m.bindPopup city.popup
      m.on "mouseover", (e) ->
        this.openPopup()
      m.addTo map
)