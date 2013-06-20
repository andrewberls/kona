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

  # Class methods/variables

  # Strength of gravity (downward pull applied each tick)
  @grav = 9


  # Public: Load animations on a group of entities.
  # This simply passed the given configuration to each entity instance in a group
  #
  # Two forms:
  #   loadAnimations(String group, Hash Animations)
  #   loadAnimations(Hash Animations)
  #
  # Ex:
  #
  #     EvilNinja.loadAnimations 'enemies', {
  #       'run_right' : { width:50,height:55, sheet: 'img/enemies/turtle/run_right.png', active: true }
  #       'run_left'  : { width:50,height:55, sheet: 'img/enemies/turtle/run_left.png' }
  #       'die'       : { width:50,height:55, sheet: 'img/enemies/turtle/die.png', next: -> @entity.destroy() }
  #     }
  #
  # You can also omit the group name if it is defined on the class itself (preferred method)
  #
  # Ex:
  #
  #     class EvilNinja extends Kona.Entity
  #       @group: 'enemies'
  #
  #       constructor: (opts={}) ->
  #         super(opts)
  #
  #
  #     EvilNinja.loadAnimations {
  #       'run_right' : { width:50,height:55, sheet: 'img/enemies/turtle/run_right.png', active: true }
  #       'run_left'  : { width:50,height:55, sheet: 'img/enemies/turtle/run_left.png' }
  #       'die'       : { width:50,height:55, sheet: 'img/enemies/turtle/die.png', next: -> @entity.destroy() }
  #     }
  #
  # Returns nothing
  #
  @loadAnimations = (group_or_animations, animations={}) ->
    if _.isString(group_or_animations)
      group = group_or_animations
    else
      group = @group
      animations = group_or_animations

    Kona.Animations["#{group}:#{@name}"] = animations


  # Instance methods

  # Public: Entity constructor
  # A superconstructor initializing fields generic to all game entities.
  # All game object constructors should inherit from this class and call this.
  # Many of these fields will be filled automatically when using `Kona.Scenes.loadScenes()`
  #
  # Ex:
  #
  #     class Enemy extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @isEvil = true
  #         # etc...
  #
  # opts - Hash of attributes (Default: {})
  #   group    - String name of the group this entity belongs to, ex: `'enemies'`
  #
  #   scene    - The Kona.Scene instance that this entity belongs to (Usually set automatically)
  #
  #   solid    - Boolean indicating hether or not this entity is solid, e.g., can this collide with other entities. (Default: true)
  #
  #   gravity  - Boolean indicating whether or not this entity is subject to gravity. (Default: true)
  #
  #   speed    - Integer speed modifier of this entity when moving (Default: 0)
  #
  #   facing   - String direction this entity is facing. ('left' or 'right') (Optional)
  #
  #   position - Hash representing the coordinates of an entity
  #     x - Integer x-coordinate of the entity, in pixels
  #     y - Integer y-coordinate of the entity, in pixels
  #
  #   direction -  Hash representing the current direction of the entity
  #     dx: -1 = left, 1 = right, 0 = stationary
  #     dy: -1 = up, 1 = down, 0 = stationary
  #
  #   box - Hash representing the rectangular dimensions of the entity.
  #         (Collisions are resolved in terms of a rectangular box model.)
  #     width - Integer width of the collision box, in pixels
  #     height - Integer height of the collision box, in pixels
  #
  #   sprite - String path to a sprite image. Ex: 'images/collectables/coin.png'
  #
  # Raises Exception if group not provided
  #
  constructor: (opts={}) ->
    group    = opts.group || @constructor.group
    @group   = group or fail("#{@class()}#new", "entity must have a group")
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


  # Public: Return the String name of this instance's entity class
  # ex: `(new EvilNinja).class() => 'EvilNinja'`
  class: -> @constructor.name

  # Public: Basic representation of an entity as a string
  toString: -> "<#{@class()} position={ x: #{@position.x}, y: #{@position.y}}>"


  # Internal: Apply gravitational effects any directional changes each frame, and resolve any
  # resulting collisions (ex running into a wall)
  #
  # You should add custom functionality to this method in derived classes
  # to update your game entities.
  #
  # update() is called automatically in the render loop.
  #
  # Ex:
  #
  #     class Enemy extends Kona.Entity
  #       update: ->
  #         super()
  #         @die() if @top() > Kona.Canvas.height
  #
  # Returns nothing
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


  # Internal: Draw the current animation to the canvas if it exists,
  # else draw the current sprite
  #
  # draw() is called automatically in the render loop.
  #
  # Returns nothing
  draw: ->

    # DEBUG: show collision rectangles
    # Kona.Canvas.drawRect(@position, @box)

    if @currentAnimation?
      @currentAnimation.draw()
    else
      Kona.Canvas.ctx.drawImage(@sprite, @position.x, @position.y, @box.width, @box.height) if @sprite.src != '' # TODO


  # Public: Destroy an instance by removing it from the current scene
  # Returns nothing
  destroy: -> Kona.Scenes.currentScene.removeEntity(@)


  # Public: Return Boolean indicating whether or not the scene
  # this entity belongs to is currently active
  isActive: -> @scene == Kona.Scenes.currentScene



  # ---------------------
  # Public: Edge Accessors
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
  # Public: Motion
  # ---------------------
  # Booleans indicating whether or not the entity is moving
  movingLeft:  -> @direction.dx < 0
  movingRight: -> @direction.dx > 0


  # Internal: Add gravity to the entities position, and resolve any resulting collisions
  # (Ex: prevent falling through the floor.)
  # Returns nothing
  addGravity: ->
    if @gravity
      @position.y += Kona.Entity.grav
      @correctBottom()


  # Move the entity to a specified pair of coordinates
  #
  # x - Integer x-coordinate, in pixels
  # y - Integer y-coordinate, in pixels
  #
  # Returns nothing
  #
  # TODO: accept { x, y }
  setPosition: (x, y) ->
    @position.x = x
    @position.y = y


  # Public: Stop all motion on an axis.
  # Motion is stopped in all directions if one is not provided.
  #
  # axis: String axis name ('x' or 'y')
  #
  # Ex: `player.stop('x')`
  # Ex: `player.stop()`
  #
  # Returns nothing
  #
  stop: (axis=null) ->
    if axis?
      @direction["d#{axis}"] = 0
    else
      @direction.dx = @direction.dy = 0



  # ---------------------
  # Neighboring tiles
  # ---------------------

  # Internal
  leftCol:   -> Math.floor(@left() / Kona.Tile.tileSize)
  rightCol:  -> Math.floor(@right() / Kona.Tile.tileSize)
  bottomCol: -> Math.floor(@bottom() / Kona.Tile.tileSize) + 1
  topCol:    -> Math.floor(@top() / Kona.Tile.tileSize) + 1


  # Public: Return the Kona.Tile to the bottom left of this entity
  bottomLeftNeighbor: ->
    size  = Kona.Tile.tileSize
    midX       = (@leftCol()*size)+(size/2)  # The halfway point of the tile our left side is in
    neighborX  = (@leftCol()*size)           # Right of the midpoint - use the tile below us
    neighborX -= size if @left() < midX      # Left of the midpoint - use the tile one over to the left
    neighborY  = (@bottomCol()*size)
    return Kona.Scenes.currentScene.findTile(x: neighborX, y: neighborY)


  # Public: Return the Kona.Tile to the bottom right of this entity
  bottomRightNeighbor: ->
    size  = Kona.Tile.tileSize
    midX       = (@rightCol()*size)+(size/2)  # The halfway point of the tile our left side is in
    neighborX  = (@rightCol()*size)           # Left of the midpoint - use the tile below us
    neighborX -= size if @right > midX        # Right of the midpoint - use the tile one over to the right
    neighborY  = (@bottomCol()*size)
    return Kona.Scenes.currentScene.findTile(x: neighborX, y: neighborY)


  # TODO
  # topLeftNeighbor: ->
  # topRightNeighbor: ->


  # Public: Determine if this entity is facing another entity
  #
  # entity: A Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  isFacing: (entity) ->
    if @facing == 'left'
      entity.right() <= @left()
    else
      entity.left() >= @right()


  # ---------------------
  # Collision detection
  # ---------------------
  # Internal: To collide with an entity from the left or right, you must be in its row
  # Returns Boolean
  inRowSpace: (e) ->
    # TODO: INCORRECT
    @bottom() > e.top() and @top() < e.bottom()


  # Internal: To collide with an entity from the top or bottom, you must be in its column
  # Returns Boolean
  inColumnSpace: (e) ->
    # TODO: INCORRECT
    @left() < e.right() and @right() > e.left()


  # ALl entities in a scene besides self
  # Returns Array[Entity]
  # TODO: Oh my god. Cache this or something
  neighborEntities: (opts={}) ->
    # TODO
    # Kona.Scenes.currentScene.tree.retrieve(@position)
    _.select Kona.Scenes.currentScene.entities.concat(), (e) => e != @


  # Internal: Loop over solid entities in the current scene, and invoke a function on them.
  # Returns nothing
  eachSolidEntity: (fn) =>
    # TODO: _.where or similar?
    for ent in @neighborEntities()
      fn(ent) if ent? && ent.solid


  # Internal: Loop over solid neighbor entities and determine whether or not a collision occurs
  # based on a check function. Makes detection more generic.
  # Returns Boolean
  anyCollisions: (fn) ->
    collision = false
    @eachSolidEntity (ent) =>
      collision = true if fn(ent)
    collision



  # Public: Determine if left edge is hitting a specific entities' right
  #
  # ent - The Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  leftCollision: (ent) ->
    @right() >= ent.right()+1 and @left() <= ent.right()+1 and @inRowSpace(ent)


  # Public: Determine if left edge is hitting any neighboring entity
  # Returns Boolean
  hasLeftCollisions: -> return @anyCollisions (ent) => @leftCollision(ent)


  # Public: Determine if right edge is hitting a specific entities' left
  #
  # ent - The Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  rightCollision: (ent) ->
    @left() <= ent.left()+1 and @right() >= ent.left()+1 and @inRowSpace(ent)


  # Public: Determine if right edge is hitting any neighboring entity
  # Returns Boolean
  hasRightCollisions: -> return @anyCollisions (ent) => @rightCollision(ent)


  # Public: Determine if top edge is hitting a specific entities' bottom
  #
  # ent - The Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  topCollision: (ent) ->
    @bottom() >= ent.bottom()+1 and @top() <= ent.bottom()+1 and @inColumnSpace(ent)


  # Public: Determine if top edge is hitting any neighboring entity
  # Returns Boolean
  hasTopCollisions: -> return @anyCollisions (ent) => @topCollision(ent)


  # Public: Determine if bottom edge is hitting a specific entities' top
  #
  # ent - The Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  bottomCollision: (ent) ->
    @top() <= ent.top() and @bottom() >= ent.top() and @inColumnSpace(ent)


  # Public: Determine if bottom edge is hitting any neighboring entity
  # Returns Boolean
  hasBottomCollisions: -> return @anyCollisions (ent) => @bottomCollision(ent)


  # Public: Determine if there is a collision from any side with another entity.
  #
  # ent: The Kona.Entity instance to test against
  #
  # Returns Boolean
  #
  intersecting: (ent) ->
    @bottomCollision(ent) || @leftCollision(ent) || @rightCollision(ent) || @topCollision(ent)


  # Public: Determine if this entity is standing on a solid surface
  # Returns Boolean
  onSurface: =>
    _.any @neighborEntities(), (ent) => ent.solid && ent.position.y == @bottom() + 1




  # ---------------------
  # Internal: Collision correction
  # ---------------------
  # Resolve collisions after getting user input and applying transformations to entity
  #
  # For example, prevent a player from falling through the floor after applying gravity.
  #
  correctLeft:   -> @position.x += 1 while @hasLeftCollisions() || @left() < 0
  correctRight:  -> @position.x -= 1 while @hasRightCollisions()
  correctTop:    -> @position.y += 1 while @hasTopCollisions()
  correctBottom: -> @position.y -= 1 while @hasBottomCollisions()



  # ---------------------
  # Collectables
  # ---------------------
  # Public: Mark this entity as a collector for a group of collectable entities.
  # Intended for initialization in a constructor.
  #
  # After calling, this entity will automatically activate
  # collectables in the specified group on contact.
  #
  # names... - An arbitrary list of String group names of collectable entities
  #
  # Ex:
  #
  #     class Player extends Kona.Entity
  #       constructor: (opts={}) ->
  #         super(opts)
  #         @collects('coins', 'weapons')
  #
  # See Kona.Collectable.
  #
  collects: (names...) ->
    Kona.Collectors.add(name, @) for name in names


  # Alias `collects()` as `triggers()`
  @::triggers = @::collects



  # ---------------------
  # Animations
  # ---------------------
  # TODO: DOCS
  #
  # Internal:
  loadAnimations: ->
    animations = Kona.Animations["#{@group}:#{@class()}"]
    return unless animations?

    for name, opts of animations
      animOpts = Kona.Utils.merge { entity: @, name: name, width: @box.width, height: @box.height  }, opts
      @animations[name] = new Kona.Animation(animOpts)
      @setAnimation(name) if animOpts.active == true


  # Public: Set the current animation
  #
  # name - The name of the animation to change to, ex: 'run_right'
  #
  # Raises Exception if animation not found
  # Returns nothing
  #
  setAnimation: (name) ->
    @currentAnimation = @animations[name] or fail("#{@class()}#setAnimation", "Couldn't find animation with name #{name}")


  # Public: Clear the current animation
  # Returns nothing
  clearAnimation: -> @currentAnimation = null



  # ---------------------
  # Mixins
  # ---------------------
  # Public: An interface for including composable mixins or modules
  #
  # objs... - An arbitrary list of 'module' objects, implementing functions to add to the entity
  #           e.g., `@include Killable` or `@include Killable, Resettable`
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
  # Returns nothing
  #
  include: (objs...) -> Kona.Utils.merge(@, obj) for obj in objs
