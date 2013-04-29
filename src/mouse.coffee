Kona.Mouse =

  x: 0
  y: 0
  isDown: false

  # Event handlers

  onMouseMove: (e) ->
    e ?= window.event # TODO: test this
    canvas = Kona.Canvas.elem
    @x = e.clientX - canvas.offsetLeft
    @y = e.clientY - canvas.offsetTop


  onMouseDown: (e) ->
    @isDown = true


  onMouseUp: (e) -> @isDown = false



# Bind mouse event handlers on DOM ready
Kona.ready ->
  document.onmousemove = Kona.Mouse.onMouseMove
  document.onmousedown = Kona.Mouse.onMouseDown
  document.onmouseup   = Kona.Mouse.onMouseUp
