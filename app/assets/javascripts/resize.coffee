$(->
  # full map height
  resize_map = () ->
    height = $(window).outerHeight()
    height -= $('#main-nav').outerHeight()
    height -= $('#footer').outerHeight()
    $('#map.full').height( height )
  resize_map()
  $(window).resize resize_map
  $('.navbar-collapse').on 'shown.bs.collapse hidden.bs.collapse', () ->
    resize_map()
)