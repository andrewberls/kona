# Provides a thin wrapper around the main canvas element used for rendering.

Kona.Canvas =
  defaults:
    width:  660
    height: 480

  # Construct our canvas object.
  #
  # * __id__ (String) - the id of the HTML element
  #
  # Ex:
  #   `Kona.Canvas.init('gameCanvas')`
  init: (id) ->
    @elem    = document.getElementById(id) or fail("Can't find element with id: #{id}")
    @ctx     = @elem.getContext('2d')
    @width   = @elem.width  || @defaults.width
    @height  = @elem.height || @defaults.height

  # Safely perform a draw that may change the ctx fillStyle or other properties
  # (will not affect subsequent drawings)
  #
  # Ex:
  #
  #     Kona.Canvas.safe =>
  #       Kona.Canvas.ctx.fillStyle = 'red'
  #       Kona.Canvas.ctx.fillRect(100, 100, 50, 50)
  safe: (fxn) ->
    @ctx.save()
    fxn()
    @ctx.restore()

  # Clear the entire canvas. Used internally between frames to prevent blurring on redraw
  clear: ->
    @safe =>
      @ctx.fillStyle = 'white'
      @ctx.fillRect(0, 0, @width, @height)
