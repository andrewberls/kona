Kona.Layout =
  definitionMap: null
  sceneTilemap: {}

  buildScene: (sceneName, grid) ->
    @definitionMap? or fail("No definition map found")
    x = 0
    y = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize)

    for row in grid
      for def in row
        rule  = @definitionMap[def] or fail("No mapping found for rule: #{def}")
        opts  = Kona.Utils.merge { x: x, y: y, group: rule.group  }, rule.opts
        obj   = new rule.klass(opts)
        scene = Kona.Utils.find(Kona.Scenes.scenes, { name: sceneName })
        scene.addEntity(obj)
        x += Kona.Tile.tileSize

      x = 0
      y += Kona.Tile.tileSize

  # Return the tileset for the current scene
  currentTiles: ->
    Kona.Scenes.currentScene.entities['tiles']


  columnFor: (idx) ->
    _.map @currentTiles(), (row) ->
      row[idx] if row[idx]?


  # Return all the columns that an entity spans
  columnsFor: (entity) ->
    size  = Kona.Tile.tileSize
    start = Math.floor entity.position.x / size
    end   = Math.floor entity.right() / size
    _.map [start..end], (idx) => @columnFor(idx)
