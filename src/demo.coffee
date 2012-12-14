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
  class Player extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @speed      = 3
      @jumpHeight = 12
      @isJumping  = false
      @facing     = 'right'

    update: ->
      super

      if @isJumping
        @position.y -= @jumpHeight
        @correctTop()
      else
        @addGravity()
        @correctBottom()

      @die() if @top() > Kona.Canvas.height

    draw: ->
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

    jump: ->
      duration = 180

      if @isJumping
        return false
      else if @onSurface()
        @isJumping = true
        @position.y -= 20 # TODO
        setTimeout =>
          @isJumping = false
        , duration


    fire: ->
      projDx = if @facing == 'right' then 1 else -1
      color = Kona.Utils.randomFromTo(1, 3)
      level.addEntity(new Projectile { x: @right(), y: @top(), width: 20, height: 10, dx: projDx, color: color })


    die: ->
      setTimeout =>
        @facing = 'right'
        @setPosition(195, 200)
      , 400





  class  Projectile extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @color = opts.color
      @speed = 7 * @direction.dx

    update: ->
      super
      @position.x += @speed
      @destroy() if @leftCollision() || @rightCollision()


    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @colorName()
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)





  player = new Player { x: 220, y: 200, width: 30, height: 60 }
  level.addEntity(player)










  # ----------------------
  #   KEYS
  # ----------------------
  Kona.Keys.keydown = (key) ->
    switch key
      when 'left'  then player.direction.dx = -1
      when 'right' then player.direction.dx = 1
      when 'up'    then player.jump()
      when 'space' then player.fire()

  Kona.Keys.keyup = (key) ->
    switch key
      when 'left', 'right' then player.stop('dx')
      when 'up', 'down'    then player.stop('dy')







  tiles = [
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,2,3,1],
    [1,3,0,0,0,0,0,0,0,0,2],
    [2,0,0,0,0,0,0,0,0,0,3],
    [1,0,0,2,0,0,3,2,3,0,2],
    [3,2,1,3,1,0,0,1,2,0,1]
  ]
  Kona.TileManager.buildTiles('level-1', tiles)



  # ----------------------
  #   GAME START
  # ----------------------
  # Start the engine! The game is running after this point.
  Kona.Engine.start {
    id: 'canvas'
  }




  # SOUND TESTS
  # -----------------------------------------------------

  # SOUND PLAY
  # ----------------
  # fire = new Kona.Sound('enemy_fire.ogg')
  # setTimeout ->
  #   fire.play()
  # , 500
  #
  # music = new Kona.Sound('level1_music.ogg')
  # music.play()

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
