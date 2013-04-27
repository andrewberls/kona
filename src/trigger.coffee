# A generic class representing a node that activates a callback
# when intersecting with a designated `collector entity`
#
# TODO: trigger examples
#
class Kona.Trigger extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @solid   = false
    @gravity = false
    @pickupSound = ''


  # Test if a collector is intersecting
  # If so, activate pickup callback and destroy
  update: ->
    collectors = Kona.Collectors.for(@group)
    if collectors?
      for entity in collectors
        if @intersecting(entity)
          @activate(entity)


  # Callback invoked when picked up by the player
  # If `@pickupSound` is a string, play as a sound
  # else if `@pickupSound` is an array, choose one at random
  activate: ->
    if _.isString(@pickupSound)
      Kona.Sounds.play(@pickupSound) if @pickupSound != ''
    else if _.isArray(@pickupSound)
      sound = Kona.Utils.sample(@pickupSound)
      Kona.Sounds.play(sound)



# Internal tracking of who can collect a given collectable.
# For example, a player could pick up entities the `coins` group,
# and both players and enemies could pick up entities in the `food` group.
#
Kona.Collectors =
  store: {}


  # Use `entity.collects()` to set collectors instead of calling this directly.
  add: (group, entity) ->
    @store[group] ||= []
    @store[group].push(entity)


  # Get the collectors for a certain group
  for: (group) -> @store[group]
