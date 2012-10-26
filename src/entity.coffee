# An abstract renderable screen object.
# An entity belongs to a scene.

class Kona.Entity
  constructor: (opts={}) ->
    @solid = true

    @position =
      x: opts.x || 0
      y: opts.y || 0

    @direction =
      dx: opts.dx || 0
      dy: opts.dy || 0

    @box =
      width:  opts.width   || 0
      height: opts.height || 0

    # TODO: Kona.Sprite /sheet ?
    @sprite = new Image()
    @sprite.src = ''

  # Punt if not defined in child class
  update: ->
  draw: ->

  # Standard edge coordinates
  top:    -> @position.y
  bottom: -> @position.y + @box.height
  left:   -> @position.x
  right:  -> @position.x + @box.width

  # Edge coordinates accounting for current motion
  futureTop:    -> @position.y + @direction.dy
  futureBottom: -> @bottom()   + @direction.dy
  futureLeft:   -> @position.x + @direction.dx
  futureRight:  -> @right()    + @direction.dx

  # Sugar for integer dx/dy attributes
  movingLeft:  -> @direction.dx < 0
  movingRight: -> @direction.dx > 0





  # Player's left hitting a tile's right
  leftCollision: ->
    collision = false
    for col in Kona.TileManager.columnsFor(@)
      for tile in col
        if !tile.solid || @left() > tile.right()
          continue
        else
          if @right() >= tile.right() && @futureLeft() <= tile.right()
            if @futureBottom() > tile.top() and @futureTop() < tile.bottom()
              collision = true

    collision


  # Player's right hitting a tile's left
  rightCollision: ->
    collision = false
    for col in Kona.TileManager.columnsFor(@)
      for tile in col
        if !tile.solid || @right() < tile.left()
          continue
        else
          if @left() <= tile.left() && @futureRight() >= tile.left()
            if @futureBottom() > tile.top() and @futureTop() < tile.bottom()
              collision = true

    collision











  stop: (axis) ->
    # TODO: factor out accepted axes. Enforce?
    if axis?
      _.contains(['dx', 'dy'], axis) || throw new Error("Axis #{axis} not recognized")
      @direction[axis] = 0

