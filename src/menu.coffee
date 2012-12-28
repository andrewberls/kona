class Kona.Menu extends Kona.Scene
  constructor: (opts={}) ->
    super(opts)
    @fontSize      = opts.fontSize      || '30px'
    @font          = opts.font          || 'Times New Roman'
    @textAlign     = opts.textAlign     || 'center'
    @textColor     = opts.textColor     || 'white'
    @selectedColor = opts.selectedColor || 'yellow'
    @options       = opts.options
    @trigger       = opts.trigger

    if @trigger?
      Kona.Keys.bind @trigger, =>
        Kona.Canvas.clear() # TODO: PROBABLY WONT NEED THIS WITH A BG IMAGE
        Kona.Scenes.setCurrent(@name)

  draw: ->
    Kona.Canvas.safe =>
      Kona.Canvas.ctx.font      = "#{@fontSize} #{@font}"
      Kona.Canvas.ctx.textAlign = @textAlign

      y = (Kona.Canvas.height - (parseInt(@fontSize) * _.size(@options))) / 2
      y_offset = 0

      for text, callback of @options
        Kona.Canvas.ctx.fillStyle = 'red'
        Kona.Canvas.ctx.fillText(text, Kona.Canvas.width/2, y + y_offset)
        y_offset += parseInt(@fontSize) + 20
