# This module is not considered part of the 'core' Kona library.
# Instead, it is an extension which provides boilerplate that may be of use.
# You may choose to use some, all, or none of it in the interest of
# implementing specific functionality yourself

class Kona.Projectile extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @speed = 7

  update: ->
    super
    @position.x += @speed * @direction.dx
    if @leftCollisions() || @rightCollisions()
      for name, list of @neighborEntities()
        for ent in list
          if @leftCollision(ent) || @rightCollision(ent)
            ent.destroy() if _.contains(@destructibles, name)
            @destroy()

    @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width
