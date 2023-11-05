
$(->
  # map setup
  map_div  = document.getElementById("map")
  return unless map_div
  map_data = $(map_div).data()
  mode     = map_data.mode

  window.map = map = L.map(map_div)

  sqek_theme = {
    earth: "#FBFBFB",
    glacier: "#FFFFFF",
    residential: "#F4F4F4",
    hospital: "#F6F6F6",
    cemetery: "#EFEFEF",
    school: "#F7F7F7",
    industrial: "#EFEFEF",
    wood: "#C5C5C5",
    grass: "#D5D5D5",
    park: "#D5D5D5",
    water: "#B7B7B7",
    sand: "#EBEBEB",
    buildings: "#EDEDED",
    highwayCasing: "#AEAEAE",
    majorRoadCasing: "#AEAEAE",
    mediumRoadCasing: "#AEAEAE",
    minorRoadCasing: "#CECECE",
    highway: "#CECECE",
    majorRoad: "#CECECE",
    mediumRoad: "#CECECE",
    minorRoad: "#DEDEDE",
    boundaries: "#9E9E9E",
    mask: "#DDDDDD",
    countryLabel: "#808080",
    cityLabel: "#6C6C6C",
    stateLabel: "#808080",
    neighbourhoodLabel: "#808080",
    landuseLabel: "#808080",
    waterLabel: "#808080",
    naturalLabel: "#6C6C6C",
    roadsLabel: "#888888",
    poisLabel: "#6C6C6C"
  }

  window.layer = layer = protomapsL.leafletLayer({
    url: 'https://api.protomaps.com/tiles/v2/{z}/{x}/{y}.pbf?key=82e0381c8a4109c7',
    paint_rules: protomapsL.paintRules(sqek_theme),
    label_rules: protomapsL.labelRules(sqek_theme)
  })

  # remove POIS and highway signs
  layer.label_rules.pop()
  layer.label_rules.pop()
  layer.addTo(map)

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
