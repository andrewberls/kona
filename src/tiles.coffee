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
  #     [1,0,2,3,0,0,1,2,3,1,2]
  #   ]
  # }
  buildTiles: (scene, grid) ->
    @sceneTilemap[scene] ||= []

    x = 0
    y = Kona.Canvas.height - Kona.Tile.tileSize
    rowBuffer = []

    # tiles = [
    #   [1,0,2,3,0,0,1,2,3,1,2]
    # ]
    for row in grid
      for color in row
        if color == 0
          rowBuffer.push new Kona.BlankTile { x: x, y: y }
        else
          rowBuffer.push new Kona.Tile { color: color, x: x, y: y }
        x += 60
      @sceneTilemap[scene].push rowBuffer
      rowBuffer = []

  draw: (scene) ->
    for row in @sceneTilemap[scene]
      for tile in row
        tile.draw()


  columnFor: (idx) ->
    result = []
    for row in @sceneTilemap[Kona.Scenes.currentScene.name]
      Kona.debug row
      # console.log "adding element #{row[idx]} at idx: #{idx}"
      result += row[idx]
    result

  # Return all the columns that an entity spans
  columnsFor: (entity) ->
    start = Math.floor entity.position.x / Kona.Tile.tileSize
    end   = Math.floor (entity.position.x + entity.box.width) / Kona.Tile.tileSize
    grid  = @sceneTilemap[Kona.Scenes.currentScene.name]
    result = []


    # tiles = [
    #   [1,0,2,3,0,0,1,2,3,1,2]
    # ]
    # once => Kona.debug @columnFor(1)

    # _.each [start..end], (colNum) ->


  # All tiles in a specific column
  tilesFor: (column) ->






class Kona.Tile extends Kona.Entity
  constructor: (opts) ->
    super(opts)
    @tileSize = 60

    @box =
      width:  @tileSize
      height: @tileSize

    @color = opts.color || -1
    # Kona.debug @position.x

  toString: -> "<Tile @color=#{Kona.Utils.colorFor(@color)}>"

  draw: ->
    # TODO: draw sprite
    Kona.Canvas.safe =>
      Kona.Canvas.ctx.fillStyle = Kona.Utils.colorFor(@color)
      Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

Kona.Tile.tileSize = 60


class Kona.BlankTile extends Kona.Entity
  constructor: (opts) ->
    super(opts)
    @tileSize = 60
    @solid    = false

    @box =
      width:  @tileSize
      height: @tileSize
