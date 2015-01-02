
$(->

  map_div  = document.getElementById("map")
  map_data = $(map_div).data()
  mode     = map_data.mode

  map = L.map(map_div)

  tiles = L.tileLayer('http://{s}.tiles.mapbox.com/v3/eikes.he4660k4/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
  })

  tiles.addTo map

  map.setView(map_data.latlng || [0,0], map_data.zoom)

  marker = null

  lat_input = $('[name*=lat]')
  lng_input = $('[name*=lng]')

  add_marker = (latlng) ->
    if latlng
      marker = L.marker(latlng)
      marker.addTo map

  update_marker = (latlng) ->
    if not marker
      add_marker latlng
    else
      marker.setLatLng latlng
    lat_input.val latlng.lat
    lng_input.val latlng.lng

  if mode == "edit" and lat_input.val() and lng_input.val()
    add_marker [lat_input.val(), lng_input.val()]

  if mode == "edit" or mode == "create"
    map.on("click", (e) ->
      update_marker e.latlng
    )

  window.map = map
  window.add_marker = add_marker
  window.update_marker = update_marker

)