# This module is not considered part of the 'core' Kona library.
# Instead, consider it an extension providing boilerplate that may be of use.
# You may choose to use some, all, or none of it in the interest of
# implementing specific functionality yourself

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
          if ent.solid && (@leftCollision(ent) || @rightCollision(ent))
            if @target == ent || _.contains(@destructibles, name)
              if ent.hit? then ent.hit() else ent.destroy()

            @destroy()

    @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width
