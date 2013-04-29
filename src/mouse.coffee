Kona.Mouse =

  x: 0
  y: 0
  isDown: false

  # Event handlers

  onMouseMove: (e) ->
    e ?= window.event # TODO: test this
    canvas = Kona.Canvas.elem
    @x = ev.clientX - canvas.offsetLeft
    @y = ev.clientY - canvas.offsetTop


  onMouseDown: (e) ->
    @isDown = true
    puts "click at x: #{@x}, y: #{@y}"


  onMouseUp: (e) -> @isDown = false



# Bind mouse event handlers on DOM ready
Kona.ready ->
  document.onmousemove = Kona.Mouse.onMouseMove
  document.onmousedown = Kona.Mouse.onMouseDown
  document.onmouseup   = Kona.Mouse.onMouseUp
