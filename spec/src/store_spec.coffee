Kona.ready ->

  describe "Kona.Store", ->
    # set get all concat

    describe "#set/#get", ->
      it "sets values correctly", ->
        store = new Kona.Store()
        expect(store.get('myKey')).toEqual []
        expect(store.set('myKey', 'myVal1')).toEqual ['myVal1']

      it "returns the value at the key set", ->
        store = new Kona.Store()
        expect(store.set('myKey', 'myVal1')).toEqual ['myVal1']
        expect(store.set('myKey', 'myVal2')).toEqual ['myVal1', 'myVal2']


    describe "#get", ->
      it "gets values correctly", ->
        store = new Kona.Store()
        expect(store.get('myKey')).toEqual []
        store.set('myKey', 'myVal1')
        expect(store.get('myKey')).toEqual ['myVal1']
        store.set('myKey', 'myVal2')
        expect(store.get('myKey')).toEqual ['myVal1', 'myVal2']

        store.set('otherKey', 2)
        expect(store.get('otherKey')).toEqual [2]

      it "returns empty array for blank key", ->
        store = new Kona.Store()
        expect(store.get('fakeKey')).toEqual []

      # it "concatenates values for multiple keys", ->
      #   store = new Kona.Store()
      #   store.set('myKey', 'myVal1')
      #   store.set('myKey', 'myVal2')
      #   store.set('otherKey', 'otherVal')
      #   expect(store.get('myKey', 'otherKey')).toEqual ['myVal1', 'myVal2', 'otherVal']
      #   expect(store.get('myKey', 'fakeKey')).toEqual ['myVal1', 'myVal2']


    describe "#all", ->
      it "returns the internal store", ->
        store = new Kona.Store()
        store.set('myKey', 'myVal1')
        store.set('myKey', 'myVal2')
        store.set('otherKey', 'otherVal')
        expect(store.all()).toEqual { 'myKey': ['myVal1', 'myVal2'], 'otherKey': ['otherVal']}


    describe "#concat", ->
      it "returns the concatenated entire store", ->
        store = new Kona.Store()
        store.set('myKey', 'myVal1')
        store.set('myKey', 'myVal2')
        store.set('otherKey', 'otherVal')
        store.set('anotherKey', 'anotherVal')
        expect(store.concat()).toEqual ['myVal1', 'myVal2', 'otherVal', 'anotherVal']
