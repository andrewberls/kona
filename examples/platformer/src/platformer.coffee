# Sample code for a 'game', to test the various engine functions

Kona.ready ->

  # ----------------------
  #   INITIALIZATION
  # ----------------------
  Kona.Canvas.init('canvas')

  Kona.Sounds.load {
    'fire' : 'audio/enemy_fire.ogg'
  }



  # ----------------------
  #   GAME ENTITIES
  # ----------------------

  # TILES
  # ----------------
  # TODO: LEFT, RIGHT TILES
  class DirtTile extends Kona.Tile



  # PLAYER
  # ----------------
  class Player extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @speed         = 2
      @jumpHeight    = 12
      @jumpDuration  = 180
      @isJumping     = false
      @facing        = ''
      @canFire       = false
      @currentWeapon = null
      @collects('coins', 'weapons')

    update: ->
      super()

      if @isJumping
        @position.y -= @jumpHeight
        @correctTop()
      else
        @addGravity()

      @die() if @top() > Kona.Canvas.height

      # Transition to next screen
      if @right() > Kona.Canvas.width - 20
        Kona.Scenes.nextScene()
        Kona.Scenes.currentScene.addEntity(player)    # TODO: PERSISTENT ENTITIES
        @setPosition(0, @top())


    stop: (axis) ->
      @setAnimation('idle')
      super(axis)


    setDirection: (dir) ->
      @setAnimation("run_#{dir}")
      @direction.dx = if dir == 'left' then -1 else 1


    jump: ->
      # Can only jump from standing on a surface
      if !@isJumping && @onSurface()
        @isJumping = true
        @position.y -= 20 # Small boost at start
        setTimeout =>
          @isJumping = false
          @setAnimation("run_#{@facing}") if @facing != '' && @direction.dx != 0
        , @jumpDuration


    fire: ->
      @currentWeapon.fire() if @currentWeapon?


    die: ->
      setTimeout =>
        @facing = 'right'
        @setPosition(195, 200)
      , 400



  # ENEMY
  # ----------------
  class Enemy extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @currentWeapon = new EnemyPistol { group: 'enemy_weapons', holder: @ }
      Kona.Scenes.currentScene.addEntity(@currentWeapon)

    update: ->
      super
      @addGravity()

    destroy: ->
      @currentWeapon.destroy()
      super



  # ----------------------
  #   COLLECTABLES
  # ----------------------

  # Coin
  # ----------------
  class Coin extends Kona.Collectable
    activate: (collector) ->
      puts "Coin activated!"



  # ----------------------
  #   WEAPONS/PROJECTILES
  # ----------------------

  # PISTOL
  # ----------------
  class Pistol extends Kona.Weapon
    constructor: (opts={}) ->
      super(opts)
      @recharge  = 150
      @projType  = PistolProj
      @projSound = 'fire'


  # PISTOL PROJ
  # ----------------
  class PistolProj extends Kona.Projectile
    constructor: (opts={}) ->
      super(opts)
      @destructibles = ['enemies']
      @box =
        width: 15
        height: 10

    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = 'blue'
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)


  # ENEMY PROJ
  # ----------------
  class EnemyProj extends PistolProj
    constructor: (opts={}) ->
      super(opts)
      @destructibles = []


  # ENEMY PISTOL
  # ----------------
  class EnemyPistol extends Kona.EnemyWeapon
    constructor: (opts={}) ->
      super(opts)
      @targets   = ['player']
      @recharge  = 1000
      @projType  = EnemyProj
      # @projSound = 'fire'
      setInterval =>
        @fire()
      , @recharge

    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = 'red'
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)



  # ----------------------
  #   PLAYER INIT
  # ----------------------
  # Add the player manually so we can have a reference object to bind keys to

  # ROBOT
  # ---------------------
  # player = new Player { x: 100, y: 100, width: 200, height: 200, color: 'black', group: 'player' }
  # player.loadAnimations {
  #   'idle' : { sheet: 'img/entities/robot_sheet.png', active: true, next: -> puts @ }
  # }


  # MONSTER
  # ---------------------
  player = new Player { x: 200, y: 200, width: 64, height: 64, group: 'player' }
  player.loadAnimations {
    'idle'      : { sheet: 'img/entities/monster_idle.png', active: true }
    'run_left'  : { sheet: 'img/entities/monster_run_left.png' }
    'run_right' : { sheet: 'img/entities/monster_run_right.png' }
  }

  Kona.Scenes.currentScene.addEntity(player)



  # ----------------------
  #   KEYS
  # ----------------------
  Kona.Keys.keydown = (key) ->
    switch key
      when 'left'  then player.setDirection('left')
      when 'right' then player.setDirection('right')
      when 'up'    then player.jump()
      when 'space' then player.fire()

  Kona.Keys.keyup = (key) ->
    switch key
      when 'left', 'right' then player.stop('dx')
      when 'up', 'down'    then player.stop('dy')



  #----------------------
  #   LAYOUT
  # ----------------------
  Kona.Scenes.definitionMap = {
    '-': { group: 'tiles',   entity: Kona.BlankTile }
    'r': { group: 'tiles',   entity: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'o': { group: 'tiles',   entity: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'b': { group: 'tiles',   entity: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'x': { group: 'enemies', entity: Enemy,  opts: { width: 40, height: 60, offset: { x: 15 },        sprite: 'img/entities/ninja1.png' } }
    'c': { group: 'coins',   entity: Coin,   opts: { width: 25, height: 25, offset: { x: 20, y: 20 }, sprite: 'img/powerups/coin.png'   } }
    'p': { group: 'weapons', entity: Pistol, opts: { width: 50, height: 25, offset: { x: 15, y: 15 }, sprite: 'img/weapons/pistol.png'  } }
  }


  Kona.Scenes.loadScenes [
    {
      background: 'img/backgrounds/lvl2.jpg',
      entities: [
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-','-','o','b'],
        ['r','b','-','-','-','-','-','-','r','-','-'],
        ['o','-','-','-','-','-','-','x','-','-','-'],
        ['r','c','c','o','p','-','b','o','-','-','-'],
        ['b','o','r','b','r','-','-','r','o','-','r']
      ]
    },

    {
      background: 'img/backgrounds/lvl2.jpg'
      entities: [
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','-','-','-','-','-','-'],
        ['b','r','o','-','-','-','-','-','-','-','-'],
        ['-','-','-','-','-','r','r','r','-','-','-'],
        ['-','-','-','-','r','r','-','-','-','-','-'],
        ['-','-','-','r','r','c','-','-','-','r','r'],
        ['o','b','-','r','r','r','r','r','r','r','r']
      ]
    }
  ]



  # ----------------------
  #   GAME START
  # ----------------------
  Kona.Engine.start()
