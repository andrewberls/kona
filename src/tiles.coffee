# A generic entity class representing a solid tile with a background image
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


# A generic entity representing an `air` tile with no background
class Kona.BlankTile extends Kona.Tile
  constructor: (opts) ->
    super(opts)
    @solid = false

  update: -> # Tiles are static
  draw:   -> # No sprite
