# An interface for defining time-based animations using sprite sheets.
# TODO: DOCS
#
# Options:
#
#   * __sheet__ - (String) The path to the sprite sheet for the animation. Ex: `'img/entities/player_run.png'`
#   * __width__ - (Integer) The width of each animation frame, in pixels. Defaults to the box width of the associated entity
#   * __height__ - (Integer) The height of each animation frame, in pixels. Defaults to the box height of the associated entity
#   * __repeat__ - (Boolean) Whether or not the animation should loop after playing once
#   * __next__ - (String | Function) Test
#

class Kona.Animation
  constructor: (opts={}) ->
    @lastUpdateTime = 0
    @elapsed        = 0
    @msPerFrame     = opts.msPerFrame || 25

    @entity    = opts.entity
    @image     = new Image()
    @image.src = opts.sheet
    @position  = { x: 0, y: 0 }

    @frames =
      width:  opts.width
      height: opts.height

    @repeat = if opts.repeat? then opts.repeat else true
    @next   = opts.next || null
    @played = false


  triggerNext: ->
    if _.isString(@next)
      @entity.setAnimation(@next)
    else if _.isFunction(@next)
      @next()


  update: ->
    delta = Date.now() - @lastUpdateTime
    if @elapsed > @msPerFrame
      @elapsed = 0

      # Move one frame right
      @position.x += @frames.width

      # Past the edge - revert to the correct next frame
      if @position.x + @frames.width > @image.width
        if @position.y + @frames.height >= @image.height
          # Last frame of last row - start over
          @played = true
          @triggerNext()
          @position.x = @position.y = 0
        else
          # Move down one row of frames
          @position.x = 0
          @position.y += @frames.height
    else
      @elapsed += delta

    @lastUpdateTime = Date.now()


  draw: ->
    targetX      = @entity.position.x
    targetY      = @entity.position.y
    targetWidth  = @entity.box.width
    targetHeight = @entity.box.height

    unless !@repeat and @played
      Kona.Canvas.ctx.drawImage(
        @image,                                                  # Image being drawn
        @position.x, @position.y, @frames.width, @frames.height, # Rect from source image
        targetX, targetY, targetWidth, targetHeight              # Rect of target canvas
      )

      @update()
