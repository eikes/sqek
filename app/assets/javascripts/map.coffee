
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

  map.setView(map_data.latlng, map_data.zoom)

  window.map = map

  marker = null

  lat_input = $('[name*=lat]')
  lng_input = $('[name*=lng]')

  add_marker = (ll) ->
    marker = L.marker(ll)
    marker.addTo map

  if mode == "edit"
    add_marker [lat_input.val(), lng_input.val()]

  if mode == "edit" or mode == "create"
    map.on("click", (e) ->

      ll = e.latlng

      if not marker
        add_marker ll
      else
        marker.setLatLng ll

      lat_input.val ll.lat
      lng_input.val ll.lng
    )

)