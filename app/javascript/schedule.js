require('jquery-touch-events')($)

$(function() {
  var down = false
  var value = false
  var $schedule = $('.schedule')
  var $items = $('td', $schedule)
  var first = null
  var last = null
  var nitems = 336

  function setSpan() {
    if (first != null && last != null) {
      if (first > last) {
        [a, b] = [last, first]
      } else {
        [a, b] = [first, last]
      }
      $items.css('background-color', '')
      var bnext = (b + 1) % nitems
      for (var i = a; i != bnext; i = (i + 1) % nitems) {
        $el = $(`td[data-index=${i}]`, $schedule)
        $el.css('background-color', 'gold')
      }
    }
  }

  function handleDown(event) {
    event.preventDefault()
    down = true
    value = true
    first = parseInt($(event.currentTarget).data('index'))
    last = first
    setSpan()
  }

  function handleMoveItem(item) {
    if (down) {
      last = parseInt($(item).data('index'))
      setSpan()
    }
  }

  function handleMove(event) {
    event.preventDefault()
    if ($.isTouchCapable()) {
      var touch = event.touches[0]
      var x = touch.pageX
      var y = touch.pageY

      $items.each(function(index, item) {
        var $item = $(item)
        var o = $item.offset()
        if (
          o.left <= x &&
          o.top <= y &&
          x <= (o.left + $item.outerWidth()) &&
          y <= (o.top + $item.outerHeight())
        ) {
          handleMoveItem(item)
          return
        }
      })

    } else {
      handleMoveItem(event.currentTarget)
    }
  }

  function handleUp(event) {
    event.preventDefault()
    down = false
    value = false
  }

  $items
    .change(function (event) { event.preventDefault() })
    .click(function (event) { event.preventDefault() })
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
