Kona.ready ->
  Kona.Canvas.init('canvas')
  canvasScene = new Kona.Scene { name: 'canvasScene', active: true }
  Kona.Engine.start()


  describe "Kona.Canvas", ->
    describe "::init", ->
      it "throws an exception if DOM element not found", ->
        expect(->
          Kona.Canvas.init("fake")
        ).toThrow()

      it "sets default dimensions", ->
        elem = Kona.Canvas.elem
        expect(elem.getAttribute('width')).toBe('720')
        expect(elem.getAttribute('height')).toBe('540')
