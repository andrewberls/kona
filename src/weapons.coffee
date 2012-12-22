class Kona.Weapon extends Kona.Collectable
  constructor: (opts={}) ->
    super(opts)
    @canFire   = true
    @recharge  = 150
    @projType  = null
    @projSound = ''
    @holder    = opts.holder || null

  activate: (collector) ->
    @holder = collector
    collector.currentWeapon = @

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




class Kona.EnemyWeapon extends Kona.Weapon
  fire: ->
    if @holder.active()
      x = Math.abs(@holder.midx() - @target.midx())  # x-distance between enemy & target
      y = Math.abs(@holder.midy() - @target.midy())  # y-distance between enemy & target

      targetLeft = @holder.position.x >= @target.midx()
      targetUp   = @holder.position.y >= @target.midy()

      angle = Math.atan2(y, x) + (if targetUp then 0.5 else 0) # Angle between enemy and target in radians
      speed = 0.5 # TODO

      projDx = speed * Math.cos(angle) * (if targetLeft then -1 else 1)
      projDy = speed * Math.sin(angle) * (if targetUp then -1 else 1)

      startX = if targetLeft then @holder.left() - 20 else @holder.right() + 20
      startY = @holder.top() + 25

      proj   = new @projType { group: 'projectiles', x: startX, y: startY, dx: projDx, dy: projDy }
      Kona.Scenes.currentScene.addEntity(proj)
      # Kona.Sounds.play(@projSound)
