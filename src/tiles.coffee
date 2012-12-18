class Kona.Tile extends Kona.Entity
  @tileSize = 60

  constructor: (opts={}) ->
    super(opts)

    @size = Kona.Tile.tileSize
    @box =
      width:  @size
      height: @size

    @color = opts.color || 'black'

  toString: -> "<Tile @x=#{@position.x}, @y=#{@position.y}, @color=#{@color}>"

  update: -> # Tiles are static

  draw: ->
    Kona.Canvas.safe =>
      Kona.Canvas.ctx.fillStyle = @color
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)



class Kona.BlankTile extends Kona.Tile
  constructor: (opts) ->
    super(opts)
    @solid = false

    @size = Kona.Tile.tileSize
    @box  =
      width:  @size
      height: @size

  toString: -> "<BlankTile>"

  update: -> # Tiles are static
  draw:   -> # No sprite
