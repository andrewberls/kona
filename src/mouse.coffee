# An interface for tracking and interacting with the mouse

Kona.Mouse =

  # The x and y coordinates of the mouse, relative to the top left of the canvas
  # Access with `Kona.Mouse.x` and `Kona.Mouse.y`
  x: 0
  y: 0

  isDown: false

  # Internal
  onMouseMove: (e) ->
    e ?= window.event # TODO: test this
    canvas = Kona.Canvas.elem
    @x = e.clientX - canvas.offsetLeft
    @y = e.clientY - canvas.offsetTop

  # Internal
  onMouseDown: (e) -> @isDown = true

  # Internal
  onMouseUp: (e) -> @isDown = false



# Bind mouse event handlers on DOM ready
Kona.ready ->
  document.onmousemove = Kona.Mouse.onMouseMove
  document.onmousedown = Kona.Mouse.onMouseDown
  document.onmouseup   = Kona.Mouse.onMouseUp
