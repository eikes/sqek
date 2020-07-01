
$(->
  # map setup
  map_div  = document.getElementById("map")
  return unless map_div
  map_data = $(map_div).data()
  mode     = map_data.mode

  map = L.map(map_div)

  tiles_url = 'https://api.mapbox.com/styles/v1/eikes/civnq3kny002j2joi3d16t0kn/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZWlrZXMiLCJhIjoiYTJRQ1JsMCJ9.M8P2KYfdrKAn0OnFRrhCiQ'
  attribution = "Map data &copy;<a href='http://openstreetmap.org'>OpenStreetMap</a> contributors,<a href='http://creativecommons.org/licenses/by-sa/2.0/'>CC-BY-SA</a>,Imagery © <a href='http://mapbox.com'>Mapbox</a>"

  tiles = L.tileLayer(tiles_url, { attribution: attribution, maxZoom: 18 })

  tiles.addTo map

  map.setView(map_data.latlng || [0,0], map_data.zoom)

  if map_data.bounds
    map.fitBounds map_data.bounds

  map.default_icon_url = map_data.icon

  map.default_icon = L.icon({
    iconUrl: map.default_icon_url,
    iconSize: [35, 30],
    iconAnchor: [17, 20]
  })

  marker = null

  lat_input = $('[name*=lat]')
  lng_input = $('[name*=lng]')

  add_marker = (latlng) ->
    if latlng
      marker = L.marker(latlng)
      marker.setIcon map.default_icon
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
