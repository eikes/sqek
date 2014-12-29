# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  if window.cities
    $.each window.cities, (index, city) ->
      L.marker(city.latlng).bindPopup(city.popup).addTo(map);
)