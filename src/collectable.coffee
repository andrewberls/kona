# A generic class representing an object that can be
# picked up by an entity (powerups, weapons, etc)

# A callback is automatically activated when
# a collector entity intersects with the collectable.

# See `entity.collects()` for more info on collectors.
class Kona.Collectable extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @solid   = false
    @gravity = false

  # TODO: bob up and down?
  update: ->
    collectors = Kona.Collectors[@group]
    if collectors?
      for entity in collectors
        if @intersecting(entity)
          @activate(entity)
          @destroy()

  # Callback invoked when picked up by the player
  activate: -> fail("Implement activate() in a derived Collectable class")


# Internal tracking of who can collect a given collectable.
# For example, a player could pick up entities the `coins` group,
# and both players and enemies could pick up entities in the `food` group.
#
# Use `entity.collects()` to set collectors instead of calling this directly.
Kona.Collectors =
  add: (group, entity) ->
    @[group] ||= []
    @[group].push(entity)
