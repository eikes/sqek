$(->
  # full map height
  resize = () ->
    height = $(window).height()
    height -= $('#header').outerHeight()
    height -= $('#footer').outerHeight()
    $('.full-height').height( height )
  resize()
  $(window).resize resize
  $('.navbar-collapse').on 'shown.bs.collapse hidden.bs.collapse', () ->
    resize()
)