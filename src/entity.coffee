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
#

class Kona.Entity

  # Class methods

  # Strength of gravity (downward pull applied each tick)
  @grav = 9


  # Load animations on a group of entities.
  # This simply passed the given configuration to each entity instance in a group
  #
  # Parameters:
  #
  #   * __group__ - (String) The group the entity belongs to, ex: `'enemies'`
  #   * __animations__ - (Object) Animation configuration passed into ent.loadAnimations()
  #      (See entity#loadAnimations)
  #
  # Ex:
  #
  #     EvilNinja.loadAnimations 'enemies', {
  #       'run_right' : { width:50,height:55, sheet: 'img/enemies/turtle/run_right.png', active: true }
  #       'run_left'  : { width:50,height:55, sheet: 'img/enemies/turtle/run_left.png' }
  #       'die'       : { width:50,height:55, sheet: 'img/enemies/turtle/die.png', next: -> @entity.destroy() }
  #     }
  #
  #
  #
  # You can also omit the group name if it is defined on the class itself
  #
  # Ex:
  #
  #     class EvilNinja extends Kona.Entity
  #       @group: 'enemies'
  #
  #       constructor: (opts={}) ->
  #         opts.group ||= EvilNinja.group
  #         super(opts)
  #
  #
  #     EvilNinja.loadAnimations {
  #       'run_right' : { width:50,height:55, sheet: 'img/enemies/turtle/run_right.png', active: true }
  #       'run_left'  : { width:50,height:55, sheet: 'img/enemies/turtle/run_left.png' }
  #       'die'       : { width:50,height:55, sheet: 'img/enemies/turtle/die.png', next: -> @entity.destroy() }
  #     }
  #
  @loadAnimations = (group_or_animations, animations={}) ->
    Kona.Engine.queue =>
      for scene in Kona.Scenes.scenes
        if _.isString(group_or_animations)
          group = group_or_animations
        else
          group = @group
          animations = group_or_animations

        # We can have multiple types of entity in the same group, e.g. 'enemies'
        # Therefore take precaution to only load anims for the correct instances
        for ent in scene.getEntities(group)
          ent.loadAnimations(animations) if ent instanceof @



  # Instance methods

  # A superconstructor initializing some basic fields.
  # All game object constructors should call this. For example:
  #
  #     class Enemy extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @isEvil = true
  #         # etc...
  #
  # Constructor options:
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
  constructor: (opts={}) ->
    # TODO: this error message sucks. How to get better introspection on error location?
    @group   = opts.group or fail("Entity#new", "entity must have a group")
    @scene   = opts.scene
    @solid   = if opts.solid?   then opts.solid   else true
    @gravity = if opts.gravity? then opts.gravity else true
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


  # Apply gravitational effects any directional changes each frame, and resolve any
  # resulting collisions (ex running into a wall)
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

    @addGravity()

    @position.x += @speed * @direction.dx
    @position.y += @speed * @direction.dy

    @correctLeft()
    @correctRight()


  # Draw the current animation to the canvas if it exists,
  # else draw the current sprite
  draw: ->

    # TODO: show collision rectangles
    Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

    if @currentAnimation?
      @currentAnimation.draw()
    else
      Kona.Canvas.ctx.drawImage(@sprite, @position.x, @position.y, @box.width, @box.height)


  # Destroy an instance by removing it from the current scene
  destroy: ->
    Kona.Scenes.currentScene.removeEntity(@)


  # Is this entities scene active?
  isActive: -> @scene == Kona.Scenes.currentScene



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
  #
  setPosition: (x, y) ->
    @position.x = x
    @position.y = y


  # Stop all motion on an axis. Motion is stopped in all directions if one is not provided.
  #
  # Ex: `player.stop('x')`
  #
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
  anyCollisions: (fn) ->
    collision = false
    @eachSolidEntity (ent) =>
      collision = true if fn(ent)
    collision



  # __Left collision__: left edge hitting an entities right
  #
  # Collision with a specific entity. Returns Boolean
  leftCollision: (ent) ->
    @right() >= ent.right()+1 and @left() <= ent.right()+1 and @inRowSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasLeftCollisions: -> return @anyCollisions (ent) => @leftCollision(ent)


  # __Right collision__: right edge hitting an entities left
  #
  # Collision with a specific entity. Returns Boolean
  rightCollision: (ent) ->
    @left() <= ent.left()+1 and @right() >= ent.left()+1 and @inRowSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasRightCollisions: -> return @anyCollisions (ent) => @rightCollision(ent)


  # __Top collision__: top edge hitting an entities bottom
  #
  # Collision with a specific entity. Returns Boolean
  topCollision: (ent) ->
    @bottom() >= ent.bottom()+1 and @top() <= ent.bottom()+1 and @inColumnSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasTopCollisions: -> return @anyCollisions (ent) => @topCollision(ent)


  # __Bottom collision__: bottom edge hitting an entities top
  #
  # Collision with a specific entity. Returns Boolean
  bottomCollision: (ent) ->
    @top() <= ent.top() and @bottom() >= ent.top() and @inColumnSpace(ent)

  # Collision with any neighboring entity. Returns Boolean
  hasBottomCollisions: -> return @anyCollisions (ent) => @bottomCollision(ent)



  # Collision from any side with another entity. Returns Boolean
  intersecting: (ent) ->
    @leftCollision(ent) || @rightCollision(ent) || @topCollision(ent) || @bottomCollision(ent)


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
    Kona.Collectors.add(name, @) for name in names

  # Alias `collects()` as `triggers()`
  triggers: (names...) ->
    @collects(name) for name in names




  # ---------------------
  # Animations
  # ---------------------
  # TODO: DOCS
  #
  # player.loadAnimations {
  #   'run_left' : { sheet: 'img/player/run_left.png' }
  #   'die'      : { sheet: 'img/player/die.png' }
  # }
  #
  loadAnimations: (animations) ->
    for name, opts of animations
      animOpts = Kona.Utils.merge { entity: @, name: name, width: @box.width, height: @box.height  }, opts
      @animations[name] = new Kona.Animation(animOpts)
      @setAnimation(name) if animOpts.active == true


  setAnimation: (name) ->
    @currentAnimation = @animations[name] or fail("Couldn't find animation with name #{name}")


  clearAnimation: ->
    @currentAnimation = null


  # ---------------------
  # Mixins
  # ---------------------
  # A thin wrapper for `Kona.Utils.merge`, enabling an approach of composable mixins
  # Param: objs, a splat list of Objects
  # e.g., `@include Killable` or `@include Killable, Resettable`
  #
  # Ex:
  #
  #     Killable = {
  #       die: ->
  #         @stop()
  #         @isAlive = false
  #         @setAnimation('die')
  #     }
  #
  #     Resettable = { ... }
  #
  #     class Player extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @include Killable, Resettable
  #
  #     class Enemy extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @include Killable
  #
  # Now `die()` is available on both `player` and `enemy` instances
  # Note that `this` will be scoped to the __including object__
  # e.g., `this` in `player.die()` will be `player`
  #
  include: (objs...) -> Kona.Utils.merge(@, obj) for obj in objs
