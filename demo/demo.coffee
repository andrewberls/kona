# Sample code for a 'game', to test the various engine functions

Kona.ready ->

  # ----------------------
  #   INITIALIZATION
  # ----------------------
  Kona.Canvas.init('canvas')

  Kona.Sounds.load {
    'fire' : 'enemy_fire.ogg'
  }

  level1_1 = new Kona.Scene {
    name: 'lvl1:s1'
    background: 'lvl2.jpg'
    active: true
  }

  level1_2 = new Kona.Scene {
    name: 'lvl1:s2'
    background: 'lvl2.jpg'
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
      @canFire    = true
      @collects('coins')

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
      if @canFire
        projDx = if @facing == 'right' then 1 else -1
        startX = if @facing == 'right' then @right() + 1 else @left() - 30
        startY = @top() + 15
        color  = ['red','orange','blue'][Kona.Utils.randomFromTo(0, 2)]
        proj   = new Projectile { x: startX, y: startY, width: 20, height: 10, dx: projDx, color: color, group: 'projectiles' }
        Kona.Scenes.currentScene.addEntity(proj)
        Kona.Sounds.play('fire')

        @canFire = false
        setTimeout =>
          @canFire = true
        , 150


    die: ->
      setTimeout =>
        @facing = 'right'
        @setPosition(195, 200)
      , 400




  # PROJECTILE
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
        # Detect collisions with other entities
        # TODO: this is hacky
        for name, list of Kona.Scenes.currentScene.entities
          list = _.reject list, (ent) => ent == @
          for ent in list
            if @leftCollision(ent) || @rightCollision(ent)
              ent.destroy() if _.contains(@destructibles, name)
              @destroy()

      @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width


    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @color
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)




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




  # Coin
  # ----------------
  class Coin extends Kona.Collectable
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

    activate: ->
      puts "Coin activated!"




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
  }

  level1_1.load [
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','-','-'],
    ['-','-','-','-','-','-','-','-','-','o','b'],
    ['r','b','-','-','-','-','-','-','r','-','-'],
    ['o','-','-','-','-','-','x','-','-','-','-'],
    ['r','-','c','o','-','-','b','o','-','-','-'],
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
