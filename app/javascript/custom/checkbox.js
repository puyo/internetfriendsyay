import $ from "jquery";
import jte from "jquery-touch-events";
jte($)

$(function() {
  let down = false
  let value = false
  const labels = $('.available_at .check_box label')

  function handleDown(event) {
    event.preventDefault()
    down = true
    const $input = $('#' + $(event.currentTarget).attr('for'))
    value = $input.attr('checked') === undefined
    $input.attr('checked', value).prop('checked', value)
  }

  function handleMoveLabel(label) {
    if (down) {
      const $input = $('#' + $(label).attr('for'))
      $input.attr('checked', value).prop('checked', value)
    }
  }

  function handleMove(event) {
    event.preventDefault()
    if ($.isTouchCapable()) {
      // Figure out what label we're moving over, because touch events don't
      // work conveniently, like mouseover.
      //
      // Possible future improvement: rapid finger movements can leave gaps.
      // Interpolate from previous (x,y) to catch everything in a line from
      // previous known touch event.

      const touch = event.touches[0]
      const x = touch.pageX
      const y = touch.pageY

      labels.each(function(index, label) {
        var $label = $(label)
        var o = $label.offset()
        if (
          o.left <= x &&
          o.top <= y &&
          x <= (o.left + $label.outerWidth()) &&
          y <= (o.top + $label.outerHeight())
        ) {
          handleMoveLabel(label)
          return
        }
      })

    } else {
      handleMoveLabel(event.currentTarget)
    }
  }

  function handleUp(event) {
    event.preventDefault()
    down = false
  }

  labels
    .change(function (event) { event.preventDefault() })
    .click(function (event) { event.preventDefault() })
    .each(function(index, label) {
      var $input = $('#' + $(this).attr('for'))
      value = $input.attr('checked') !== undefined
      $input.attr('checked', value).prop('checked', value)
    })
    .on('tapstart', function(event) {
      handleDown(event)
    })
    .on('tapmove', function(event) {
      handleMove(event)
    })
    .on('tapend', function(event) {
      handleUp(event)
    })
})
