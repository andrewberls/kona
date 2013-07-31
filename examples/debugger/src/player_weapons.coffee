class PlayerWeapon extends Kona.Weapon
  fire: ->
    if @canFire
      @holder.setAnimation("fire_#{@holder.facing}")

      startX = if @holder.facing == 'right' then @holder.right()+2 else @holder.left()-17
      Kona.Scenes.currentScene.addEntity new Effect {
        x: startX, y: @holder.top()+2,
        duration: 30, sprite: @effect()
      }
    super()



# PISTOL
# ----------------
class Pistol extends PlayerWeapon
  @group: 'weapons'

  constructor: (opts={}) ->
    super(opts)
    @recharge     = 500
    @projType     = PistolProj
    @projSound    = 'player_fire'
    @pickupSound  = 'weapon_pickup'

  effect: -> "img/effects/rifle_fire_#{@holder.facing}.png"


# PISTOL PROJ
# ----------------
class PistolProj extends Kona.Projectile
  constructor: (opts={}) ->
    super(opts)
    @sprite.src = 'img/weapons/bullet_1.png'
    @box = { width: 20, height: 7 }
    @destructibles = ['enemies'] # TODO: don't like this interface




# RIFLE
# ----------------
class Rifle extends PlayerWeapon
  constructor: (opts={}) ->
    super(opts)
    @recharge    = 500
    @projType    = RifleProj
    @projSound   = 'player_fire'
    @pickupSound = 'weapon_pickup'

  effect: -> "img/effects/rifle_fire_#{@holder.facing}.png"


# RIFLE PROJ
# ----------------
class RifleProj extends Kona.Projectile
  constructor: (opts={}) ->
    super(opts)
    @sprite.src = 'img/weapons/bullet_2.jpg'
    @destructibles = ['enemies']

