# An generic entity class representing a weapon projectile,
# intended to be subclassed to add additional configuration.
# Built to be used with the `Kona.Weapon` interface
#
# When a projectile collides with one of its target entities,
# it will trigger their `.hit()` method if it is available,
# passing in the direction of the collision,
# else the target entity will be destroyed
#
# Ex:
#     class PistolProj extends Kona.Projectile
#       constructor: (opts={}) ->
#         super(opts)
#         @sprite.src = 'bullet.png'
#         @box = { width: 20, height: 7 }
#         @destructibles = ['enemies']
#
class Kona.Projectile extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @target  = opts.target || null
    @speed   = opts.speed  || 10
    @gravity = false


  # Check if colliding with a target entity
  # If so, call entity.hit() if available, passing in the direction the collision is from,
  # else revert to .destroy()
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

            return @destroy()


    @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width
