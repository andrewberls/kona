Kona.TileManager =
  sceneTilemap: {}

  # TODO: FOR DEBUGGING
  # Load test tiles from a grid configuration
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


  # Return the tileset for the current scene
  currentTiles: ->
    @sceneTilemap[Kona.Scenes.currentScene.name]


  columnFor: (idx) ->
    _.map @currentTiles(), (row) -> row[idx]


  # Return all the columns that an entity spans
  columnsFor: (entity) ->
    size  = Kona.Tile.tileSize
    start = Math.floor entity.position.x / size
    end   = Math.floor entity.right() / size
    _.map [start..end], (idx) => @columnFor(idx)


  # TODO
  # Return all the rows that an entity spans
  # rowsFor: (entity) ->
  #   size  = Kona.Tile.tileSize
  #   start = Math.floor(entity.position.y / size) - 1
  #   end   = Math.floor(entity.bottom() / size) - 1
  #   _.map [start..end], (idx) => @currentTiles()[idx]


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

  # TODO: FOR DEBUGGING
  colorName: -> Kona.Utils.colorFor(@color)


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
    # Grid for blank tiles
    # TODO
    Kona.Canvas.ctx.strokeRect(@position.x, @position.y, @box.width, @box.height)
