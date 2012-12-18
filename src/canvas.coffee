Kona.Canvas =
  defaults:
    width:  640
    height: 480

  init: (opts={}) ->
    @elem    = document.getElementById(opts.id) or throw new Error "can't find element with id: #{id}"
    @ctx     = @elem.getContext('2d')
    @width   = @elem.width  || @defaults.width
    @height  = @elem.height || @defaults.height

  # Safely perform a draw that may change the ctx fillStyle
  # i.e., wrap a function in context save() and restore()
  safe: (fxn) ->
    @ctx.save()
    fxn()
    @ctx.restore()

  # Wipe the canvas
  clear: ->
    @safe =>
      @ctx.fillStyle = 'white'
      @ctx.fillRect(0, 0, @width, @height)



  # Draw a vertical line at an x-coordinate
  verticalLine: (x) ->
    @safe =>
      @ctx.fillStyle = 'red'
      @ctx.fillRect(x, 0, 2, @height)

  # Highlight a column at an x-coordinate
  highlightColumn: (x) ->
    Kona.Canvas.safe =>
      @ctx.fillStyle   = 'red'
      @ctx.globalAlpha = 0.01
      size = Kona.Tile.tileSize
      left = size * Math.floor(x / size)
      Kona.Canvas.ctx.fillRect(left, 0, size, Kona.Canvas.height)
