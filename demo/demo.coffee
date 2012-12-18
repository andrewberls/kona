# Sample code for a 'game', to test the various engine functions

Kona.ready ->

  Kona.Canvas.init { id: 'canvas' }

  # ----------------------
  #   SCENES
  # ----------------------
  level1_1 = new Kona.Scene {
    name: 'lvl1:s1'
    background: 'lvl2.jpg'
    active: true
  }
  level1_2 = new Kona.Scene {
    name: 'lvl1:s2'
    background: 'lvl2.jpg'
  }

  Kona.TileManager.buildTiles 'lvl1:s1', [
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,2,3],
    [1,3,0,0,0,0,0,0,1,0,0],
    [2,0,0,0,0,0,0,0,0,0,0],
    [1,0,0,2,0,0,3,2,0,0,0],
    [3,2,1,3,1,0,0,1,2,0,1]
  ]

  Kona.TileManager.buildTiles 'lvl1:s2', [
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [3,1,2,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,0,0,0],
    [0,0,0,0,1,1,0,0,0,0,0],
    [0,0,0,1,1,0,0,0,0,1,1],
    [2,3,0,1,1,1,1,1,1,1,1]
  ]



  # ----------------------
  #   GAME ENTITIES
  # ----------------------

  # PLAYER
  # ----------------
  class Player extends Kona.Entity
    constructor: (opts={}) ->
      super(opts)

      @color = opts.color # TODO: FOR DEBUGGING

      @speed      = 3
      @jumpHeight = 12
      @isJumping  = false
      @facing     = 'right'
      @canFire    = true

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
        # Kona.Scenes.setCurrent('lvl1:s2')
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
        Kona.Scenes.currentScene.addEntity(new Projectile { x: startX, y: startY, width: 20, height: 10, dx: projDx, color: color })

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
      @color = opts.color
      @speed = 7

    update: ->
      super
      @position.x += @speed * @direction.dx
      if @leftCollision() || @rightCollision()
        # Detect collisions with other entities
        # TODO: this is hacky
        entities = _.reject Kona.Scenes.currentScene.entities, (ent) => ent == @
        for ent in entities
          if @right() > ent.left()  && @left()  < ent.right() ||
             @left()  < ent.right() && @right() > ent.left()
            ent.destroy()
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
      @color = opts.color
      @speed = 2

    update: ->
      super
      @position.x += @speed * @direction.dx
      @addGravity()

    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @color
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)




  player = new Player { x: 200, y: 200, width: 30, height: 55, color: 'black' }
  enemy  = new Enemy { x: 400, y: 250, width: 30, height: 55, color: '#00ffcc' }

  level1_1.addEntity(enemy)
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



  # ----------------------
  #   GAME START
  # ----------------------
  # Start the engine! The game is running after this point.
  Kona.Engine.start()
