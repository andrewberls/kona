# A generic class representing an object that can be
# picked up by an entity (powerups, weapons, etc)

# A callback is automatically activated when
# a collector entity intersects with the collectable.

# See Entity#collects for more info on collectors.
class Kona.Collectable extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @solid   = false
    @gravity = false

  # TODO: bob up and down?
  update: ->
    for entity in Kona.Collectors[@group]
      if @intersecting(entity)
        @activate()
        @destroy()

  draw: ->
    Kona.Canvas.safe =>
      Kona.Canvas.ctx.fillStyle = @color
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

  # Callback invoked when picked up by the player
  activate: -> fail("Implement activate() in a derived Collectable class")


# Internal tracking of who can collect a given collectable.
# For example, a player could pick up coins,
# and both players and enemies could pick up food.
#
# Usage: `Kona.Collectors.add('coins', player)`
#
# Would result in a collector structure of:
#
#     {
#       'coins' : [<Player>]
#     }
Kona.Collectors =
  add: (group, entity) ->
    @[group] ||= []
    @[group].push(entity)
