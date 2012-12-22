class Kona.Tile extends Kona.Entity
  @tileSize = 60

  constructor: (opts={}) ->
    super(opts)
    @sprite    = new Kona.Sprite('img/tiles/dirt1.png')
    @size = Kona.Tile.tileSize
    @box =
      width:  @size
      height: @size

  update: -> # Tiles are static



class Kona.BlankTile extends Kona.Tile
  constructor: (opts) ->
    super(opts)
    @solid = false

  update: -> # Tiles are static
  draw:   -> # No sprite
