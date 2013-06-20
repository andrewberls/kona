# A generic class representing a node that activates a callback
# when intersecting with a designated `collector entity`
#
# Note that the word 'trigger' here is not connected with
# triggering as defined in the `Kona.Event` interface
#
# Triggers are intended to be subclassed and extended -
# this class provides only baseline functionality,
# such as in `activate()`
#
# TODO: examples
#
# See Kona.Entity for constructor options

class Kona.Trigger extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @solid   = false
    @gravity = false
    @pickupSound = ''


  # Boolean function to check if an entity is within a given activation tolerance range
  # True by default - override in derived classes for specific behavior
  withinTolerance: (ent) -> true


  # Internal: Test if a collector is intersecting
  # If so, activate pickup callback and destroy
  #
  # TODO: trigger dir sensitivities (e.g., only top and left)
  #
  update: ->
    for entity in Kona.Collectors.for(@group)
      if @intersecting(entity) && @withinTolerance(entity)
        @activate(entity)


  # Internal: Callback invoked when picked up by the player
  # If `@pickupSound` is a string, play as a sound
  # else if `@pickupSound` is an array, choose one to play at random
  activate: ->
    if _.isString(@pickupSound)
      Kona.Sounds.play(@pickupSound) if @pickupSound != ''
    else if _.isArray(@pickupSound)
      sound = Kona.Utils.sample(@pickupSound)
      Kona.Sounds.play(sound)



# Internal tracking of who can collect a given collectable.
# For example, a player could pick up entities the `coins` group,
# and both players and enemies could pick up entities in the `food` group.
Kona.Collectors = new Kona.Store
