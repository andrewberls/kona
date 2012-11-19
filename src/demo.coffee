# Sample code for a 'game', to test the various engine functions
# in a more real environment. Kept in a single file for manageability
# during development - no point in splitting things up here.


Kona.ready ->

  # Debugging methods
  # Is a section of code being called?
  Kona.beat = -> console.log "Heartbeat!"

  # Do something only once (useful for debugging within run loops).
  # Ex:
  #   while true
  #     once -> console.log "This will only be logged once"
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
    constructor: (opts={}) ->
      @jumpHeight = 12
      @isJumping = false
      super

    # Use the dx/dy attributes to update position, accounting for canvas bounds
    update: ->
      @direction.dx = 0 if @leftCollision() or @rightCollision()
      @position.x += @direction.dx

      if @isJumping
        Kona.debug "jumping"
        @position.y -= @jumpHeight unless @topCollision()
      else
        if @bottomCollision()
          # Kona.debug "bottom col"
        else
          # Kona.debug "grav"
          @addGravity()

    draw: ->
      Kona.Canvas.highlightColumn(@position.x); Kona.Canvas.highlightColumn(@right())
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


  shape = new Shape { x: 220, y: 200, width: 30, height: 60 }
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
    [1,0,0,2,0,0,3,2,3,0,2],
    [3,0,2,3,1,0,0,1,2,0,1]
  ]
  Kona.TileManager.buildTiles('level-1', tiles)



  # ----------------------
  #   GAME START
  # ----------------------
  # Start the engine! The game is running after this point.
  Kona.Engine.start {
    id: 'canvas'
  }

  # fire = new Kona.Sound('enemy_fire.ogg')
  # setTimeout ->
  #   fire.play()
  # , 500

  music = new Kona.Sound('level1_music.ogg')
  music.play()


  # MUTE
  # ----------------
  # setTimeout ->
  #   console.log "muting"
  #   music.toggleMute() # or music.mute()
  # , 1000
  # setTimeout ->
  #   console.log "unmuting"
  #   music.toggleMute() # or music.unmute()
  # , 2000


  # PAUSE
  # ----------------
  # setTimeout ->
  #   music.pause()
  #   console.log music.isPaused()
  # , 1000
  # setTimeout ->
  #   music.play()
  #   console.log music.isPaused()
  # , 2000


  # VOLUME MODIFIERS
  # ----------------
  # setInterval ->
  #   music.decreaseVolume()
  # , 100


  # DURATION ACCESSORS
  # ----------------
  # setInterval ->
  #   Kona.debug music.getTime()
  # , 500
