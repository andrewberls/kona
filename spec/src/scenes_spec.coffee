Kona.ready ->
  Kona.Canvas.init('canvas')
  main = new Kona.Scene { name: 'main', active: true }
  Kona.Engine.start()


  describe "Kona.Scenes", ->
    # addEntity (nonready + ready)
    # loadDefinitions
    # loadScenes
    # drawCurrent
    # getCurrentEntities
    # setCurrent
    # nextScene
    # find

    describe "::find", ->
      it "finds a scene by name", ->
        scene = Kona.Scenes.find("main")
        expect(scene).toEqual(main)

      it "returns null for scenes not found", ->
        scene = Kona.Scenes.find("fake")
        expect(scene).toBe(null)


describe "Kona.Scene", ->
  # addEntity
  # loadEntities
  # getEntities
  # removeEntity
  # draw
