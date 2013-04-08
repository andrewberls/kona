class Kona.Tile extends Kona.Entity
  @tileSize = 60

  constructor: (opts={}) ->
    opts.group ||= 'tiles'
    super(opts)
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
