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




  # ----------------------
  #   GAME ENTITIES
  # ----------------------

  # PLAYER
  # ----------------
  class Player extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @speed      = 3
      @jumpHeight = 12
      @isJumping  = false
      @facing     = 'right'
      @canFire    = false
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
      if @right() > Kona.Canvas.width - 20
        Kona.Scenes.nextScene()
        level1_2.addEntity(player)
        player.setPosition(0, @top())


    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @color
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)


    jump: ->
      jumpDuration = 180

      if @isJumping
        return false
      else if @onSurface()
        @isJumping = true
        @position.y -= 20 # Small boost at start
        setTimeout =>
          @isJumping = false
        , jumpDuration


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
      @speed = 2

    update: ->
      super
      @addGravity()

    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @color
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)





  # ----------------------
  #   COLLECTABLES
  # ----------------------

  # Coin
  # ----------------
  class Coin extends Kona.Collectable
    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @color
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

    activate: (collector) ->
      puts "Coin activated!"




  # ----------------------
  #   WEAPONS/PROJECTILES
  # ----------------------

  # WEAPON (ABSTRACT)
  # ----------------
  class Weapon extends Kona.Collectable
    constructor: (opts={}) ->
      super(opts)
      @canFire   = true
      @recharge  = 150
      @projType  = null
      @projSound = ''
      @holder    = null

    fire: ->
      if @canFire
        projDx = if @holder.facing == 'right' then 1 else -1
        startX = if @holder.facing == 'right' then @holder.right() + 1 else @holder.left() - 30
        startY = @holder.top() + 15
        proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx }
        Kona.Scenes.currentScene.addEntity(proj)
        Kona.Sounds.play(@projSound)

        @canFire = false
        setTimeout =>
          @canFire = true
        , @recharge



  # PISTOL
  # ----------------
  class Pistol extends Weapon
    constructor: (opts={}) ->
      super(opts)
      @recharge  = 150
      @projType  = PistolProj
      @projSound = 'fire'

    activate: (collector) ->
      puts "Pistol activated!"
      @holder = collector
      collector.currentWeapon = @



  # PROJECTILE (ABSTRACT)
  # ----------------
  class Projectile extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)
      @speed = 7
      @destructibles = ['enemies']

    update: ->
      super
      @position.x += @speed * @direction.dx
      if @leftCollisions() || @rightCollisions()
        for name, list of @neighborEntities()
          for ent in list
            if @leftCollision(ent) || @rightCollision(ent)
              ent.destroy() if _.contains(@destructibles, name)
              @destroy()

      @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width



  # PISTOL PROJ
  # ----------------
  class PistolProj extends Projectile
    constructor: (opts={}) ->
      super(opts)
      @box =
        width: 15
        height: 10




  # Add the player manually so we can have a reference object to bind keys to
  player = new Player { x: 200, y: 200, width: 30, height: 55, color: 'black', group: 'player' }
  level1_1.addEntity(player)




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




  #----------------------
  #   LAYOUT
  # ----------------------
  Kona.Scenes.definitionMap = {
    '-': { group: 'tiles',   klass: Kona.BlankTile }
    'r': { group: 'tiles',   klass: Kona.Tile, opts: { color: 'red' } }
    'o': { group: 'tiles',   klass: Kona.Tile, opts: { color: 'orange' } }
    'b': { group: 'tiles',   klass: Kona.Tile, opts: { color: 'blue' } }
    'x': { group: 'enemies', klass: Enemy, opts: { width: 30, height: 55, color: '#00ffcc', offset: { x: 15 } } }
    'c': { group: 'coins',   klass: Coin, opts: { width: 30, height: 30, color: 'yellow', offset: { x: 15, y: 15 } } }
    'p': { group: 'weapons',  klass: Pistol, opts: { width: 30, height: 10, color: 'black', offset: { x: 15, y: 15 } } }
  }

  level1_1.load [
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','o','b'],
    ['r','b','-','-','-','-','-','-','r','-','-'],
    ['o','-','-','-','-','-','x','-','-','-','-'],
    ['r','-','c','o','p','-','b','o','-','-','-'],
    ['b','o','r','b','r','-','-','r','o','-','r']
  ]

  level1_2.load [
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
