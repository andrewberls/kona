# An interface for defining time-based animations using sprite sheets.
# TODO: DOCS
#
# Options:
#
#   * __sheet__ - (String) The path to the sprite sheet for the animation. Ex: `'img/entities/player_run.png'`
#   * __width__ - (Integer) The width of each animation frame, in pixels. Defaults to the box width of the associated entity
#   * __height__ - (Integer) The height of each animation frame, in pixels. Defaults to the box height of the associated entity
#







# TODO: ANIMATION.NEXT








class Kona.Animation
  constructor: (opts={}) ->
    @lastUpdateTime = 0
    @elapsed        = 0
    @msPerFrame     = 25 # TODO

    @entity    = opts.entity
    @image     = new Image()
    @image.src = opts.sheet
    @position  = { x: 0, y: 0 }

    @frames =
      width:  opts.width
      height: opts.height


  draw: ->
    targetX      = @entity.position.x
    targetY      = @entity.position.y
    targetWidth  = @entity.box.width
    targetHeight = @entity.box.height

    Kona.Canvas.ctx.drawImage(
      @image,                                                  # Image we are drawing
      @position.x, @position.y, @frames.width, @frames.height, # Rectangle to clip from source image
      targetX, targetY, targetWidth, targetHeight              # Rectangle of target canvas we're drawing to
    )

    delta = Date.now() - @lastUpdateTime
    if @elapsed > @msPerFrame
      @elapsed = 0

      # Move one frame right
      @position.x += @frames.width

      # Past the edge - revert to the correct next frame
      if @position.x + @frames.width > @image.width
        if @position.y + @frames.height >= @image.height
          # Last frame of last row - start over
          @position.x = @position.y = 0
        else
          # Move down one row of frames
          @position.x = 0
          @position.y += @frames.height

    else
      @elapsed += delta

    @lastUpdateTime = Date.now()
