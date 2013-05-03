# Internal store for animations for a class
# Keys are of the form "group:className", and the value is
# a set of opts used to construct on a per-entity basis
#
# TODO: store constructed Kona.Animation objects here, and then assign to each
# entity with modifications as necessary?
Kona.Animations = {}



# An interface for defining time-based animations using sprite sheets.
#
# Constructor options:
#
#   * __sheet__ - (String) The path to the sprite sheet for the animation. Ex: `'img/entities/player_run.png'`
#   * __width__ - (Integer) The width of each animation frame, in pixels. Defaults to the box width of the associated entity
#   * __height__ - (Integer) The height of each animation frame, in pixels. Defaults to the box height of the associated entity
#   * __repeat__ - (Boolean) Whether or not the animation should loop after playing once
#   * __next__ - (String | Function) If __string__, then the name of the animation to switch to after playing once. If __function__, then callback to invoke after playing.
#
class Kona.Animation
  constructor: (opts={}) ->
    @lastUpdateTime = 0
    @elapsed        = 0
    @msPerFrame     = opts.msPerFrame || 25

    @entity    = opts.entity
    @name      = opts.name
    @image     = new Image()
    @image.src = opts.sheet
    @position  = { x: 0, y: 0 }

    @frames =
      width:  opts.width
      height: opts.height

    @repeat = if opts.repeat? then opts.repeat else true
    @next   = opts.next || null
    @played = false


  # Switch to the next animation specified, else invoke a given callback
  triggerNext: ->
    if _.isString(@next)
      @entity.setAnimation(@next)
    else if _.isFunction(@next)
      @next()


  # Move to the next frame
  update: ->
    delta = Date.now() - @lastUpdateTime
    if @elapsed > @msPerFrame
      @elapsed = 0

      # Move one frame right
      @position.x += @frames.width

      # Past the edge - move down or reset to start
      if @position.x + @frames.width > @image.width
        @position.x = 0
        @position.y += @frames.height
        @reset() if @position.y + @frames.height >= @image.height

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


  # Trigger next action and reset to frame 0
  reset: ->
    @played = true
    @triggerNext()
    @position.x = @position.y = 0
