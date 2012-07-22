# An abstract renderable screen object.
# An entity belongs to a scene.

class Kona.Entity
  constructor: ->
    @position =
      x: 0
      y: 0

    @direction =
      dx: 0
      dy: 0

    @box =
      width: 0
      height: 0

    @sprite = new Image() # TODO: Kona.Sprite /sheet ?
    @sprite.src = ''
