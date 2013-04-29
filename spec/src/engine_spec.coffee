Kona.ready ->

  describe "Kona.Engine", ->
    Kona.Canvas.init('canvas')


    describe "::queue", ->
      it "queues functions if not running", ->
        Kona.Engine.running = false
        fn = -> return "Hello World!"
        Kona.Engine.queue(fn)
        expect(Kona.Engine._queue).toContain(fn)


      it "executes functions if running", ->
        # Hacky exception to make sure function executes
        Kona.Engine.running = true
        fn = -> throw new Error("Hello World!")
        expect(->
          Kona.Engine.queue(fn)
        ).toThrow()



    describe "::start", ->
      beforeEach -> spyOn(Kona.Engine, 'run')

      # TODO: this test is gross
      # not sure how to guarantee failure case runs before scene defined
      it "throws an exception and then starts successfully", ->
        expect(->
          Kona.Engine.start()
        ).toThrow()

        engineScene = new Kona.Scene { name: 'engineScene', active: true }
        Kona.Engine.start()
        expect(Kona.Engine.running).toBe(true)


      it "flushes the queue", ->
        Kona.Engine.running = false
        fn = -> throw new Error("Hello World!")
        Kona.Engine.queue(fn)
        expect(->
          Kona.Engine.start()
        ).toThrow()


      it "calls run()", ->
        Kona.Engine._queue = []
        Kona.Engine.start()
        expect(Kona.Engine.run).toHaveBeenCalled()
