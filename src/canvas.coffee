Kona.Canvas =
  defaults:
    width:  640
    height: 480

  init: (opts={}) ->
    @elem    = document.getElementById(opts.id) or throw new Error "cant build canvas with id: #{id}"
    @ctx     = @elem.getContext('2d')
    @width   = @elem.width  || @defaults.width
    @height  = @elem.height || @defaults.height

  # Safely perform a draw that may change the ctx fillStyle
  # i.e., wrap a function in context save() and restore()
  safe: (fxn) ->
    @ctx.save()
    fxn()
    @ctx.restore()

  clear: ->
    @safe =>
      @ctx.fillStyle = "white"
      @ctx.fillRect(0, 0, @width, @height)



  verticalLine: (x) ->
    @safe =>
      @ctx.fillStyle = 'red'
      @ctx.fillRect(x, 0, 2, @height)
