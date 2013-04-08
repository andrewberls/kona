class Kona.Projectile extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @target  = opts.target || null
    @speed   = opts.speed  || 10
    @gravity = false

  update: ->
    super()
    @position.x += @speed * @direction.dx
    if @hasLeftCollisions() || @hasRightCollisions()
      for name, list of @neighborEntities()
        for ent in list
          leftHit  = @leftCollision(ent)
          rightHit = @rightCollision(ent)
          if ent.solid && (leftHit || rightHit)
            if @target == ent || _.contains(@destructibles, name)
              # Call .hit() if available, passing in the direction the collision is from,
              # else revert to .destroy()
              if ent.hit?
                dir = if leftHit then 'right' else 'left' # Perspective of projectile
                ent.hit(dir)
              else
                ent.destroy()

            @destroy()

    @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width
