# An abstract class representing a renderable screen object belonging to a scene
#
# Basics such as position, direction, box model, and collision detection/resolution
# are handled within this class.
#
# All distinct objects on the canvas should inherit from this class -
# players, enemies, projectiles, collectables, etc.
#
# Ex:
#
#     class Enemy extends Kona.Entity
#       constructor: (opts={}) ->
#         super(opts)
#         # custom code here ...


  # A superconstructor initializing some basic fields.
  # Game object constructors should call this. For example:
  #
  #     class Enemy extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @isEvil = true
  #
  # Options:
  #
  #   * __group__ - (String) The group this entity belongs to, ex: `'enemies'`
  #   * __solid__ - (Boolean) Whether or not this entity is solid, e.g., can this collide with other entities. Default: true.
  #   * __gravity__ - (Boolean) Whether or not this entity is subject to gravity. Default: true
  #   * __speed__ - (Integer) The speed of this entity when moving.
  #   * __facing__ - (String) The direction this entity is facing. Possible values: `'left'` or `'right'`
  #   * __position__ - (Object)
  #     * x: integer x-coordinate on the canvas
  #     * y: integer y-coordinate on the canvas
  #   * __direction__ - (Object) Values representing the current direction of the entity.
  #     * dx: `-1 = left, 1 = right, 0 = stationary`
  #     * dy: `-1 = up, 1 = down, 0 = stationary`
  #   * __box__ - (Object) Values representing the dimensions of the entity. Collisions
  #     are resolved in terms of a rectangular box model.
  #     * width: An integer width, in pixels
  #     * height: An integer height, in pixels
  #   * __sprite__ - (Type)
  #
 class Kona.Entity
  @grav = 8

  @loadAnimations = (group, animations) ->
    Kona.Engine.queue =>
      list = Kona.Scenes.currentScene.entities[group]
      if list?
        for ent in list
          ent.loadAnimations(animations)


  constructor: (opts={}) ->
    @group   = opts.group or fail ("entity must have a group")
    @solid   = opts.solid   || true
    @gravity = opts.gravity || true
    @speed   = opts.speed   || 0
    @facing  = opts.facing  || ''

    @sprite     = new Image()
    @sprite.src = opts.sprite || null

    @position =
      x: opts.x || 0
      y: opts.y || 0

    @direction =
      dx: opts.dx || 0
      dy: opts.dy || 0

    @box =
      width:  opts.width  || 0
      height: opts.height || 0

    parent = @
    @sprite.onload = ->
      parent.box.width  = @width  if parent.box.width  == 0
      parent.box.height = @height if parent.box.height == 0

    @animations       = []
    @currentAnimation = null


  # Apply any directional changes each frame, and resolve any
  # resulting collisions (ex running into a wall)
  # Note that only the x direction is handled automatically
  # __Gravity or other vertical effects must be applied manually
  # in a child function.__
  #
  # Ex:
  #
  #     class Enemy extends Kona.Entity
  #       update: ->
  #         super
  #         @addGravity()
  #
  update: ->
    if @direction.dx > 0
      @facing = 'right'
    else if @direction.dx < 0
      @facing = 'left'

    @position.x += @speed * @direction.dx
    @position.y += @speed * @direction.dy

    @correctLeft()
    @correctRight()


  # Draw the current animation to the canvas if it exists,
  # else draw the current sprite
  draw: ->
    if @currentAnimation?
      @currentAnimation.draw()
    else
      Kona.Canvas.ctx.drawImage(@sprite, @position.x, @position.y, @box.width, @box.height)


  # Destroy an instance by removing it from the current scene
  destroy: ->
    Kona.Scenes.currentScene.removeEntity(@)



  # ---------------------
  # Edge Accessors
  # ---------------------
  # Return the coordinates of bounding box edges, in pixels
  top:    -> @position.y
  bottom: -> @position.y + @box.height
  left:   -> @position.x
  right:  -> @position.x + @box.width

  # Return the coordinates of the x and y midpoints of this entity
  midx: -> @position.x + Math.ceil(@box.width  / 2)
  midy: -> @position.y + Math.ceil(@box.height / 2)


  # ---------------------
  # Motion
  # ---------------------
  # Booleans indicating whether or not the entity is moving
  movingLeft:  -> @direction.dx < 0
  movingRight: -> @direction.dx > 0


  # Add gravity to the entities position, and resolve any resulting collisions
  # ex, prevent falling through the floor.
  # Intended to be called in an `update()` function
  addGravity: ->
    if @gravity
      @position.y += Kona.Entity.grav
      @correctBottom()


  # Move the entity to a specified pair of coordinates
  #
  #   * x: An integer x-coordinate in pixels
  #   * y: An integer y-coordinate in pixels
  setPosition: (x, y) ->
    @position.x = x
    @position.y = y


  # Stop all motion on an axis. Motion is stopped in all directions if one is not provided.
  #
  # Ex: `player.stop('x')`
  stop: (axis=null) ->
    if axis?
      @direction["d#{axis}"] = 0
    else
      @direction.dx = @direction.dy = 0



  # ---------------------
  # Collision detection
  # ---------------------
  # To collide with an entity from the left or right, you must be in its row
  inRowSpace: (e) ->
    # TODO: INCORRECT
    @bottom() > e.top() and @top() < e.bottom()


  # To collide with an entity from the top or bottom, you must be in its column
  inColumnSpace: (e) ->
    # TODO: INCORRECT
    @left() < e.right() and @right() > e.left()


  # ALl entities in a scene besides self
  neighborEntities: (opts={}) ->
    neighbors = {}
    for name, list of Kona.Scenes.currentScene.entities
      for ent in list
        neighbors[name] ||= []
        neighbors[name].push(ent) unless ent == @
    neighbors


  # Loop over solid entities in the current scene, and invoke a function on them.
  eachSolidEntity: (fn) =>
    for name, list of @neighborEntities()
      for ent in list
        fn(ent) if ent? && ent.solid


  # Loop over solid neighbor entities and determine whether or not a collision occurs
  # based on a check function. Makes detection more generic.
  isCollision: (fn) ->
    collision = false
    @eachSolidEntity (ent) =>
      collision = true if fn(ent)
    collision



  # __Left collision__: left edge hitting an entities right
  #
  # Collision with a specific entity
  #
  # Returns Boolean
  leftCollision: (ent) ->
    @right() >= ent.right() and @left() <= ent.right() and @inRowSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasLeftCollisions: -> return @isCollision (ent) => @leftCollision(ent)



  # __Right collision__: right edge hitting an entities left
  #
  # Collision with a specific entity. Returns Boolean
  rightCollision: (ent) ->
    @left() <= ent.left() and @right() >= ent.left() and @inRowSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasRightCollisions: -> return @isCollision (ent) => @rightCollision(ent)




  # __Top collision__: top edge hitting an entities bottom
  #
  # Collision with a specific entity. Returns Boolean
  topCollision: (ent) ->
    @bottom() >= ent.bottom() and @top() <= ent.bottom() and @inColumnSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasTopCollisions: -> return @isCollision (ent) => @topCollision(ent)




  # __Bottom collision__: bottom edge hitting an entities top
  #
  # Collision with a specific entity. Returns Boolean
  bottomCollision: (ent) ->
    @top() <= ent.top() and @bottom() >= ent.top() and @inColumnSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasBottomCollisions: -> return @isCollision (ent) => @bottomCollision(ent)




  # Collision from any side with another entity. Returns Boolean
  intersecting: (ent) ->
    @leftCollision(ent) || @rightCollision(ent) ||@topCollision(ent) || @bottomCollision(ent)


  # Is this entity standing on a surface?
  onSurface: =>
    for name, list of @neighborEntities()
      for ent in list
        return true if ent.solid && ent.position.y == @bottom() + 1

    return false



  # ---------------------
  # Collision correction
  # ---------------------
  # Resolve collisions after getting user input and applying transformations to entity
  #
  # For example, prevent a player from falling through the floor after applying
  # gravity.
  correctLeft:   -> @position.x += 1 while @hasLeftCollisions() || @left() < 0
  correctRight:  -> @position.x -= 1 while @hasRightCollisions()
  correctTop:    -> @position.y += 1 while @hasTopCollisions()
  correctBottom: -> @position.y -= 1 while @hasBottomCollisions()



  # ---------------------
  # Collectables
  # ---------------------
  # Mark this entity as a collector for a group of collectable entities.
  # Intended for initialization in a constructor.
  #
  # After calling, this entity will automatically activate
  # collectables in the specified group on contact.
  #
  # See docs for Kona.Collectable.
  #
  # Ex:
  #
  #     class Player extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @collects('coins', 'weapons')
  #
  collects: (names...) ->
    for name in names
      Kona.Collectors.add(name, @)



  # ---------------------
  # Animations
  # ---------------------
  # TODO: DOCS
  #
  # player.loadAnimations {
  #   'run_left' : { sheet: 'img/player/run_left' }
  #   'die'      : { sheet: 'img/player/die' }
  # }
  loadAnimations: (animations) ->
    for name, opts of animations
      animOpts = Kona.Utils.merge { entity: @, name: name, width: @box.width, height: @box.height  }, opts
      @animations[name] = new Kona.Animation(animOpts)
      @setAnimation(name) if animOpts.active == true


  setAnimation: (name) ->
    @currentAnimation = @animations[name] || fail("Couldn't find animation with name #{name}")


  clearAnimation: ->
    @currentAnimation = null
