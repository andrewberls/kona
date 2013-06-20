# An generic entity class representing a weapon projectile,
# intended to be subclassed to add additional configuration.
# Built to be used with the `Kona.Weapon` interface
#
# When a projectile collides with one of its target entities,
# it will trigger their `.hit()` method if it is available,
# passing in the direction of the collision,
# else the target entity will be destroyed



# Public: Projectile constructor
#
# opts - Hash of attributes (Default: {})
#        Note: all options will be passed to Kona.Entity superconstructor
#   target - Kona.Entity instance that this projectile is targeting
#   speed  - Integer speed modifier of the projectile (Default: 10)
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


  # Internal: Check if colliding with a target entity
  # If so, call entity.hit() if available, passing in the direction the collision is from,
  # else revert to .destroy()
  update: ->
    super()
    @position.x += @speed * @direction.dx
    if @hasLeftCollisions() || @hasRightCollisions()
      for ent in @neighborEntities()
        leftHit  = @leftCollision(ent)
        rightHit = @rightCollision(ent)
        if ent.solid && (leftHit || rightHit)
          if @target == ent || _.contains(@destructibles, group)
            # Call .hit() if available, passing in the direction the collision is from,
            # else revert to .destroy()
            if ent.hit?
              dir = if leftHit then 'right' else 'left' # Perspective of projectile
              ent.hit(dir)
            else
              ent.destroy()

          return @destroy()


    @destroy() if @position.x < 0 || @position.x > Kona.Canvas.width
