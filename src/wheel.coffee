module.exports = ->
  console.log 'WHEEL'

  window.agarZoom = 1

  unit_wheel = {}
  unit_wheel[WheelEvent.DOM_DELTA_PIXEL] = 100
  unit_wheel[WheelEvent.DOM_DELTA_LINE] = 3
  unit_wheel[WheelEvent.DOM_DELTA_PAGE] = 3

  window.addEventListener 'wheel', (event) ->
    speed = 0.1
    amount = event.deltaY/unit_wheel[event.deltaMode]*speed
    window.agarZoom = Math.min(Math.max(window.agarZoom + amount, 1), 2.5)
