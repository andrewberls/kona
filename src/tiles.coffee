# Cache of
#   N = Screen Width/Tile width + 2 in X and
#   N = Screen Height/Tile height + 2 in Y
# number of tiles in order to keep the screen full constantly.

Kona.TileManager =
  sceneTilemap: {}
  tiles: []

  # Load debugging tiles from a grid configuration
  # {
  #   'level-1': [
  #     [1,0,2,3,0,0,1,2,3,1,2],
  #     [0,0,0,0,0,0,0,0,0,0,2],
  #   ]
  # }
  buildTiles: (scene, grid) ->
    @sceneTilemap[scene] ||= []
    x = 0
    y = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize)
    rowBuffer = []

    for row in grid
      for color in row
        tile =
          if color == 0
            new Kona.BlankTile { x: x, y: y }
          else
            new Kona.Tile { color: color, x: x, y: y }

        rowBuffer.push tile
        x += Kona.Tile.tileSize

      x = 0
      y += Kona.Tile.tileSize
      @sceneTilemap[scene].push rowBuffer
      rowBuffer = []

  draw: (scene) ->
    for row in @sceneTilemap[scene]
      for tile in row
        tile.draw()


  columnFor: (idx) ->
    _.map @sceneTilemap[Kona.Scenes.currentScene.name], (row) -> row[idx]


  # Return all the columns that an entity spans
  columnsFor: (entity) ->
    start = Math.floor entity.position.x / Kona.Tile.tileSize
    end   = Math.floor entity.right() / Kona.Tile.tileSize
    _.map [start..end], (idx) => @columnFor(idx)



class Kona.Tile extends Kona.Entity
  @tileSize = 60

  constructor: (opts={}) ->
    super(opts)

    @size = Kona.Tile.tileSize
    @box =
      width:  @size
      height: @size

    @color = opts.color || -1

  toString: -> "<Tile @x=#{@position.x}, @y=#{@position.y}, @color=#{Kona.Utils.colorFor(@color)}>"

  draw: ->
    Kona.Canvas.safe =>
      Kona.Canvas.ctx.fillStyle = Kona.Utils.colorFor(@color)
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)



class Kona.BlankTile extends Kona.Tile
  constructor: (opts) ->
    super(opts)
    @solid    = false

    @size = Kona.Tile.tileSize
    @box =
      width:  @size
      height: @size

  toString: -> "<BlankTile>"

  draw: ->
    # Kona.Canvas.ctx.strokeRect(@position.x, @position.y, @box.width, @box.height)
