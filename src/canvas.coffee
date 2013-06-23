# Utility wrapper around the canvas DOM element used for rendering

Kona.Canvas =

  # Default dimensions if none specified
  defaults:
    width:  720
    height: 600 # 540


  # Public: Initialize the main canvas object
  #
  # id - String ID of the HTML canvas DOM element.
  #
  # Ex:
  #
  #   `Kona.Canvas.init('gameCanvas')`
  #
  # Returns nothing
  #
  init: (id) ->
    @elem = document.getElementById(id) or fail("Canvas.init", "Can't find element with id: #{id}")
    @ctx  = @elem.getContext('2d')
    @elem.width  = @defaults.width  unless @elem.getAttribute('width')?
    @elem.height = @defaults.height unless @elem.getAttribute('height')?
    @width       = @elem.width
    @height      = @elem.height


  # Public: Safely perform a draw that may change the ctx fillStyle or other properties
  # (will not affect subsequent drawings)
  #
  # fn - Function that may alter the canvas context / perform drawing
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


  # Internal: Wipe the canvas clean.
  # Used between frames to prevent blurring on redraw
  #
  # Ex: `Kona.Canvas.clear()`
  #
  clear: ->
    @safe =>
      @ctx.fillStyle = 'white'
      @ctx.fillRect(0, 0, @width, @height)


  # Public: Draw a basic rectangle to the canvas
  #
  # position -  Hash representing the coordinates of an entity
  #   x -  Integer x-coordinate of the entity, in pixels
  #   y -  Integer y-coordinate of the entity, in pixels
  #
  # box -  Hash representing the dimensions of an entity
  #   width  - Integer width, in pixels
  #   height - Integer height, in pixels
  #
  # opts - Hash of additional method options
  #   color  - A color to pass to ctx.fillStyle. Ex: 'red'
  #
  # Ex:
  #
  #   `Kona.Canvas.drawRect(entity.position, entity.box, { color: 'red' })`
  #
  # Returns nothing
  #
  drawRect: (position, box, opts={}) ->
    @safe =>
      @ctx.fillStyle = opts.color || 'black'
      @ctx.fillRect(position.x, position.y, box.width, box.height)



  # Public: Draw a basic circle to the canvas
  #
  # position -  Hash representing the coordinates of an entity
  #   x -  Integer x-coordinate of the entity, in pixels
  #   y -  Integer y-coordinate of the entity, in pixels
  #
  # opts - Hash of additional method options
  #   radius - Integer radius, in pixels
  #   color  - A color to pass to ctx.fillStyle. Ex: 'red' (Default: 'black')
  #
  # Ex:
  #
  #   `Kona.Canvas.drawCircle(entity.position, { radius: 20, color: 'blue' })`
  #
  # Raises Exception if radius not provided
  # Returns nothing
  #
  drawCircle: (position, opts) ->
    radius = opts.radius or fail("Must specify a radius")
    @safe =>
      @ctx.fillStyle = opts.color || 'black'
      @ctx.beginPath()
      @ctx.arc(position.x, position.y, radius, 0, 2*Math.PI, false)
      @ctx.closePath()
      @ctx.fill()

