# Sample code for a 'game', to test the various engine functions

Kona.ready ->

  # ----------------------
  #   INITIALIZATION
  # ----------------------
  Kona.Canvas.init('canvas')

  Kona.Sounds.load {
    'fire' : 'audio/enemy_fire.ogg'
  }

  level1_1 = new Kona.Scene {
    name: 'lvl1:s1'
    background: 'img/backgrounds/lvl2.jpg'
    active: true
  }

  level1_2 = new Kona.Scene {
    name: 'lvl1:s2'
    background: 'img/backgrounds/lvl2.jpg'
  }

  pauseMenu = new Kona.Menu {
    name: 'pauseMenu'
    trigger: 'escape'
    options: {
      'Resume Game'   : -> Kona.Scenes.setCurrent('lvl1:s1')
      'Something One' : -> console.log "something one"
      'Something Two' : -> console.log "something two"
    }
  }

  # ----------------------
  #   GAME ENTITIES
  # ----------------------

  # TILES
  # ----------------
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
      @facing        = 'right'
      @canFire       = false
      @currentWeapon = null
      @collects('coins', 'weapons')

    update: ->
      super

      if @isJumping
        @position.y -= @jumpHeight
        @correctTop()
      else
        @addGravity()

      @die() if @top() > Kona.Canvas.height

      # Transition to next screen
      # TODO: DISABLED FOR ANIM DEMO
      # if @right() > Kona.Canvas.width - 20
      #   Kona.Scenes.nextScene()       # TODO - BETTER SCENE/LEVEL DIFFERENTIATION
      #   level1_2.addEntity(player)    # TODO: PERSISTENT ENTITIES
      #   player.setPosition(0, @top())


    setDir: (dir) ->
      @direction.dx = if dir == 'left' then -1 else 1
      @setAnimation("run_#{dir}")

    stop: (axis) ->
      @setAnimation('idle')
      super(axis)

    jump: ->
      # Can only jump from standing on a surface
      if !@isJumping && @onSurface()
        @isJumping = true
        @position.y -= 20 # Small boost at start
        setTimeout =>
          @isJumping = false
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
      level1_1.addEntity(@currentWeapon)

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


  # Add the player manually so we can have a reference object to bind keys to
  # player = new Player { x: 200, y: 200, width: 40, height: 55, color: 'black', group: 'player' }


  # player = new Player { x: 100, y: 100, width: 200, height: 200, color: 'black', group: 'player' }
  # player.loadAnimations {
  #   'idle' : { sheet: 'img/entities/robot_sheet.png' }
  # }
  # player.setAnimation('idle')


  player = new Player { x: 200, y: 200, width: 64, height: 64, color: 'black', group: 'player' }
  player.loadAnimations {
    'idle'      : { sheet: 'img/entities/monster_idle.png' }
    'run_left'  : { sheet: 'img/entities/monster_run_left.png' }
    'run_right' : { sheet: 'img/entities/monster_run_right.png' }
  }
  player.setAnimation('idle')

  level1_1.addEntity(player)



  # ----------------------
  #   KEYS
  # ----------------------
  Kona.Keys.keydown = (key) ->
    switch key
      when 'left'  then player.setDir('left')
      when 'right' then player.setDir('right')
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
    '-': { group: 'tiles',    klass: Kona.BlankTile }
    'r': { group: 'tiles',    klass: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'o': { group: 'tiles',    klass: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'b': { group: 'tiles',    klass: DirtTile, opts: { sprite: 'img/tiles/dirt1.png' } }
    'x': { group: 'enemies',  klass: Enemy,  opts: { width: 40, height: 60, offset: { x: 15 },        sprite: 'img/entities/ninja1.png' } }
    'c': { group: 'coins',    klass: Coin,   opts: { width: 25, height: 25, offset: { x: 20, y: 20 }, sprite: 'img/powerups/coin.png'   } }
    'p': { group: 'weapons',  klass: Pistol, opts: { width: 50, height: 25, offset: { x: 15, y: 15 }, sprite: 'img/weapons/pistol.png'  } }
  }

  level1_1.loadEntities [
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','o','b'],
    ['r','b','-','-','-','-','-','-','r','-','-'],
    ['o','-','-','-','-','-','-','x','-','-','-'],
    ['r','c','c','o','p','-','b','o','-','-','-'],
    ['b','o','r','b','r','-','-','r','o','-','r']
  ]



  # level1_1.loadEntities [
  #   ['-','-','-','-','-','-','-','-','-','-','-'],
  #   ['-','-','-','-','-','-','-','-','-','-','-'],
  #   ['-','-','-','-','-','-','-','-','-','-','-'],
  #   ['-','-','-','-','-','-','-','-','-','-','-'],
  #   ['-','-','-','-','-','-','-','-','-','-','-'],
  #   ['-','-','-','-','-','-','-','-','-','-','r'],
  #   ['-','-','-','-','-','-','-','-','-','r','r'],
  #   ['b','o','r','b','r','r','r','r','o','r','r']
  # ]



  level1_2.loadEntities [
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['b','r','o','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','r','r','r','-','-','-'],
    ['-','-','-','-','r','r','-','-','-','-','-'],
    ['-','-','-','r','r','c','-','-','-','r','r'],
    ['o','b','-','r','r','r','r','r','r','r','r']
  ]




  # ----------------------
  #   GAME START
  # ----------------------
  Kona.Engine.start()
