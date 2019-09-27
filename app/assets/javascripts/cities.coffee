# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_city_icon = (city) ->
  L.divIcon({
    className: "city-icon",
    html: "<div class='outer-city-icon-div outer-city-icon-#{city.label_position}'>
             <img src='#{ map.default_icon_url }'>
             <br>
             <span class='city-icon-name city-icon-#{city.label_position}'>
               #{ city.name }
             </span>
           </div>",
    iconSize: [60, 50],
    iconAnchor: [30, 40]
  })

addCity = (city) ->
  m = L.marker city.latlng
  m.on "click", (e) ->
    document.location.href = city.url
  m.setIcon get_city_icon(city)
  m.addTo map

$(->
  cities_url = $("#map").data("cities-url")
  if cities_url
    $.ajax(cities_url).done((cities)->
      addCity city for city in cities
    )
)
