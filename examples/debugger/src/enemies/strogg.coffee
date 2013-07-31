class Strogg extends Enemy
  @group: 'enemies'

  constructor: (opts={}) ->
    super(opts)
    @box     =  { width: 45, height: 59 }
    @facing  = 'left'
    @target  = 'player'
    @health  = 1
    @currentWeapon = new StroggPistol { group: 'strogg_weapons', holder: @, targets: [@target], offset: { x: 25, y: 25 } }
    @scene.addEntity(@currentWeapon)


  # TODO: smart pacing and targeting
  update: ->
    super()
    # target = Kona.Scenes.getCurrentEntities(@target)[0]
    # if @inRowSpace(target) && !@isFacing(target)
    #   @reverse()
    # else
    #   @pace()
    @pace()


  die: ->
    # Kona.Sounds.play('strogg_die')
    @currentWeapon.destroy()
    @destroy()



class StroggPistol extends Kona.EnemyWeapon
  constructor: (opts={}) ->
    super(opts)
    @recharge  = 1000
    @projType  = StroggProj
    # @projSound = 'strogg_fire' # TODO: find sound
    @fireLoop  = setInterval =>
      target = @randomTarget()
      @fire(target) if @holder.isFacing(target)
    , @recharge


  destroy: ->
    clearInterval(@fireLoop)
    super()


class StroggProj extends Kona.Projectile
  constructor: (opts={}) ->
    super(opts)
    @sprite.src = 'img/weapons/strogg_bullet.png'
