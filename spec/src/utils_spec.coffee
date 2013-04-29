Kona.ready ->

  describe "Kona.Utils", ->
    describe "::find", ->
      cars = [
        { color: 'red', owner: 'Jon' },
        { color: 'green', owner: 'Jane' }
        { color: 'red', owner: 'Bob' }
      ]

      it "returns first match", ->
        expect(Kona.Utils.find(cars, { 'color': 'red' })).toEqual({ color: 'red', owner: 'Jon' })

      it "returns null if no match found", ->
        expect(Kona.Utils.find(cars, { 'color': 'yellow' })).toBe(null)


    describe "::merge", ->
      it "gives precedence to obj2", ->
        obj1 = { 'a' : 100, 'b' : 200 }
        obj2 = { 'b' : 254, 'c' : 300 }
        expect(Kona.Utils.merge(obj1, obj2)).toEqual({ 'a' : 100, 'b' : 254, 'c' : 300 })

      it "gives precedence to obj1 when overwrite is false", ->
        obj1 = { 'a' : 100, 'b' : 200 }
        obj2 = { 'b' : 254, 'c' : 300 }
        expect(Kona.Utils.merge(obj1, obj2, false)).toEqual({ 'a' : 100, 'b' : 200, 'c' : 300 })


    describe "::sample", ->
      it "picks an element at random", ->
        arr = [1,2,3,4]
        expect([1,2,3,4]).toContain(Kona.Utils.sample(arr))



  describe "fail", ->
    it "throws an exception", ->
      expect(->
        fail("message")
      ).toThrow()



  describe "once", ->
    it "only calls the function once", ->
      foo = { bar: -> return "Hello World!" }
      spyOn(foo, 'bar')
      for num in [1..10]
        once -> foo.bar()
      expect(foo.bar.calls.length).toEqual(1)
