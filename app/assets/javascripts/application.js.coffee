#= require jquery
#= require jquery_ujs
#= require jquery-ui/selectable

# check box drawing

down = false
value = false

$('.available_at').find(".check_box label").mousedown((event) ->
  event.preventDefault()
  down = true
  $input = $('#' + $(this).attr("for"))
  value = not $input.attr("checked")
  $input.attr "checked", value
).mouseover((event) ->
  event.preventDefault()
  $input = $('#' + $(this).attr("for"))
  if down
    $input.attr "checked", value
).change(->
  event.preventDefault()
).click ->
  event.preventDefault()

$(document).mouseup ->
  down = false
