$(document).ready ->

  $realInputField = $('#picture_picture')

  $('#upload-btn').click (evt) ->
    $realInputField.click()
    evt.preventDefault()

  $realInputField.change ->
    $('#file-display').val $(@).val().replace(/^.*[\\\/]/, '')
