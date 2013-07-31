class Enemy extends Kona.Entity
  constructor: (opts={}) ->
    super(opts)
    @isAlive = true
    @speed   = 0.5
    @include Resets, Paces


  hit: ->
    @health--
    @die() if @health <= 0


  update: ->
    # Don't fall off edges
    @direction.dx = 1  if @bottomLeftNeighbor()  instanceof Kona.BlankTile
    @direction.dx = -1 if @bottomRightNeighbor() instanceof Kona.BlankTile

    super()
