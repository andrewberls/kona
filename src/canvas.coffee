# Provides a thin wrapper around the main canvas element used for rendering.

Kona.Canvas =
  defaults:
    width:  660
    height: 480

  # Construct the main canvas object.
  #
  # * __id__ (String) - the id of the HTML element (without leading '#')
  #
  # Ex:
  #
  #   `Kona.Canvas.init('gameCanvas')`
  #
  init: (id) ->
    @elem = document.getElementById(id) or fail("Can't find element with id: #{id}")
    @ctx  = @elem.getContext('2d')
    @elem.width  = @defaults.width  unless @elem.getAttribute('width')?
    @elem.height = @defaults.height unless @elem.getAttribute('height')?
    @width       = @elem.width
    @height      = @elem.height


  # Safely perform a draw that may change the ctx fillStyle or other properties
  # (will not affect subsequent drawings)
  #
  # Ex:
  #
  #     Kona.Canvas.safe =>
  #       Kona.Canvas.ctx.fillStyle = 'red'
  #       Kona.Canvas.ctx.fillRect(100, 100, 50, 50)
  #
  safe: (fn) ->
    @ctx.save()
    fn()
    @ctx.restore()


  # Wipe the canvas clean.
  # Used internally between frames to prevent blurring on redraw
  clear: ->
    @safe =>
      @ctx.fillStyle = 'white'
      @ctx.fillRect(0, 0, @width, @height)


  # Draw a basic rectangle
  #
  # Ex:
  #
  #   `Kona.Canvas.drawRect(@position, @box, { color: 'red' })`
  #
  drawRect: (position, box, opts={}) ->
    @safe =>
      @ctx.fillStyle = opts.color || 'black'
      @ctx.fillRect(position.x, position.y, box.width, box.height)


  # Wrapper for the fillRect method.
  #
  #   * __direction__ - (Object) Object representing the coordinates of an entity (can pass in an entities' `position` attribute)
  #     * x: The x-coordinate of the entity
  #     * y: The y-coordinate of the entity
  #
  # Ex:
  #
  #   `Kona.Canvas.drawCircle(@position, { radius: 20, color: 'blue' })`
  #
  drawCircle: (position, opts={}) ->
    radius = opts.radius or fail("Must specify a radius")
    @safe =>
      @ctx.fillStyle = opts.color || 'black'
      @ctx.beginPath()
      @ctx.arc(position.x, position.y, radius, 0, 2*Math.PI, false)
      @ctx.closePath()
      @ctx.fill()

