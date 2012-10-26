# An abstract renderable screen object.
# An entity belongs to a scene.

class Kona.Entity
  constructor: (opts={}) ->
    @solid = true

    @position =
      x: opts.x || 0
      y: opts.y || 0

    @direction =
      dx: opts.dx || 0
      dy: opts.dy || 0

    @box =
      width:  opts.width   || 0
      height: opts.height || 0

    # TODO: Kona.Sprite /sheet ?
    @sprite = new Image()
    @sprite.src = ''

  # Punt if not defined in child class
  update: ->
  draw: ->

  # Standard edge coordinates
  top:    -> @position.y
  bottom: -> @position.y + @box.height
  left:   -> @position.x
  right:  -> @position.x + @box.width

  # Edge coordinates accounting for current motion
  futureTop:    -> @position.y + @direction.dy
  futureBottom: -> @position.y + @direction.dy + @box.height
  futureLeft:   -> @position.x + @direction.dx
  futureRight:  -> @position.x + @direction.dx + @box.width

  # onSuface = ->

  # function intersecting(a, b) {
  #        return !(
  #            ((a.y + a.height) < (b.y)) ||
  #            (a.y > (b.y + b.height))   ||
  #            ((a.x + a.width) < b.x)    ||
  #            (a.x > (b.x + b.width))
  #        );
  #     }
  intersecting: (e) ->
    if e?
      test = !(
        (@bottom() < e.top())    ||
        (@top()    > b.bottom()) ||
        (@right    < e.left())   ||
        (@left()   > e.right())
      )

    if test
      Kona.debug "intersecting"
      return true

  stop: (axis) ->
    # TODO: factor out accepted axes. Enforce?
    if axis?
      _.contains(['dx', 'dy'], axis) || throw new Error("Axis #{axis} not recognized")
      @direction[axis] = 0

