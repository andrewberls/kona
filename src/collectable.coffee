# A generic class representing an object that can be
# picked up by an entity (powerups, weapons, etc)
#
# A collectable is just a trigger node that destroys on contact.
#
# See Kona.Trigger
#
class Kona.Collectable extends Kona.Trigger
  activate: ->
    super()
    @destroy()
