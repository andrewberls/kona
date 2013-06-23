# An interface for defining time-based animations using sprite sheets.


# Internal store for animations for a class
# Keys are of the form "group:className", and the value is
# a set of opts used to construct on a per-entity basis
Kona.Animations = {}



# Public: Animation constructor
#
# opts - Hash of attributes (Default: {})
#   msPerFrame  - Integer duration of each frame in milliseconds (Default: 25)
#
#   entity - Kona.Entity instance this animation is associated with
#
#   name   - String name of this animation. Ex: 'run_left'
#
#   sheet  - String path to the sprite sheet for the animation.
#            Ex: `'img/entities/player_run.png'`
#
#   width  - Integer width of each animation frame, in pixels
#            (Default: box width of associated entity)
#
#   height - Integer height of each animation frame, in pixels
#            (Default: box height of associated entity)
#
#   repeat - Boolean indicating whether or not the animation should loop after playing once
#            (Default: true)
#
#   next   - String or Function
#            If String, specifies the name of the animation to switch to after playing once.
#            If function, then callback to invoke after playing once (Optional)
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


  # Internal: Switch to the next animation specified, else invoke a given callback
  # Returns nothing
  triggerNext: ->
    if _.isString(@next)
      @entity.setAnimation(@next)
    else if _.isFunction(@next)
      @next()


  # Internal: Move to the next frame
  # Returns nothing
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


  # Internal: draw the current frame and update
  # Returns nothing
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


  # Internal: Trigger next action and reset to frame 0
  # Returns nothing
  reset: ->
    @played = true
    @triggerNext()
    @position.x = @position.y = 0
