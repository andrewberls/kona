# This module is not considered part of the 'core' Kona library.
# Instead, consider it an extension providing boilerplate that may be of use.
# You may choose to use some, all, or none of it in the interest of
# implementing specific functionality yourself

class Kona.Weapon extends Kona.Collectable
  constructor: (opts={}) ->
    super(opts)
    @canFire   = true
    @recharge  = opts.recharge || 300
    @projType  = opts.projType || null
    @projSound = opts.sound    || ''
    @holder    = opts.holder   || null

  activate: (collector) ->
    @holder = collector
    collector.currentWeapon = @

  fire: ->
    if @canFire
      projDx = if @holder.facing == 'right' then 1 else -1
      startX = if @holder.facing == 'right' then @holder.right() + 1 else @holder.left() - 30 # TODO
      startY = @holder.top() + 9                                                              # TODO
      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx }
      Kona.Scenes.currentScene.addEntity(proj)
      Kona.Sounds.play(@projSound) if @projSound != ''

      @canFire = false
      setTimeout =>
        @canFire = true
      , @recharge




class Kona.EnemyWeapon extends Kona.Weapon
  constructor: (opts={}) ->
    @targets = opts.targets
    super(opts)

  # Return a random entity from the list of target groups
  randomTarget: ->
    targetEnts = []
    for group in @targets
      targetEnts = targetEnts.concat(Kona.Scenes.currentScene.entities[group])
    return _.shuffle(targetEnts)[0]

  # Fire at a random entity from all target groups
  fire: ->
    target = @randomTarget()

    if target.isAlive
      x = Math.abs(@holder.midx() - target.midx())  # x-distance between enemy & target
      y = Math.abs(@holder.midy() - target.midy())  # y-distance between enemy & target

      targetLeft = @holder.position.x >= target.midx()
      targetUp   = @holder.position.y >= target.midy()

      angle = Math.atan2(y, x) + (if targetUp then 0.5 else 0) # Angle between enemy and target in radians
      speed = 1

      projDx = speed * Math.cos(angle) * (if targetLeft then -1 else 1)
      projDy = speed * Math.sin(angle) * (if targetUp then -1 else 1)

      startX = if targetLeft then @holder.left() - 20 else @holder.right() + 20 # TODO: REMOVE HARDCODING
      startY = @holder.top() + 25

      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx, dy: projDy, target: target }
      Kona.Scenes.currentScene.addEntity(proj)
      Kona.Sounds.play(@projSound) if @projSound != ''
