# A stompable turtle enemy


class Turtle extends Enemy
  @group: 'enemies'

  constructor: (opts={}) ->
    super(opts)
    @box    = { width:  50, height: 55 }
    @facing = 'left'
    @direction.dx = -1
    @target = 'player'
    @health = 1


  # It's important that we check player hits before correcting collisions
  update: ->
    @checkPlayer()
    super()
    @pace()


  # Check if we're colliding with player
  #   left/right - damage player and push back
  #   top - die!
  #
  checkPlayer: ->
    for ent in Kona.Scenes.getCurrentEntities(@target)
      if @topCollision(ent)
        @die()
      else if @leftCollision(ent)
        ent.hit()
        ent.position.x -= 75
      else if @rightCollision(ent)
        ent.hit()
        ent.position.x += 75


  die: ->
    @isAlive = false
    @stop()
    Kona.Sounds.play('turtle_die')
    @setAnimation('die')
