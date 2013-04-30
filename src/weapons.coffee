# An generic entity class representing a collectable weapon,
# intended to be subclassed to add additional configuration.
# Built to be used with the `Kona.Projectile` interface
#
# Constructor options (in addition to `Collectable` options)
#
#   * __recharge__ - (Integer) Firing rate, in milliseconds
#   * __projType__ - (Object) The `Kona.Projectile` class that this weapon uses. Ex: `PistolProj`
#   * __sound__ - (String) The name of the firing sound
#   * __pickup__ - (String) The name of the sound played on pickup
#   * __holder__ - (Object) The `Kona.Entity` instance holding this weapon
#
class Kona.Weapon extends Kona.Collectable
  constructor: (opts={}) ->
    super(opts)
    @canFire     = true
    @recharge    = opts.recharge || 300
    @projType    = opts.projType || null
    @projSound   = opts.sound    || ''
    @pickupSound = opts.pickup   || ''
    @holder      = opts.holder   || null


  activate: (collector) ->
    super
    @holder = collector
    collector.currentWeapon = @


  fire: ->
    if @canFire
      projDx = if @holder.facing == 'right' then 1 else -1
      startX = if @holder.facing == 'right' then @holder.right() + 1 else @holder.left() - 30 # TODO
      startY = @holder.top() + 9                                                              # TODO
      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx }
      @holder.scene.addEntity(proj)
      Kona.Sounds.play(@projSound) if @projSound != ''

      @canFire = false
      setTimeout =>
        @canFire = true
      , @recharge



# A weapon class intended to be held by an enemy, which automatically fires at a set of targets
#
# Constructor options (in addition to `Weapon` options)
#
#   * __recharge__ - (Integer) Array of entiity groups to target. Will automatically select a random instance to fire at
#     Ex: 'player'
#   * __offset__ - (Object) Offset for where projectile spawns from, relative to self
#     * x: integer x-offset
#     * y: integer y-offset
#
class Kona.EnemyWeapon extends Kona.Weapon
  constructor: (opts={}) ->
    @targets    = opts.targets
    @projOffset = opts.offset || { x: 0, y: 0 }
    super(opts)


  # Return a random entity from the list of target groups
  randomTarget: ->
    targetEnts = []
    for group in @targets
      targetEnts = targetEnts.concat(Kona.Scenes.getCurrentEntities(group))
    return Kona.Utils.sample(targetEnts)


  # Fire at a random entity from all target groups
  fire: ->
    target = @randomTarget()

    if @isActive() && target.isAlive
      x = Math.abs(@holder.midx() - target.midx())  # x-distance between enemy & target
      y = Math.abs(@holder.midy() - target.midy())  # y-distance between enemy & target

      targetLeft = @holder.position.x >= target.midx()
      targetUp   = @holder.position.y >= target.midy()

      angle = Math.atan2(y, x) + (if targetUp then 0.5 else 0) # Angle between enemy and target in radians
      speed = 1

      projDx = speed * Math.cos(angle) * (if targetLeft then -1 else 1)
      projDy = speed * Math.sin(angle) * (if targetUp then -1 else 1)

      startX = if targetLeft then @holder.left()-@projOffset.x else @holder.right()+@projOffset.x
      startY = @holder.top() + @projOffset.y

      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx, dy: projDy, target: target }
      @holder.scene.addEntity(proj)
      Kona.Sounds.play(@projSound) if @projSound != ''
