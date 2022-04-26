import $ from "jquery"
import jte from "jquery-touch-events"
jte($)

const $schedule = $('.schedule')
const scheduleId = $schedule.data('id')
const $items = $('td', $schedule)
const nitems = 336

let down = false
let value = false
let first = null
let last = null

function setHash(value) {
  if (history.replaceState) {
    history.replaceState(null, null, value)
  }
  else {
    location.hash = value
  }
  const storage = {}
  storage[scheduleId] = value
  localStorage['internetFriendsYay'] = JSON.stringify(storage)
}

function throttle(delay, func) {
  let prev = 0
  return (...args) => {
    let now = new Date().getTime()
    if(now - prev > delay) {
      prev = now
      return func(...args)
    }
  }
}

function setSpan() {
  let a = first
  let b = last

  $items.toggleClass('hl', false)

  if (a != null && b != null) {
    setHash(`#${a},${b}`)
    let bnext = (b + 1) % nitems
    for (let i = a; i != bnext; i = (i + 1) % nitems) {
      const $el = $(`td[data-index=${i}]`, $schedule)
      $el.toggleClass('hl', true)
    }
  } else {
    setHash('#')
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
    let touch = event.touches[0]
    let x = touch.pageX
    let y = touch.pageY

    $items.each(function(index, item) {
      let $item = $(item)
      let o = $item.offset()
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
  .change(function (event) {
    event.preventDefault()
  })
  .click(function (event) {
    event.preventDefault()
  })
  .on('tapstart', function(event) {
    handleDown(event)
  })
  .on('tapmove', throttle(20, function(event) {
    handleMove(event)
  }))
  .on('tapend', function(event) {
    event.preventDefault()
    handleUp(event)
  })

$(document).keyup(function(event) {
  if (event.key === 'Escape') {
    first = last = null
    setSpan()
  }
})

// on load, check URL hash and localStorage for saved highlight

if (scheduleId != undefined) {
  const locationRegexp = /^#(?<first>\d+),(?<last>\d+)$/

  let match

  if (match = window.location.hash.match(locationRegexp)) {
    first = parseInt(match.groups.first)
    last = parseInt(match.groups.last)
    setSpan()
  }

  let ls, lsHash, lsValue

  if (
    match =
    localStorage != undefined &&
    (ls = localStorage['internetFriendsYay']) &&
    (lsValue = JSON.parse(ls)) &&
    (lsHash = lsValue[scheduleId]) &&
    lsHash.match(locationRegexp)
  ) {
    first = parseInt(match.groups.first)
    last = parseInt(match.groups.last)
    setSpan()
  }
}
