# An generic entity class representing a collectable weapon,
# intended to be subclassed to add additional configuration.
# Built to be used with the `Kona.Projectile` interface
#
# Constructor options (in addition to `Collectable` options)
# Public: Weapon constructor
#
# opts - Hash of attributes (Default: {})
#        Note: all options will be passed to Kona.Collectable superconstructor
#
#   recharge - Integer firing rate, in milliseconds
#   projType - Kona.Projectile class that this weapon uses. Ex: `PistolProj`
#   sound    - String name of the sound played on fire. Ex: 'playerFire'
#   pickup   - String name of the sound played on pickup. Ex: 'pistolPickup'
#   holder   - The `Kona.Entity` instance holding this weapon
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


  # Internal: Add functionality to Kona.Collectable#activate
  activate: (collector) ->
    super
    @holder = collector
    collector.currentWeapon = @


  # Internal: create/add a new projectile instance, play a sound, and set the recharge timer
  fire: ->
    if @canFire
      projDx = if @holder.facing == 'right' then 1 else -1
      startX = if @holder.facing == 'right' then @holder.right() + 1 else @holder.left() - 30 # TODO - magic numbers
      startY = @holder.top() + 9                                                              # TODO - magic numbers
      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx }
      @holder.scene.addEntity(proj)
      Kona.Sounds.play(@projSound) if @projSound != ''

      @canFire = false
      setTimeout =>
        @canFire = true
      , @recharge



# A weapon class intended to be held by an enemy, which automatically fires at a set of targets
#
# Public: Animation constructor
#
# opts - Hash of attributes (Default: {})
#        Note: all options will be passed to Kona.Weapon superconstructor
#
#   targets - Array[String] of entity group names to target.
#             Will automatically select a random entity instance from one of the groups to fire at
#             Ex: ['players', 'innocentBystanders']
#   offset -  Hash representing offset amounts  for where projectile spawns from, relative to holder's top left corner
#            (Default: {0, 0})
#     x -  Integer amount of x-offset, in pixels
#     y -  Integer amount of y-offset, in pixels
#
class Kona.EnemyWeapon extends Kona.Weapon
  constructor: (opts={}) ->
    @targets    = opts.targets
    @projOffset = opts.offset || { x: 0, y: 0 }
    super(opts)


  # Internal: Return a random entity from the list of target groups
  # Returns Kona.Entity
  randomTarget: ->
    targetEnts = []
    for group in @targets
      targetEnts = targetEnts.concat(Kona.Scenes.getCurrentEntities(group))
    return Kona.Utils.sample(targetEnts)


  # Internal: Calculate coordinates and fire at a target
  #
  # target: A Kona.Entity instance to fire at (Optional - entity chosen randomly from target groups
  #         if not provided)
  #
  # Returns nothing
  #
  fire: (target=null) ->
    target ?= @randomTarget()

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
