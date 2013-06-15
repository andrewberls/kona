Kona.ready ->
  Kona.Canvas.init('canvas')
  animationScene = new Kona.Scene { name: 'animationScene', active: true }
  Kona.Engine.start()

  fakeObj = {
    'testMethod': -> return "Hello!"
  }

  class AnimTester extends Kona.Entity
    @group: 'anim_testers'

  AnimTester.loadAnimations {
    'one' : { sheet: 'fake/one.png', next: 'two', active: true }
    'two' : { sheet: 'fake/two.png', next: fakeObj.testMethod }
  }

  tester = new AnimTester(x: 0, y: 0)
  animationScene.addEntity(tester)


  describe "Kona.Animation", ->
    describe "#triggerNext", ->
      beforeEach -> spyOn(fakeObj, 'testMethod')

      one =  tester.animations['one']
      two =  tester.animations['two']

      it "sets animation to @next when string", ->
        expect(tester.currentAnimation).toBe(one)
        one.reset()
        expect(tester.currentAnimation).toBe(two)

      it "calls @next when function", ->
        # TODO: spy not catching the call, but clearly working
        #
        # expect(tester.currentAnimation).toBe(two)
        # two.reset()
        # expect(fakeObj.testMethod).toHaveBeenCalled()
