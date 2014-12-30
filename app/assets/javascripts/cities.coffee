# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addCity = (city) ->
  m = L.marker city.latlng
  m.bindPopup city.name.link(city.url)
  m.on "mouseover", (e) ->
    this.openPopup()
  m.addTo map

$(->
  cities_url = $("#map").data("cities-url")
  if cities_url
    $.ajax(cities_url).success((cities)->
      addCity city for city in cities
    )
)