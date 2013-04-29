Kona.ready ->

  describe "Kona.Tile", ->
    it "defines a tileSize", ->
      expect(Kona.Tile.tileSize).toBe(60)


    it "sets a default group", ->
      tile = new Kona.Tile
      expect(tile.group).toBe('tiles')


    it "has correct dimensions", ->
      tile = new Kona.Tile
      expect(tile.box.width).toBe(Kona.Tile.tileSize)
      expect(tile.box.height).toBe(Kona.Tile.tileSize)



  describe "Kona.BlankTile", ->
    it "is not solid", ->
      tile = new Kona.BlankTile
      expect(tile.solid).toBe(false)
