$(->
  # full map height
  resize_map = () ->
    height = $(window).height()
    height -= $('#header').outerHeight()
    height -= $('#footer').outerHeight()
    $('#map.full').height( height )
  resize_map()
  $(window).resize resize_map
  $('.navbar-collapse').on 'shown.bs.collapse hidden.bs.collapse', () ->
    resize_map()
)