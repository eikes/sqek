$(->
  $('#geocode').click (e) ->
    e.preventDefault()
    sources = $(this).data("sources")
    address = ($(source).val().replace("\n", ", ") for source in sources).join ", "

    $.ajax({
      url: "http://nominatim.openstreetmap.org/search.php?format=json&q=" + address,
      dataType: "jsonp",
      jsonp: "json_callback"
    }).success (data) ->
      if data.length
        $('#geocode-error').hide()
        latlng = {lat: data[0].lat, lng: data[0].lon}
        update_marker latlng
        map.panTo latlng
      else
        $('#geocode-error').show()
    .error (data) ->
      $('#geocode-error').show()
)