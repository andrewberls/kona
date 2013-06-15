Kona.ready ->
  Kona.Canvas.init('canvas')
  collectableScene = new Kona.Scene { name: 'collectableScene', active: true }
  Kona.Engine.start()

  describe "Kona.Collectable", ->
    describe "#activate", ->
      it "destroys on activation", ->
        item = new Kona.Collectable(group: 'items', x: 0, y: 0)
        collectableScene.addEntity(item)
        expect(collectableScene.entities.get('items')).toContain(item)
        item.activate()
        expect(collectableScene.entities.get('items')).toNotContain(item)
