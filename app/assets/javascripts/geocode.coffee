$(->
  $('#geocode').click (e) ->
    e.preventDefault()
    source = $(this).data("source")
    address = $(source).val().replace("\n", ", ")
    if city = $(this).data("city-name")
      address +=  ", " + city
    $.ajax({
      url: "http://nominatim.openstreetmap.org/search.php?format=json&q=" + address,
      dataType: "jsonp",
      jsonp: "json_callback"
    }).success (data) ->
      if data.length
        latlng = {lat: data[0].lat, lng: data[0].lon}
        update_marker latlng
        map.panTo latlng
)