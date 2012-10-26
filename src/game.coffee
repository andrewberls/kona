# Sample code for a 'game', to test the various engine functions
# in a more real environment. Kept in a single file for manageability
# during development - no point in splitting things up here.


Kona.ready ->


  # DEBUGGING UTILS
  window.KUtils  = Kona.Utils
  window.KCanvas = Kona.Canvas
  window.KEngine = Kona.Engine
  window.KScenes = Kona.Scenes
  window.KEntity = Kona.Entity
  window.KTiles  = Kona.TileManager
  window.KKeys   = Kona.Keys
  window.KSound  = Kona.Sound
  Kona.beat = -> console.log "Heartbeat!"
  window._k_once = 0; window.once = (fxn) -> fxn() if window._k_once == 0; window._k_once++




  Kona.Canvas.init {
    id: 'canvas'
  }



  # ----------------------
  #   SCENES
  # ----------------------
  # menu = new Kona.Scene {
  #   name: 'menu-1'
  #   background: 'lvl1.jpg'
  #   active: true
  # }

  level = new Kona.Scene {
    name: 'level-1'
    # background: 'lvl2.jpg',
    active: true
  }










  # ----------------------
  #   LAYOUT
  # ----------------------
  # TODO: how to bind methods on entities defined with the schema loader?
  # Maybe schema loader is only for things like blocks, etc?

  # level.setLayout [
  #   {
  #     entity: Ball,
  #     layout: [
  #       {x: 10, y:20, width: 75, height: 50},
  #       {x: 75, y: 100, width: 75, height: 50}
  #     ]
  #   }
  # ]










  # ----------------------
  #   GAME ENTITIES
  # ----------------------
  # A sample game entity to test rendering and schema loading
  class Shape extends Kona.Entity
    constructor: (opts) ->
      @isJumping = false
      super

    # Use the dx/dy attributes to update position, accounting for canvas bounds
    update: ->
      # TODO: these are placeholders
      floor      = Kona.Canvas.height
      jumpHeight = 12
      grav       = 5

      # Left Collisions
      if @futureLeft() < 0 || (@leftCollision() && @movingLeft())
        @direction.dx = 0

      # Right collisions
      if @futureRight() > Kona.Engine.C_WIDTH || (@rightCollision() && @movingRight())
        @direction.dx = 0

      @position.x += @direction.dx

      if @isJumping
        # Move up unless restricted by ceiling
        @position.y += if @futureTop() < 0 then 0 else -jumpHeight
      else if @bottom() < floor
        # TODO: check for vert collisions and adjust grav increment to pull to nearest bottom tile

        # Pull the player down if above the floor
        @position.y += if @bottom() + grav > floor then floor - @bottom() else grav

    draw: ->
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

    jump: ->
      # TODO: Must be standing on surface to jump
      duration = 175

      if @isJumping
        return false
      else
        @isJumping = true
        setTimeout =>
          @isJumping = false
        , duration


  shape = new Shape { x: 260, y: 200, width: 30, height: 60 }
  level.addEntity(shape)










  # ----------------------
  #   KEYS
  # ----------------------
  moveIncrement = 3

  Kona.Keys.keydown = (key) ->
    switch key
      when 'left'  then shape.direction.dx = -moveIncrement
      when 'right' then shape.direction.dx = moveIncrement
      when 'up'    then shape.jump()

  Kona.Keys.keyup = (key) ->
    switch key
      when 'left', 'right' then shape.stop('dx')
      when 'up', 'down'    then shape.stop('dy')







  tiles = [
    [0,0,0,0,0,0,0,0,2,3,1],
    [0,0,0,0,0,0,0,0,0,0,2],
    [0,0,0,0,0,0,0,0,0,0,3],
    [1,0,2,3,0,0,1,2,3,0,2],
    [3,0,1,2,3,0,0,1,2,0,1]
  ]
  Kona.TileManager.buildTiles('level-1', tiles)



  # ----------------------
  #   GAME START
  # ----------------------
  # Start the engine! The game is running after this point.
  Kona.Engine.start {
    id: 'canvas'
  }
