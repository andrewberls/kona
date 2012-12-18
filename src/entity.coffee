# An abstract renderable screen object.
# An entity belongs to a scene.

class Kona.Entity
  @grav = 8

  constructor: (opts={}) ->
    @group  = opts.group
    @solid  = true
    @speed  = 0
    @facing = ''

    @position =
      x: opts.x || 0
      y: opts.y || 0

    @direction =
      dx: opts.dx || 0
      dy: opts.dy || 0

    @box =
      width:  opts.width  || 0
      height: opts.height || 0

    # TODO: Kona.Sprite
    @sprite = new Image()
    @sprite.src = ''

  update: ->
    if @direction.dx > 0
      @facing = 'right'
    else if @direction.dx < 0
      @facing = 'left'

    @position.x += @speed * @direction.dx
    @correctLeft()
    @correctRight()

  draw: ->

  destroy: (name) ->
    Kona.Scenes.currentScene.removeEntity(@group, @)



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

  addGravity: ->
    @position.y += Kona.Entity.grav
    @correctBottom()

  setPosition: (x, y) ->
    @position.x = x
    @position.y = y

  stop: (axis) ->
    if axis?
      @direction[axis] = 0
    else
      @direction.dx = @direction.dy = 0



  # ---------------------
  # Collision detection
  # ---------------------
  inRowSpace: (e) ->
    # To collide with an entity from the left or right, you must be in its row
    @futureBottom() > e.top() and @futureTop() < e.bottom()

  inColumnSpace: (e) ->
    # To collide with an entity from the top or bottom, you must be in its column
    @futureLeft() < e.right() and @futureRight() > e.left()


  eachSolidEntity: (fxn) =>
    # TODO: Remove duplication between this and onSurface()
    # TODO: Be smarter about computing which entities to test
    for name, list of Kona.Scenes.currentScene.entities
      list = _.reject list, (ent) => ent == @
      for ent in list
        fxn(ent) if ent? && ent.solid


  # Loop over solid neighbor entities and determine whether or not a collision occurs
  # based on a condition function. Makes left/right/top/bottom detection more generic.
  isCollision: (checkFxn) ->
    collision = false
    @eachSolidEntity (ent) =>
      collision = true if checkFxn(ent)
    collision


  # Player's left hitting an entities right
  # Collision with a specific entity
  leftCollision: (ent) ->
    @right() >= ent.right() and @futureLeft() <= ent.right() and @inRowSpace(ent)

  # Collision with a nearby neighbor
  leftCollisions: -> return @isCollision (ent) => @leftCollision(ent)


  # Player's right hitting an entities left
  # Collision with a specific entity
  rightCollision: (ent) ->
    @left() <= ent.left() and @futureRight() >= ent.left() and @inRowSpace(ent)

  # Collision with a nearby neighbor
  rightCollisions: -> return @isCollision (ent) => @rightCollision(ent)



  # Player's top hitting an entities bottom
  # Collision with a specific entity
  topCollision: (ent) ->
    @bottom() >= ent.bottom() and @futureTop() <= ent.bottom() and @inColumnSpace(ent)

  # Collision with a nearby neighbor
  topCollisions: -> return @isCollision (ent) => @topCollision(ent)



  # Player's bottom hitting an entities top
  # Collision with a specific entity
  bottomCollision: (ent) ->
    @top() <= ent.top() and @futureBottom() >= ent.top() and @inColumnSpace(ent)

  # Collision with a nearby neighbor
  bottomCollisions: -> return @isCollision (ent) => @bottomCollision(ent)


  onSurface: =>
    for name, list of Kona.Scenes.currentScene.entities
      list = _.reject list, (ent) => ent == @
      for ent in list
        return true if ent.solid && ent.position.y == @bottom() + 1

    return false



  # ---------------------
  # Collision correction
  # ---------------------
  # Resolve collisions after getting user input and applying transformations to entity
  correctLeft:   -> @position.x += 1 while @leftCollisions() || @left() < 0
  correctRight:  -> @position.x -= 1 while @rightCollisions()
  correctTop:    -> @position.y += 1 while @topCollisions()
  correctBottom: -> @position.y -= 1 while @bottomCollisions()
