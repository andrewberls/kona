# An abstract renderable screen object.
# An entity belongs to a scene.

class Kona.Entity
  @grav = 1 # 5

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



  # ---------------------
  # Edges
  # ---------------------
  # Standard edges
  top:    -> @position.y
  bottom: -> @position.y + @box.height
  left:   -> @position.x
  right:  -> @position.x + @box.width

  # Edge coordinates accounting for current motion
  futureTop:    -> @top()    + @direction.dy
  futureBottom: -> @bottom() + @direction.dy
  futureLeft:   -> @left()   + @direction.dx
  futureRight:  -> @right()  + @direction.dx



  # ---------------------
  # Motion
  # ---------------------
  # Sugar for integer dx/dy attributes
  movingLeft:  -> @direction.dx < 0
  movingRight: -> @direction.dx > 0

  addGravity: -> @position.y += Kona.Entity.grav

  stop: (axis) ->
    # TODO: factor out accepted axes. Enforce?
    if axis?
      _.contains(['dx', 'dy'], axis) || throw new Error("Axis #{axis} not recognized")
      @direction[axis] = 0



  # ---------------------
  # Collision detection
  # ---------------------
  inRowSpace: (e) ->
    # To collide with a tile from the left or right, you must be in its row
    @futureBottom() > e.top() and @futureTop() < e.bottom()
    # @bottom() < e.bottom() and @top() > e.top()

  inColumnSpace: (e) ->
    # To collide with a tile from the top or bottom, you must be in its column
    @futureLeft() < e.right() and @futureRight() > e.left()


  eachSolidTile: (fxn) =>
    for col in Kona.TileManager.columnsFor(@)
      for tile in col
        if tile.solid then fxn(tile) else continue


  # Loop over solid neighbor tiles and determine whether or not a collision occurs
  # based on a condition function. Makes left/right/top/bottom detection more generic.
  isCollision: (checkFxn) ->
    collision = false
    @eachSolidTile (tile) =>
      collision = true if checkFxn(tile)
    collision


  # Player's left hitting a tile's right
  leftCollision: ->
    return @isCollision (tile) =>
      @right() >= tile.right() and @futureLeft() <= tile.right() and @inRowSpace(tile)


  # Player's right hitting a tile's left
  rightCollision: ->
    return @isCollision (tile) =>
      @left() <= tile.left() and @futureRight() >= tile.left() and @inRowSpace(tile)


  # Player's top hitting a tile's bottom
  topCollision: ->
    return @isCollision (tile) =>
      @bottom() >= tile.bottom() and @futureTop() <= tile.bottom() and @inColumnSpace(tile)


  # Player's bottom hitting a tile's top
  bottomCollision: ->
    return @isCollision (tile) =>
      if @top() <= tile.top() and @futureBottom() >= tile.top() and @inColumnSpace(tile)
        # Kona.debug "bottom collision with tile: #{tile}. in column space?: #{@inColumnSpace(tile)}"
        return true
