class Kona.Collectable extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @solid   = false
    @gravity = false

  update: ->
    # TODO: bob up and down?
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



Kona.Collectors =
  add: (group, entity) ->
    @[group] ||= []
    @[group].push(entity)
