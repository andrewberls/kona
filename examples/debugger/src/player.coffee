# PLAYER
# ----------------
class Player extends Kona.Entity
  @group = 'player'

  constructor: (opts={}) ->
    super(opts)
    @speed         = 3
    @jumpHeight    = 22 # 22
    @jumpDuration  = 180 # 180
    @isJumping     = false
    @facing        = 'right'
    @canFire       = false
    @currentWeapon = null

    @isAlive   = true
    @maxHealth = 3
    @health    = @maxHealth
    @lives     = 3
    @score     = 0
    @collects('weapons', 'health', 'coins')
    @triggers('signs', 'springs', 'elevators')

    @include Resets, Paces


  update: ->
    super()

    if @isJumping
      @position.y -= @jumpHeight
      @correctTop()

    @die() if @top() > Kona.Canvas.height

    # Transition to next screen
    if @right() > Kona.Canvas.width - 20
      Kona.Scenes.nextScene()
      # Kona.Scenes.currentScene.addEntity(player) # TODO: persistent flag would be nice
      @setPosition(0, @top())


  stop: (axis) ->
    if @isAlive
      @setAnimation("idle_#{@facing}")
      super(axis)


  setDirection: (dir) ->
    if @isAlive && !Kona.gamePaused
      @direction.dx = if dir == 'left' then -1 else 1
      @setAnimation("run_#{dir}")


  # Options:
  #
  #   * __height__ - (Number) The jumpHeight to add each tick, in pixels
  #   * __duration__ - (Number) The duration of the jump, in ms
  #   * __force__ - (Boolean) Optionally override the requirement of standing on a surface
  #
  jump: (opts={}) ->
    duration = opts.duration || @jumpDuration
    if opts.height?
      oldHeight = @jumpHeight
      @jumpHeight = opts.height

    canJump = !@isJumping && !Kona.gamePaused && @onSurface()
    if opts.force == true || canJump
      @isJumping = true
      @position.y -= 25 # Small boost at start

      setTimeout =>
        @isJumping = false
        @resetAnimation()
        @jumpHeight = oldHeight if oldHeight?
      , duration


  fire: ->
    if @currentWeapon? && !Kona.gamePaused
      @currentWeapon.fire()


  # TODO: variable damage amts
  hit: (dir) ->
    if @isAlive
      @health--
      puts "player hit, #{@health} hp remaining"
      if @health <= 0
        @die()
      else
        Kona.Sounds.play('player_hit')

  die: (dir='right') ->
    if @isAlive
      @stop()
      @isAlive = false
      @lives--
      Kona.Sounds.play('player_die')
      if @lives <= 0
        puts "Game over" # TODO: implement
      else
        @setAnimation("die_right") # TODO: die_#{dir}


  reset: ->
    @facing = 'right'
    @resetAnimation()
    @setPosition(195, 200)
    @health  = @maxHealth
    @isAlive = true
